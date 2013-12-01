//
//  Page3.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoKeyButton.h"
#import "AppDelegate.h"
@interface Page3 : UIViewController<TwoKeyButtonDelegate,MyViewDidAppearDelegate>
{
    AppDelegate *mApp;
}
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn1;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn2;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn3;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn4;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)onbtnClick:(id)sender;
- (IBAction)offbtnClick:(id)sender;
- (IBAction)night_modeClick:(id)sender;
- (IBAction)meeting_modeClick:(id)sender;
- (IBAction)reading_modeClick:(id)sender;
- (IBAction)mode_modeClick:(id)sender;
- (IBAction)timer_modeClick:(id)sender;
- (IBAction)alarm_modeClick:(id)sender;
- (IBAction)sleep_modeClick:(id)sender;
- (IBAction)recreation_modeClick:(id)sender;

@end
