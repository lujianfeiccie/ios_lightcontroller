//
//  AppDelegate.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,AsyncSocketDelegate>
{
    AsyncSocket *asyncSocket;
    Boolean isConnecting;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;

@property Boolean isConnecting;
- (Boolean)Connect:(NSString*) serverIp :(NSUInteger) port;
- (void)Disconnect;
- (void)write:(NSData*) data;
@end
