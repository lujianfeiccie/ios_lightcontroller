//
//  SettingList.m
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "SettingList.h"
#import "CustomCell.h"
#import "PageSetting.h"
#import "SVProgressHUD.h"
@interface SettingList ()

@end

@implementation SettingList
@synthesize datalist;
@synthesize tableview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    [self MyLog:@"initWithNibName"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self MyLog:@"viewDidLoad"];
     mApp =[[UIApplication sharedApplication] delegate];
     mApp.delegate = self;
    
    //初始化背景
    UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BACKGROUND_IMAGE]];
    [self.view addSubview:customBackground];
    [self.view sendSubviewToBack:customBackground];
	

    //加入返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"PageSetting_Back", STRING_TABLE, nil) style:UIBarButtonItemStyleBordered target:self action:@selector(backClick)];
    [OtherTool setToolBarBtn:backButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //加入返回按钮
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
        style:UIBarButtonItemStyleBordered target:self action:@selector(addClick)];
    [OtherTool setToolBarBtn:addButton];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [[[mApp getdb] getDB] open];
    self.datalist =[[mApp getdb] getlist];
    [[[mApp getdb] getDB] close];
    [self MyLog:[NSString stringWithFormat:@"count=%i",[datalist count]]];
    tableview.delegate = self;
    tableview.dataSource = self;
}

-(void) viewDidLayoutSubviews{
    [tableview setFrame:CGRectMake(tableview.frame.origin.x,
                                  tableview.frame.origin.y,
                                  self.view.frame.size.width,
                                  self.view.frame.size.height)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self MyLog:@"didReceiveMemoryWarning"];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  //  [self MyLog:[NSString stringWithFormat:@"didReceiveMemoryWarning count=%d",[self.datalist count]]];
    return [self.datalist count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    //static BOOL nibsRegistered = NO;
   // if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
    //    nibsRegistered = YES;
   // }
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        
    NSUInteger row = [indexPath row];
    UserInfo *rowData = [self.datalist objectAtIndex:row];
    
     cell.name = rowData._name;
     cell.ip = rowData._ip;
    
    return cell;
}

-(GLfloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    [self MyLog:@"heightForRowAtIndexPath"];
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    selectedIndex = row;
    [self MyLog:[NSString stringWithFormat:@"didSelectRowAtIndexPath row=%i",row]];

    if ( alertView  != nil) {
         alertView  = nil;
    }
   
    if ([mApp isConnecting]) {
        alertView = [[CustomAlertView alloc]initWithType:TypeAlertViewTwoButtons];
        [alertView setTitle:[NSString stringWithFormat:@"%@ %@" , [[mApp getConnectingInfo] _ip]  ,NSLocalizedStringFromTable(@"SettingList_CurrentlyConnected",STRING_TABLE,nil)]];

    }else{
        alertView = [[CustomAlertView alloc]initWithType:TypeAlertViewFourButtons];
    }
    alertView.delegate = self;
   
    [alertView show];
   
    //alertView
}
- (void)backClick{
     [self MyLog:@"backClick"];
     mApp.delegate = nil;
    alertView = nil;
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)addClick{
    [self MyLog:@"addClick"];
    PageSetting *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"pagesetting"];
    next.typejump = TypeAdd;
    next.delegate = self;
    [[mApp navController] pushViewController:next animated:YES];
    next = nil;
}
-(void) onPageSettingResult: (UserInfo*) userinfo : (TypeJump) typejump{
    [self MyLog: [NSString stringWithFormat:@"onPageSettingResult=%@ typejump=%u",
                  userinfo.toString,
                  typejump]];
    switch (typejump) {
        case TypeAdd:
            [self MyLog:@"Add"];
            [[[mApp getdb] getDB ] open];
            [[mApp getdb] insert:userinfo];
            [[[mApp getdb] getDB ] close];
            break;
        case TypeEdit:
            [self MyLog:@"Update"];
             [[[mApp getdb] getDB ] open];
            [[mApp getdb] update:userinfo];
             [[[mApp getdb] getDB ] close];
            break;
        default:
            break;
    }
    [self updateTableView];
}
-(void)onAlertViewClick: (TypeClick) typeClick{
    switch (typeClick) {
        case TypeClickConnect:
        {
            [self MyLog:@"TypeClickConnect"];
            UserInfo* userinfo = [[self datalist] objectAtIndex:selectedIndex];
            [mApp Connect:userinfo._ip :[userinfo._port intValue]];
        }
            break;
        case TypeClickEdit:
        {
              [self MyLog:@"TypeClickEdit"];
            PageSetting *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"pagesetting"];
            next.typejump = TypeEdit;
            next.delegate = self;
            UserInfo* userinfo = [[self datalist] objectAtIndex:selectedIndex];
            next.userinfo = userinfo;
            [[mApp navController] pushViewController:next animated:YES];
        }
            break;
        case TypeClickDelete:
        {
            [self MyLog:@"TypeClickDelete"];
            UserInfo* userinfo = [[self datalist] objectAtIndex:selectedIndex];
            [[[mApp getdb] getDB] open];
            [[mApp getdb] delete:userinfo];
            [[[mApp getdb] getDB] close];
            [self updateTableView];
        }
            break;
        case TypeClickCancel:
              [self MyLog:@"TypeClickCancel"];
            break;
        case TypeClickDisconnect:
            [self MyLog:@"TypeClickDisconnect"];
            [mApp Disconnect];
            break;
        default:
            break;
    }
}
-(void) updateTableView{
    [[[mApp getdb] getDB] open];
     self.datalist = [[mApp getdb] getlist];
    [[[mApp getdb]getDB]close];
    [[self tableview] reloadData];
}
-(void)onConnectSuccessfully{
    [self MyLog:@"连接成功"];
    UserInfo* userinfo = [[self datalist] objectAtIndex:selectedIndex];
    
    [SVProgressHUD showSuccessWithStatus:NSLocalizedStringFromTable(@"PageSetting_Connect_Successfully", STRING_TABLE, nil)];
    
    [mApp saveConnectInfo:userinfo];
   // [self.navigationController popViewControllerAnimated:YES];//返回主界面
}
-(void)onConnectFailed{
    [self MyLog:@"连接失败"];
    [SVProgressHUD showErrorWithStatus:NSLocalizedStringFromTable(@"PageSetting_Connect_Failed", STRING_TABLE, nil)];
}
-(void)onDisconnect{
    [SVProgressHUD showSuccessWithStatus:NSLocalizedStringFromTable(@"PageSetting_Disconnect_Successfully", STRING_TABLE, nil)];
    //[self UpdateUI_forDisconnect];
}

-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end
