//
//  Page1.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoKeyButton.h"
#import "FourKeyButton.h"
#import "AppDelegate.h"
@interface Page1 : UIViewController<TwoKeyButtonDelegate,FourKeyButtonDelegate>{
    AppDelegate *appDelegate;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn1;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn2;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn3;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn4;
- (IBAction)middleButtonClick:(id)sender;
- (IBAction)onbtnClick:(id)sender;
- (IBAction)offbtnClick:(id)sender;
- (IBAction)settingbtnClick:(id)sender;


@property (weak, nonatomic) IBOutlet FourKeyButton *fourkeybtn;
@end
