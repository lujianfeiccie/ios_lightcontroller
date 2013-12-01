//
//  UserInfo.m
//  light_controller
//
//  Created by Apple on 13-10-12.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize _id;
@synthesize _ip;
@synthesize _port;
@synthesize _name;
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init])
    {
        self._id = [aDecoder decodeObjectForKey:@"_id"];
        self._ip = [aDecoder decodeObjectForKey:@"_ip"];
        self._port = [aDecoder decodeObjectForKey:@"_port"];
        self._name = [aDecoder decodeObjectForKey:@"_name"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_id forKey:@"_id"];
    [aCoder encodeObject:_ip forKey:@"_ip"];
    [aCoder encodeObject:_port forKey:@"_port"];
    [aCoder encodeObject:_name forKey:@"_name"];
}
-(NSString*) toString{
    return [NSString stringWithFormat:@"id=%@ ip=%@ port=%@ name=%@",_id,_ip,_port,_name];
}
@end
