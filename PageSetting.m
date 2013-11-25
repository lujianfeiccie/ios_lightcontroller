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

/*
 "PageSetting_Back"="Back";
 "PageSetting_IP"="IP";
 "PageSetting_Port"="Port";
 "PageSetting_Connect"="Connect";
 "PageSetting_Disconnect"="Disconnect";
 "PageSetting_Tips"="Tips";
 "PageSetting_Ip_Port_Tips"="IP and Port can not be empty!";
 "PageSetting_Input_Invalid"="Input invalid!";
 "PageSetting_OK"="OK";
 "PageSetting_Connect_Successfully"="Connect successfully!";
 "PageSetting_Connect_Failed"="Connect failed!";
 "PageSetting_Disconnect_Successfully"="Disconnect successfully!";
 */
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
    
    self.lblIP.text = NSLocalizedStringFromTable(@"PageSetting_IP", STRING_TABLE,nil);
    self.lblPort.text =NSLocalizedStringFromTable(@"PageSetting_Port", STRING_TABLE,nil);
    self.connectbtn.title =NSLocalizedStringFromTable(@"PageSetting_Connect", STRING_TABLE,nil);
    self.back.title = NSLocalizedStringFromTable(@"PageSetting_Back", STRING_TABLE, nil);

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
    [_connectbtn setTitle:NSLocalizedStringFromTable(@"PageSetting_Disconnect", STRING_TABLE,nil)];
}
- (void)UpdateUI_forDisconnect{
    [_txtIP setEnabled:YES];
    [_txtPort setEnabled:YES];
    [_connectbtn setTitle:NSLocalizedStringFromTable(@"PageSetting_Connect", STRING_TABLE,nil)];
}
- (IBAction)connectbtnClick:(id)sender {
    if([mApp isConnecting]){
        [mApp Disconnect];
        return;
    }
    NSString *serverIp = _txtIP.text;
    NSString *serverPort = _txtPort.text;
    
    if([serverIp isEqualToString:@""] || [serverPort isEqualToString:@""]){
        UIAlertView* alertdlg = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"PageSetting_Tips", STRING_TABLE,nil) message:NSLocalizedStringFromTable(@"PageSetting_Ip_Port_Tips", STRING_TABLE,nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"PageSetting_OK", STRING_TABLE,nil) otherButtonTitles:nil, nil];
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
        UIAlertView* alertdlg = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"PageSetting_Tips", STRING_TABLE,nil) message:NSLocalizedStringFromTable(@"PageSetting_Input_Invalid", STRING_TABLE, nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"PageSetting_OK", STRING_TABLE,nil) otherButtonTitles:nil, nil];
        [alertdlg show];
        alertdlg = nil;
    }
}
-(void)onConnectSuccessfully{
    [self MyLog:@"连接成功"];
    NSString *serverIp = _txtIP.text;
    NSString *serverPort = _txtPort.text;

    
    [SVProgressHUD showSuccessWithStatus:NSLocalizedStringFromTable(@"PageSetting_Connect_Successfully", STRING_TABLE, nil)];
    
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
    [SVProgressHUD showErrorWithStatus:NSLocalizedStringFromTable(@"PageSetting_Connect_Failed", STRING_TABLE, nil)];
}
-(void)onDisconnect{
    [SVProgressHUD showSuccessWithStatus:NSLocalizedStringFromTable(@"PageSetting_Disconnect_Successfully", STRING_TABLE, nil)];
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
