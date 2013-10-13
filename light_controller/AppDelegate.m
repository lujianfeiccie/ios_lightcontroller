//
//  AppDelegate.m
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UserInfo.h"
@implementation AppDelegate
@synthesize isConnecting;
@synthesize delegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self log:@"didFinishLaunchingWithOptions" ];

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
    isConnectedWithError = NO;
    return YES;
}
- (void)write :(Byte*) data Size:(NSInteger) size{
    if(isConnecting==YES){
       // [self log:[NSString stringWithFormat:@"length:%i",length]];
        NSData *nsdata = [[NSData alloc] initWithBytes:data length:size];
        [asyncSocket writeData:nsdata withTimeout:1 tag:1];
    };
}
- (Boolean)Connect:(NSString*) serverIp :(NSUInteger) port{
    NSError *err = nil;
    Boolean result;
    @try {
         result = [asyncSocket connectToHost:serverIp onPort:port error:&err];
    }
    @catch (NSException *exception) {
       NSLog(@"exception:%@ err:%@",exception,err); 
    }
    @finally {
        
    }
    return result;
}
- (void)Disconnect{
    isConnectedWithError = NO;
    [asyncSocket disconnect];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self log:@"applicationWillResignActive"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self log:@"applicationDidEnterBackground"];
    [self Disconnect];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self log:@"applicationWillEnterForeground"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self log:@"applicationDidBecomeActive"];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//读取用户信息
    NSData* udObject = [ud objectForKey:@"UserInfo"];
    UserInfo* mUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:udObject] ;
    if(mUserInfo!=Nil){
        [self Connect:mUserInfo._ip :[mUserInfo._port intValue]];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self log:@"applicationWillTerminate"];

}

/**
 * In the event of an error, the socket is closed.
 * You may call "unreadData" during this call-back to get the last bit of data off the socket.
 * When connecting, this delegate method may be called
 * before"onSocket:didAcceptNewSocket:" or "onSocket:didConnectToHost:".
 **/
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    [self log:@"willDisconnectWithError" ];
    isConnecting = NO;
    isConnectedWithError = YES;
    if(delegate!=nil){
        [delegate onConnectFailed];
    }
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
    if(isConnectedWithError == YES){
        return;
    }
    if(delegate!=Nil){
        [delegate onDisconnect];
    }
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
    if(delegate!=nil){
        [delegate onConnectSuccessfully];
    }
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
- (void)control_toggle:(Byte) FLAG_UI LightNo:(NSInteger) lightNo LightState:(Boolean) lightState{
        Byte data[]={
            FLAG_HEADER,
            FLAG_UI,
            FLAG_FUNCTION_ONOFF,
            lightNo,
            (lightState==YES?FLAG_FUNCTION_ONOFF_ON:FLAG_FUNCTION_ONOFF_OFF),
            FLAG_TAIL
        };
    int length = sizeof(data)/sizeof(Byte);
    [self write:data Size:length];
}
- (void)control_cool_or_warm_down:(Byte) status_increase IsCool:(Boolean) isCool{
    Byte data[] = {
     FLAG_HEADER,
     FLAG_UI_COLOR,
    (isCool==YES?FLAG_FUNCTION_COOL_DARK:FLAG_FUNCTION_WARM_DARK),
     0,
    status_increase,
    FLAG_TAIL};
    int length = sizeof(data)/sizeof(Byte);
    [self write:data Size:length];
}
- (void)control_cool_or_warm_up:(Byte) status_increase IsCool:(Boolean) isCool{
    Byte data[] = {
        FLAG_HEADER,
        FLAG_UI_COLOR,
        (isCool==YES?FLAG_FUNCTION_COOL_BRIGHT:FLAG_FUNCTION_WARM_BRIGHT),
        0,
        status_increase,
        FLAG_TAIL};
    int length = sizeof(data)/sizeof(Byte);
    [self write:data Size:length];
}
- (void)control_mode:(Byte) mode{
    Byte data[] = {
        FLAG_HEADER,
        FLAG_UI_MODE,
        mode,
        00,
        00,
        FLAG_TAIL};
    int length = sizeof(data)/sizeof(Byte);
    [self write:data Size:length];
}
- (void)control_bright_dark:(Byte) status{
    Byte data[] = {
        FLAG_HEADER,
        FLAG_UI_RGB,
        FLAG_FUNCTION_BRIGHTDARK,
        0,
        status,
        FLAG_TAIL};
    int length = sizeof(data)/sizeof(Byte);
    [self write:data Size:length];
}
- (void)control_rgb:(Byte) colorValue{
    Byte data[] = {
        FLAG_HEADER,
        FLAG_UI_RGB,
        FLAG_FUNCTION_COLOR,
        0,
        colorValue,
        FLAG_TAIL};
    int length = sizeof(data)/sizeof(Byte);
    [self write:data Size:length];
}
@end
