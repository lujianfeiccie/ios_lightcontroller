//
//  PageSetting.h
//  light_controller
//
//  Created by Apple on 13-10-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//跳转界面类型
typedef enum {
    TypeAdd, //添加数据
    TypeEdit, //编辑数据
    TypeOK,  //确认
    TypeCancel //取消
} TypeJump;
@protocol PageSettingDelegate <NSObject>
-(void) onPageSettingResult: (UserInfo*) userinfo : (TypeJump) typejump;
@end

@interface PageSetting : UIViewController<
UITextFieldDelegate>{
    AppDelegate *mApp;
    int offset;//键盘上移偏移量
}
- (void)backbtnClick;
- (IBAction)connectbtnClick:(id)sender;
- (void)savebtnClick;
-(IBAction)textfieldTouchUpOutside:(id)sender;
@property UserInfo* userinfo;
@property TypeJump typejump;
@property (weak, nonatomic) IBOutlet UITextField *txtIP;
@property (weak, nonatomic) IBOutlet UITextField *txtPort;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UILabel *lblIP;
@property (weak, nonatomic) IBOutlet UILabel *lblPort;
@property id<PageSettingDelegate> delegate;
@end
