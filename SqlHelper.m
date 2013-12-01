//
//  SqlHelper.m
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "SqlHelper.h"
#define DB_NAME (@"light.db")
#define TABLE_CONNECT_INFO (@"TB_CONNECT_INFO")

@implementation SqlHelper
//获得存放数据库文件的沙盒地址
- (bool)createOrOpenDatabase
{
    [self MyLog:@"createOrOpenDatabase"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:DB_NAME];
    
    db= [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        [self MyLog:@"Could not open db."];
        return NO;
    }
    return YES;
}
- (bool)createTables
{
    [self MyLog:@"createTables"];
   NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _name VARCHAR,_addr VARCHAR,_port INTEGER)",TABLE_CONNECT_INFO];
   return [db executeUpdate:sql];
}
- (FMDatabase*) getDB
{
    return db;
}
- (bool) insert:(UserInfo*) userinfo{
    [self MyLog:[NSString stringWithFormat:@"insert %@",userinfo.toString]];
   return [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(_name,_addr,_port) VALUES(?,?,?)",TABLE_CONNECT_INFO],[userinfo _name],[userinfo _ip],[userinfo _port]];
}
- (bool) delete:(UserInfo*) userinfo{
   return [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=?",TABLE_CONNECT_INFO],[userinfo _id]];
}
- (bool) update:(UserInfo*) userinfo{
    return [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET _name=?,_addr=?,_port=? WHERE _id=?",TABLE_CONNECT_INFO],[userinfo _name],[userinfo _ip],[userinfo _port],[userinfo _id]];
}
- (NSMutableArray*) getlist{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * from %@",TABLE_CONNECT_INFO]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
       
        UserInfo *userinfo = [[UserInfo alloc]init];
        userinfo._id = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_id"]];
        userinfo._ip =[rs stringForColumn:@"_addr"];
        userinfo._port = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_port"]];
        userinfo._name = [rs stringForColumn:@"_name"];
        [self MyLog:[NSString stringWithFormat:@"getlist=%@",userinfo.toString]];
        [list addObject:userinfo];
    }
    return list;
}
-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end