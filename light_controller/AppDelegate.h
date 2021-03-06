//
//  AppDelegate.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
#import "UserInfo.h"
#import "Protocol.h"
#import"Constant.h"
#import "SqlHelper.h"
#import "OtherTool.h"
//#define LOG_DEBUG
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//接口定义
@protocol MyAsyncSocketDelegate <NSObject>
@required
-(void)onConnectSuccessfully;
-(void)onConnectFailed;
-(void)onDisconnect;
@end
@protocol MyScrollPageDelegate <NSObject> //用于通知禁用滑动手势的接口
@required
-(void)onPageScrollEnable: (Boolean) enable;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,AsyncSocketDelegate>
{
    AsyncSocket *asyncSocket;
    Boolean isConnecting;
    id<MyAsyncSocketDelegate> delegate;
    Boolean isConnectedWithError;
    id<MyScrollPageDelegate> delegateForScrollPage;
    UIStoryboard *storyBoard;
    NSMutableArray* delegateList;
    SqlHelper *sqlhelper;
    UserInfo* userinfo_connecting;//保存一个正在连接的信息
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property id<MyAsyncSocketDelegate> delegate;
@property id<MyScrollPageDelegate> delegateForScrollPage;
@property Boolean isConnecting;
@property (strong, nonatomic) UIStoryboard *storyBoard;
- (Boolean)Connect:(NSString*) serverIp :(NSUInteger) port;
- (void)Disconnect;
- (void)write :(Byte*) data Size:(NSInteger) size;
- (void)control_toggle:(Byte) FLAG_UI LightNo:(NSInteger) lightNo LightState:(Boolean) lightState;
- (void)control_cool_or_warm_down:(Byte) status_increase IsCool:(Boolean) isCool;
- (void)control_cool_or_warm_up:(Byte) status_increase IsCool:(Boolean) isCool;
- (void)control_mode:(Byte) mode;
- (void)control_bright_dark:(Byte) status;
- (void)control_rgb:(Byte) colorValue;
- (void)notifyToEnableScrollPage: (Boolean) enable;
- (void)saveConnectInfo: (UserInfo*) userInfo;
- (UserInfo*)loadConnectInfo;
-(SqlHelper*) getdb;
- (UserInfo*) getConnectingInfo;
@end
