//
//  PageSetting.h
//  light_controller
//
//  Created by Apple on 13-10-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface PageSetting : UIViewController<MyAsyncSocketDelegate,MyViewDidAppearDelegate>{
    AppDelegate *mApp;
}
- (IBAction)backbtnClick:(id)sender;
- (IBAction)connectbtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtIP;
@property (weak, nonatomic) IBOutlet UITextField *txtPort;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *connectbtn;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
