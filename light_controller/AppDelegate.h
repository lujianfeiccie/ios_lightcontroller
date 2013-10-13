//
//  AppDelegate.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
#import "Protocol.h"
//接口定义
@protocol MyAsyncSocketDelegate <NSObject>
@required
-(void)onConnectSuccessfully;
-(void)onConnectFailed;
-(void)onDisconnect;
@end
@interface AppDelegate : UIResponder <UIApplicationDelegate,AsyncSocketDelegate>
{
    AsyncSocket *asyncSocket;
    Boolean isConnecting;
    id<MyAsyncSocketDelegate> delegate;
    Boolean isConnectedWithError;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property id<MyAsyncSocketDelegate> delegate;
@property Boolean isConnecting;
- (Boolean)Connect:(NSString*) serverIp :(NSUInteger) port;
- (void)Disconnect;
- (void)write :(Byte*) data Size:(NSInteger) size;
- (void)control_toggle:(Byte) FLAG_UI LightNo:(NSInteger) lightNo LightState:(Boolean) lightState;
- (void)control_cool_or_warm_down:(Byte) status_increase IsCool:(Boolean) isCool;
- (void)control_cool_or_warm_up:(Byte) status_increase IsCool:(Boolean) isCool;
- (void)control_mode:(Byte) mode;
- (void)control_bright_dark:(Byte) status;
- (void)control_rgb:(Byte) colorValue;
@end
