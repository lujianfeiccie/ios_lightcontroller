//
//  CircleButton.h
//  light_controller
//
//  Created by Apple on 13-10-10.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//接口定义
@protocol CircleButtonDelegate <NSObject>
@required
-(void)onAngleReceive:(CGFloat) angle;
-(void)onCenterButtonClick:(Boolean) rgb_mode :(NSInteger) index;
@end
@interface CircleButton : UIImageView
{
    CGPoint center;
    NSInteger radius;
    NSInteger width;
    NSInteger height;
    UIImageView* small_circle;
    UIImageView* center_button;
    NSString* IMAGE_RGB;
    NSString* IMAGE_R;
    NSString* IMAGE_G;
    NSString* IMAGE_B;
    NSArray *center_button_Array;
    Boolean rgb_mode;
    NSInteger center_button_index;
}
@property id<CircleButtonDelegate> delegate;
@end
