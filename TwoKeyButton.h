//
//  TwoKeyButton.h
//  light_controller
//
//  Created by Apple on 13-10-8.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//接口定义
@protocol TwoKeyButtonDelegate <NSObject>
@required
-(void)onTwoKeyButtonClick:(NSInteger) btnID :(Boolean) enable;
@end

@interface TwoKeyButton : UIButton
{
    id<TwoKeyButtonDelegate> delegate;
}
//对外接口
@property(nonatomic,retain) id<TwoKeyButtonDelegate> delegate;
@property Boolean enable;
@property NSInteger btnID;
@end
