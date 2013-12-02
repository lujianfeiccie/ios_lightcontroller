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
@synthesize delegateForScrollPage;
@synthesize storyBoard;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self MyLog:@"didFinishLaunchingWithOptions" ];

    delegateList = [[NSMutableArray alloc] init];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if(iPhone5){
        storyBoard=[UIStoryboard storyboardWithName:@"MainiPhone5" bundle:nil];
        [self MyLog:@"iPhone5"];
    }else{
        storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self MyLog:@"not iPhone5"];
    }
    
    //[self MyLog:[NSString stringWithFormat:@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]]];
    [self MyLog:[NSString stringWithFormat:@"%f",IOS_VERSION]];
    ViewController *rootView =  [storyBoard instantiateViewControllerWithIdentifier:@"rootview"];
    self.navController = [[UINavigationController alloc] init];
    [self.navController pushViewController:rootView animated:YES];
    [self.navController setToolbarHidden:YES];//底部隐藏
   // [self.navController setNavigationBarHidden:NO];//顶部 隐藏
   // self.navController.navigationBar.backgroundColor = [OtherTool //hexStringToColor:@"#000000"];
    //[[self.navController.navigationBar] setBackgroundImage:[UIImage //imageNamed:@"small_circle.png"]];
    [self.navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bar.png"] forBarMetrics:UIBarMetricsDefault];
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
    if (userinfo_connecting==nil) {
        userinfo_connecting = [[UserInfo alloc]init];
    }
    userinfo_connecting._ip = serverIp;
    userinfo_connecting._port = [NSString stringWithFormat:@"%i",port];
    @try {
         result = [asyncSocket connectToHost:serverIp onPort:port error:&err];
    }
    @catch (NSException *exception) {
        [self MyLog:[NSString stringWithFormat:@"exception:%@ err:%@",exception,err]];
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
    [self MyLog:@"applicationWillResignActive"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self MyLog:@"applicationDidEnterBackground"];
    [self Disconnect];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self MyLog:@"applicationWillEnterForeground"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self MyLog:@"applicationDidBecomeActive"];
    if (sqlhelper==Nil) {
        sqlhelper = [[SqlHelper alloc] init];
        [sqlhelper createOrOpenDatabase];
        [sqlhelper createTables];
    }
    [[sqlhelper getDB] close];
    UserInfo* mUserInfo = [self loadConnectInfo];
    
    if(mUserInfo!=Nil){
          userinfo_connecting = mUserInfo;
        [self Connect:mUserInfo._ip :[mUserInfo._port intValue]];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self MyLog:@"applicationWillTerminate"];

}

/**
 * In the event of an error, the socket is closed.
 * You may call "unreadData" during this call-back to get the last bit of data off the socket.
 * When connecting, this delegate method may be called
 * before"onSocket:didAcceptNewSocket:" or "onSocket:didConnectToHost:".
 **/
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    [self MyLog:@"willDisconnectWithError" ];
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
    [self MyLog:@"onSocketDidDisconnect" ];
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
       [self MyLog:@"didAcceptNewSocket" ];
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
    [self MyLog:@"onSocketWillConnect" ];

    return YES;
}

/**
 * Called when a socket connects and is ready for reading and writing.
 * The host parameter will be an IP address, not a DNS name.
 **/
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    [self MyLog:@"didConnectToHost" ];
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
    [self MyLog:@"didReadData" ];
}

/**
 * Called when a socket has read in data, but has not yet completed the read.
 * This would occur if using readToData: or readToLength: methods.
 * It may be used to for things such as updating progress bars.
 **/
- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    [self MyLog:@"didReadPartialDataOfLength" ];
}

/**
 * Called when a socket has completed writing the requested data. Not called if there is an error.
 **/
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [self MyLog:@"didWriteDataWithTag" ];
}

/**
 * Called when a socket has written some data, but has not yet completed the entire write.
 * It may be used to for things such as updating progress bars.
 **/
- (void)onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    [self MyLog:@"didWritePartialDataOfLength" ];
}




/**
 * Called after the socket has successfully completed SSL/TLS negotiation.
 * This method is not called unless you use the provided startTLS method.
 *
 * If a SSL/TLS negotiation fails (invalid certificate, etc) then the socket will immediately close,
 * and the onSocket:willDisconnectWithError: delegate method will be called with the specific SSL error code.
 **/
- (void)onSocketDidSecure:(AsyncSocket *)sock{
    [self MyLog:@"onSocketDidSecure" ];
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
- (void)notifyToEnableScrollPage: (Boolean) enable{
    if(delegateForScrollPage!=Nil){
        [delegateForScrollPage onPageScrollEnable:enable];
    }
}
- (void)addDelegateForViewDidAppear:(id<MyViewDidAppearDelegate>)delegateForViewDidAppear{
    [delegateList addObject:delegateForViewDidAppear];
}
- (void)removeDelegateForViewDidAppear:(id<MyViewDidAppearDelegate>)delegateForViewDidAppear{
    [delegateList removeObject:delegateForViewDidAppear];
}
- (void)notifyToViewDidAppear{
    for (id<MyViewDidAppearDelegate> temp in delegateList) {
        [temp onMyViewDidAppear];
    }
}
- (void)saveConnectInfo: (UserInfo*) userInfo
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [ud setObject:udObject forKey:@"UserInfo"];
}
- (UserInfo*)loadConnectInfo
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//读取用户信息
    NSData* udObject = [ud objectForKey:@"UserInfo"];
    UserInfo* mUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:udObject] ;
    return mUserInfo;
}
-(SqlHelper*) getdb{
    return  sqlhelper;
}
- (UserInfo*) getConnectingInfo{
    return userinfo_connecting;
}
-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end
