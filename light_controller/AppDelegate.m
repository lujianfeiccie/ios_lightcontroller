//
//  AppDelegate.m
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@implementation AppDelegate
@synthesize isConnecting;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *rootView =  [storyBoard instantiateViewControllerWithIdentifier:@"rootview"];
    self.navController = [[UINavigationController alloc] init];
    [self.navController pushViewController:rootView animated:YES];
    [self.navController setToolbarHidden:YES];//底部隐藏
    [self.navController setNavigationBarHidden:YES];//顶部 隐藏
    [self.window addSubview:self.navController.view];
    [self.window makeKeyAndVisible];
    
    asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    isConnecting = NO;
    NSLog(@"didFinishLaunchingWithOptions");
    return YES;
}
- (void)write:(NSData*) data{
    if(isConnecting==YES){
        [asyncSocket writeData:data withTimeout:1 tag:1];
    };
}
- (Boolean)Connect:(NSString*) serverIp :(NSUInteger) port{
    NSError *err = nil;
    if([asyncSocket connectToHost:serverIp onPort:port error:&err]){
        isConnecting = YES;
        return YES;
    }
    NSLog(@"Error: %@", err);
    isConnecting = NO;
    return NO;
}
- (void)Disconnect{
    [asyncSocket disconnect];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

/**
 * In the event of an error, the socket is closed.
 * You may call "unreadData" during this call-back to get the last bit of data off the socket.
 * When connecting, this delegate method may be called
 * before"onSocket:didAcceptNewSocket:" or "onSocket:didConnectToHost:".
 **/
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    [self log:@"willDisconnectWithError" ];
}

/**
 * Called when a socket disconnects with or without error.  If you want to release a socket after it disconnects,
 * do so here. It is not safe to do that during "onSocket:willDisconnectWithError:".
 *
 * If you call the disconnect method, and the socket wasn't already disconnected,
 * this delegate method will be called before the disconnect method returns.
 **/
- (void)onSocketDidDisconnect:(AsyncSocket *)sock{
    [self log:@"onSocketDidDisconnect" ];
    isConnecting = NO;
}

/**
 * Called when a socket accepts a connection.  Another socket is spawned to handle it. The new socket will have
 * the same delegate and will call "onSocket:didConnectToHost:port:".
 **/
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
       [self log:@"didAcceptNewSocket" ];
}



/**
 * Called when a socket is about to connect. This method should return YES to continue, or NO to abort.
 * If aborted, will result in AsyncSocketCanceledError.
 *
 * If the connectToHost:onPort:error: method was called, the delegate will be able to access and configure the
 * CFReadStream and CFWriteStream as desired prior to connection.
 *
 * If the connectToAddress:error: method was called, the delegate will be able to access and configure the
 * CFSocket and CFSocketNativeHandle (BSD socket) as desired prior to connection. You will be able to access and
 * configure the CFReadStream and CFWriteStream in the onSocket:didConnectToHost:port: method.
 **/
- (BOOL)onSocketWillConnect:(AsyncSocket *)sock{
    [self log:@"onSocketWillConnect" ];
    return YES;
}

/**
 * Called when a socket connects and is ready for reading and writing.
 * The host parameter will be an IP address, not a DNS name.
 **/
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    [self log:@"didConnectToHost" ];
    isConnecting = YES;
}

/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
 **/
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    [self log:@"didReadData" ];
}

/**
 * Called when a socket has read in data, but has not yet completed the read.
 * This would occur if using readToData: or readToLength: methods.
 * It may be used to for things such as updating progress bars.
 **/
- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    [self log:@"didReadPartialDataOfLength" ];
}

/**
 * Called when a socket has completed writing the requested data. Not called if there is an error.
 **/
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [self log:@"didWriteDataWithTag" ];
}

/**
 * Called when a socket has written some data, but has not yet completed the entire write.
 * It may be used to for things such as updating progress bars.
 **/
- (void)onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    [self log:@"didWritePartialDataOfLength" ];
}




/**
 * Called after the socket has successfully completed SSL/TLS negotiation.
 * This method is not called unless you use the provided startTLS method.
 *
 * If a SSL/TLS negotiation fails (invalid certificate, etc) then the socket will immediately close,
 * and the onSocket:willDisconnectWithError: delegate method will be called with the specific SSL error code.
 **/
- (void)onSocketDidSecure:(AsyncSocket *)sock{
    [self log:@"onSocketDidSecure" ];
}
- (void) log:(NSString*) msg{
    NSLog([NSString stringWithFormat:@"AppDelegate-%@",msg],Nil);
}
@end
