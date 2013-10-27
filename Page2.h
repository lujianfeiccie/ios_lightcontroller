//
//  Page2.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoKeyButton.h"
#import "CircleButton.h"
#import "AppDelegate.h"
@interface Page2 : UIViewController<TwoKeyButtonDelegate,
CircleButtonDelegate,
MyViewDidAppearDelegate>
{
    AppDelegate *mApp;
}
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn1;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn2;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn3;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn4;
@property (weak, nonatomic) IBOutlet CircleButton *centerButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)onbtnClick:(id)sender;
- (IBAction)offbtnClick:(id)sender;
- (IBAction)brightUp:(id)sender;
- (IBAction)brightDown:(id)sender;
- (IBAction)settingbtnClick:(id)sender;


@end
