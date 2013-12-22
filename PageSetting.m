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
@synthesize userinfo;
@synthesize typejump;
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
           }
    [self MyLog:@"initWithNibName"];
    return self;
}
- (void) resetInput{
    _txtIP.text =@"";
    _txtPort.text = @"";
    _txtName.text=@"";
}

- (void) setInputValue: (NSString*) ip : (NSString*) port : (NSString*) name{
    _txtIP.text = ip;
    _txtPort.text = port;
    _txtName.text = name;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
        [self MyLog:@"viewDidLoad"];
	// Do any additional setup after loading the view.
    mApp =[[UIApplication sharedApplication] delegate];
    
    //初始化背景
    UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BACKGROUND_IMAGE]];
    [self.view addSubview:customBackground];
    [self.view sendSubviewToBack:customBackground];

   
    self.txtName.delegate = self;//处理键盘挡住textfield的情况
    switch (typejump) { //判断消息类型
        case TypeAdd:
            [self resetInput];
            break;
        case TypeEdit:
            if(userinfo!=Nil){
                [self setInputValue:userinfo._ip : userinfo._port : userinfo._name];
            }
            break;
        default:
            break;
    }
    
    //加入返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"PageSetting_Back", STRING_TABLE, nil) style:UIBarButtonItemStyleBordered target:self action:@selector(backbtnClick)];
    [OtherTool setToolBarBtn:backButton];
    self.navigationItem.leftBarButtonItem = backButton;
    

    //加入ok按钮
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"PageSetting_OK", STRING_TABLE, nil) style:UIBarButtonItemStyleBordered target:self action:@selector(savebtnClick)];
    [OtherTool setToolBarBtn:saveButton];
    self.navigationItem.rightBarButtonItem = saveButton;

    //点击别处隐藏keyboard的事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textfieldTouchUpOutside:)];
    [self.view addGestureRecognizer:singleTap];
    
   /* if([mApp isConnecting]){
        [self UpdateUI_forConnect];
        return;
    }
    [self UpdateUI_forDisconnect];*/
    
    
    //语言本地化
    self.lblIP.text = NSLocalizedStringFromTable(@"PageSetting_IP", STRING_TABLE,nil);
    self.lblPort.text =NSLocalizedStringFromTable(@"PageSetting_Port", STRING_TABLE,nil);
    
    //最大积分和最小积分使用数字键盘
    self.txtIP.keyboardType= UIKeyboardTypeDecimalPad;
    
    self.txtPort.keyboardType= UIKeyboardTypeNumberPad;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    [self MyLog:@"textFieldShouldReturn"];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
   
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
     [self MyLog:[NSString stringWithFormat:@"textFieldDidBeginEditing offset=%i width=%f height=%f",offset,width,height]];
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
-(IBAction)textfieldTouchUpOutside:(id)sender{
   // NSLog(@"textfieldTouchUpOutside");
    [self.txtIP resignFirstResponder];
    [self.txtName resignFirstResponder];
    [self.txtPort resignFirstResponder];
    
   
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    [self MyLog:[NSString stringWithFormat:@"textfieldTouchUpOutside offset=%i width=%f height=%f",offset,width,height]];

    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, offset-40,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
      [self MyLog:@"didReceiveMemoryWarning"];
}

- (void)backbtnClick{
    [self MyLog:@"backbtnClick"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)UpdateUI_forConnect{
   /* [_txtIP setEnabled:NO];
    [_txtPort setEnabled:NO];
    [_connectbtn setTitle:NSLocalizedStringFromTable(@"PageSetting_Disconnect", STRING_TABLE,nil)];*/
}
- (void)UpdateUI_forDisconnect{
    /*[_txtIP setEnabled:YES];
    [_txtPort setEnabled:YES];
    [_connectbtn setTitle:NSLocalizedStringFromTable(@"PageSetting_Connect", STRING_TABLE,nil)];*/
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
- (void)updateToModel{
    if (userinfo==nil) {
         userinfo = [[UserInfo alloc]init];
    }
    userinfo._ip = _txtIP.text;
    userinfo._port = _txtPort.text;
    userinfo._name = _txtName.text;
}
- (void)savebtnClick{
    [self MyLog:@"savebtnClick"];
    [self updateToModel];
    
    NSString *serverIp = _txtIP.text;
    NSString *serverPort = _txtPort.text;
    NSString *serverName = _txtName.text;
    //IP和端口和服务名称不能为空
    if([serverIp isEqualToString:@""] ||
       [serverPort isEqualToString:@""] ||
       [serverName isEqualToString:@""] ){
        UIAlertView* alertdlg = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"PageSetting_Tips", STRING_TABLE,nil) message:NSLocalizedStringFromTable(@"PageSetting_Ip_Port_Tips", STRING_TABLE,nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"PageSetting_OK", STRING_TABLE,nil) otherButtonTitles:nil, nil];
        [alertdlg show];
        alertdlg = nil;
        return;
    }
    //IP验证
    NSString *regexIp = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSString *regexPort = @"^[0-9]+$";
    
    //验证合法，插入数据库
    if([serverIp isMatchedByRegex:regexIp] &&
       [serverPort isMatchedByRegex:regexPort]){
        [self MyLog:@"Matched"];
        if (delegate!=Nil) {
            [delegate onPageSettingResult:userinfo : typejump];
            [self backbtnClick];
        }
    }else{
        [self MyLog:@"Not matched"];
        UIAlertView* alertdlg = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"PageSetting_Tips", STRING_TABLE,nil) message:NSLocalizedStringFromTable(@"PageSetting_Input_Invalid", STRING_TABLE, nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"PageSetting_OK", STRING_TABLE,nil) otherButtonTitles:nil, nil];
        [alertdlg show];
        alertdlg = nil;
    }

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
