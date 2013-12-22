//
//  OtherTool.m
//  light_controller
//
//  Created by Apple on 13-12-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "OtherTool.h"
#import "AppDelegate.h"
#import "Constant.h"
@implementation OtherTool
//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
+(void)adjustUI:(UIView*) view{
    [view setFrame:CGRECT_HAVE_NAV(view.frame.origin.x,
                                   view.frame.origin.y,
                                   view.frame.size.width,
                                   view.frame.size.height)];
}
+(void)adjustUI_HaveNoNav:(UIView*) view{
    [view setFrame:CGRECT_NO_NAV(view.frame.origin.x,
                                   view.frame.origin.y,
                                   view.frame.size.width,
                                   view.frame.size.height)];
}
+ (void) setToolBarBtn:(UIBarButtonItem*) btn{
    [btn setBackgroundImage:[UIImage imageNamed:@"toolbar_btn.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"toolbar_btn_s.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    
    [btn setTintColor:[UIColor whiteColor]];
}
+(void)adjustUI_ForScreenSize:(UIView*) view{
    if(iPhone5){
        for (UIView *obj in view.subviews) {
            CGFloat y = (CGFloat)obj.frame.origin.y * (CGFloat)view.frame.size.height/480.0f;
            [obj setFrame:CGRectMake(obj.frame.origin.x,
                                     y,
                                     obj.frame.size.width,
                                     obj.frame.size.height)];
        }
    }
}
@end
