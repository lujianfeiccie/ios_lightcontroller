//
//  SqlHelper.h
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "UserInfo.h"
@interface SqlHelper : NSObject
{
    FMDatabase *db;
}
- (bool)createOrOpenDatabase;
- (bool)createTables;
- (FMDatabase*) getDB;
- (bool) insert:(UserInfo*) userinfo;
- (bool) delete:(UserInfo*) userinfo;
- (bool) update:(UserInfo*) userinfo;
- (NSMutableArray*) getlist;
@end
