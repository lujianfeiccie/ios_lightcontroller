//
//  AppDelegate.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
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
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property id<MyAsyncSocketDelegate> delegate;
@property Boolean isConnecting;
- (Boolean)Connect:(NSString*) serverIp :(NSUInteger) port;
- (void)Disconnect;
- (void)write:(NSData*) data;
@end
