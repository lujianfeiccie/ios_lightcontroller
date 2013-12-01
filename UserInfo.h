//
//  UserInfo.h
//  light_controller
//
//  Created by Apple on 13-10-12.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>{
    NSString *_id;
    NSString *_ip;
    NSString *_port;
    NSString *_name;
}
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *_ip;
@property (nonatomic, retain) NSString *_port;
@property (nonatomic, retain) NSString *_name;
-(NSString*) toString;
@end
