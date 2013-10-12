//
//  UserInfo.m
//  light_controller
//
//  Created by Apple on 13-10-12.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize _ip;
@synthesize _port;
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init])
    {
        self._ip = [aDecoder decodeObjectForKey:@"_ip"];
        self._port = [aDecoder decodeObjectForKey:@"_port"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_ip forKey:@"_ip"];
    [aCoder encodeObject:_port forKey:@"_port"];
}
@end
