//
//  Page2.m
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "Page2.h"
#import "Constant.h"
#import "AppDelegate.h"
@interface Page2 ()

@end

@implementation Page2

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
    // Do any additional setup after loading the view from its nib.
    _twokeybtn1.delegate = self;
    _twokeybtn2.delegate = self;
    _twokeybtn3.delegate = self;
    _twokeybtn4.delegate = self;
    
    _centerButton.delegate = self;
    
    [_imageview setImage:[UIImage imageNamed:BACKGROUND_IMAGE]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTwoKeyButtonClick:(NSInteger) btnID :(Boolean) enable{
    NSLog(@"onTwoKeyButtonClick %@",[NSString stringWithFormat:@"btnID %i enable %i",btnID,enable]);
}
-(void)onAngleReceive:(CGFloat) angle{
    NSLog(@"angle receive %f",angle);
}
-(void)onCenterButtonClick:(Boolean) rgb_mode :(NSInteger) index{
    NSLog(@"%hhu %i",rgb_mode,index);
}
- (IBAction)onbtnClick:(id)sender {
}

- (IBAction)offbtnClick:(id)sender {
}

- (IBAction)brightUp:(id)sender {
}

- (IBAction)brightDown:(id)sender {
}

- (IBAction)settingbtnClick:(id)sender {
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"pagesetting"];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [[appDelegate navController] pushViewController:next animated:YES];
}
@end
