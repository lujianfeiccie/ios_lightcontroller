//
//  PageSetting.m
//  light_controller
//
//  Created by Apple on 13-10-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "PageSetting.h"
#import "RegexKitLite.h"
#import "SVProgressHUD.h"
#import "UserInfo.h"
@interface PageSetting ()

@end

@implementation PageSetting

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    mApp =[[UIApplication sharedApplication] delegate];
    mApp.delegate=self;

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//读取用户信息
    NSData* udObject = [ud objectForKey:@"UserInfo"];
    UserInfo* mUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:udObject] ;
    if(mUserInfo!=Nil){
        _txtIP.text = mUserInfo._ip;
        _txtPort.text = mUserInfo._port;
    }
    
    if([mApp isConnecting]){
        [self UpdateUI_forConnect];
        return;
    }
    [self UpdateUI_forDisconnect];
    [mApp addDelegateForViewDidAppear: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backbtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)UpdateUI_forConnect{
    [_txtIP setEnabled:NO];
    [_txtPort setEnabled:NO];
    [_connectbtn setTitle:@"断开"];
}
- (void)UpdateUI_forDisconnect{
    [_txtIP setEnabled:YES];
    [_txtPort setEnabled:YES];
    [_connectbtn setTitle:@"连接"];
}
- (IBAction)connectbtnClick:(id)sender {
    if([mApp isConnecting]){
        [mApp Disconnect];
        return;
    }
    NSString *serverIp = _txtIP.text;
    NSString *serverPort = _txtPort.text;
    
    if([serverIp isEqualToString:@""] || [serverPort isEqualToString:@""]){
        UIAlertView* alertdlg = [[UIAlertView alloc]initWithTitle:@"提示" message:@"IP或端口不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertdlg show];
        alertdlg = nil;
        return;
    }
    
    NSString *regexIp = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSString *regexPort = @"^[0-9]+$";
    
    if([serverIp isMatchedByRegex:regexIp] &&
       [serverPort isMatchedByRegex:regexPort]){
        [self MyLog:@"Matched"];
        
       [mApp Connect:serverIp :[serverPort intValue]];
        
    }else{
        [self MyLog:@"Not matched"];
        UIAlertView* alertdlg = [[UIAlertView alloc]initWithTitle:@"提示" message:@"非法输入，请重来!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertdlg show];
        alertdlg = nil;
    }
}
-(void)onConnectSuccessfully{
    [self MyLog:@"连接成功"];
    NSString *serverIp = _txtIP.text;
    NSString *serverPort = _txtPort.text;

    
    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
    
    UserInfo* mUserInfo = [[UserInfo alloc] init]; //保存用户信息
    mUserInfo._ip =serverIp;
    mUserInfo._port = serverPort;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:mUserInfo];
    [ud setObject:udObject forKey:@"UserInfo"];
    
    [self.navigationController popViewControllerAnimated:YES];//返回主界面
}
-(void)onConnectFailed{
    [self MyLog:@"连接失败"];
    [SVProgressHUD showErrorWithStatus:@"连接失败"];
}
-(void)onDisconnect{
    [SVProgressHUD showSuccessWithStatus:@"断开成功"];
    [self UpdateUI_forDisconnect];
}
-(void) onMyViewDidAppear{
    [self MyLog:@"onMyViewDidAppear"];
   /* if(iPhone5){
        _toolbar.frame =CGRectMake(0, 23, _toolbar.frame.size.width, _toolbar.frame.size.height);
        //  NSLog(@"_toolbar bounds width=%f height=%f",_toolbar.frame.origin.x,_toolbar.frame.origin.y);
    }*/
}
-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end
