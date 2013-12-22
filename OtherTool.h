//
//  OtherTool.h
//  light_controller
//
//  Created by Apple on 13-12-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))

@interface OtherTool : NSObject
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
+(void)adjustUI:(UIView*) view;
+(void)adjustUI_HaveNoNav:(UIView*) view;
+ (void) setToolBarBtn:(UIBarButtonItem*) btn;
+(void)adjustUI_ForScreenSize:(UIView*) view;
@end
