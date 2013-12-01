//
//  OtherTool.h
//  light_controller
//
//  Created by Apple on 13-12-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherTool : NSObject
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
+(void)adjustUI:(UIView*) view;
@end
