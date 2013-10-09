//
//  FourKeyButton.h
//  light_controller
//
//  Created by Apple on 13-10-9.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//接口定义
@protocol FourKeyButtonDelegate <NSObject>
@required
-(void)onUpTouchDown:(Boolean) leftMode;
-(void)onUpTouchUp:(Boolean) leftMode;
-(void)onDownTouchDown:(Boolean) leftMode;
-(void)onDownTouchUp:(Boolean) leftMode;
@end
@interface FourKeyButton : UIImageView
{
    NSInteger width;
    NSInteger height;
    NSInteger radius;
    CGPoint center;
    Boolean leftMode;
    //图片
    NSString* IMAGE_UP;
    NSString* IMAGE_DOWN;
    NSString* IMAGE_LEFT;
    NSString* IMAGE_RIGHT;
    NSString* IMAGE_LEFT_UP;
    NSString* IMAGE_LEFT_DOWN;
    NSString* IMAGE_RIGHT_UP;
    NSString* IMAGE_RIGHT_DOWN;
    
    id<FourKeyButtonDelegate> delegate;
}
@property Boolean leftMode;
@property(nonatomic,retain) id<FourKeyButtonDelegate> delegate;
@end
