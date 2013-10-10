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
@interface Page1 : UIViewController<TwoKeyButtonDelegate,FourKeyButtonDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn1;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn2;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn3;
@property (weak, nonatomic) IBOutlet TwoKeyButton *twokeybtn4;
- (IBAction)middleButtonClick:(id)sender;


@property (weak, nonatomic) IBOutlet FourKeyButton *fourkeybtn;

@end
