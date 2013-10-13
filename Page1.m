//
//  Page1.m
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "Page1.h"
#import "Constant.h"
#import "AppDelegate.h"
@interface Page1 ()

@end

@implementation Page1

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
    _fourkeybtn.delegate = self;
    [_imageview setImage:[UIImage imageNamed:BACKGROUND_IMAGE]];
    mApp=[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTwoKeyButtonClick:(NSInteger) btnID :(Boolean) enable{
    NSLog(@"onTwoKeyButtonClick %@",[NSString stringWithFormat:@"btnID %i enable %i",btnID,enable]);
   // mApp.control_toggle(Protocol.FLAG_UI_COLOR, 1, btn_1.isStateOn());
     [mApp control_toggle:FLAG_UI_COLOR LightNo:btnID LightState:enable];
}

-(void)onUpTouchDown:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"up touchDown %hhu",leftMode],Nil);
    [mApp control_cool_or_warm_up:FLAG_FUNCTION_COOL_WARM_INCREASE IsCool:leftMode];//调亮按下
}
-(void)onUpTouchUp:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"up touchUp %hhu",leftMode],Nil);
     [mApp control_cool_or_warm_up:FLAG_FUNCTION_COOL_WARM_STOP IsCool:leftMode];//调亮抬起
}
-(void)onDownTouchDown:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"down touchDown %hhu",leftMode],Nil);
     [mApp control_cool_or_warm_down:FLAG_FUNCTION_COOL_WARM_INCREASE IsCool:leftMode];//调暗按下
}
-(void)onDownTouchUp:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"down touchUp %hhu",leftMode],Nil);
    [mApp control_cool_or_warm_down:FLAG_FUNCTION_COOL_WARM_STOP IsCool:leftMode];//调暗按下
}
- (IBAction)middleButtonClick:(id)sender {
    NSLog(@"middleButtonClick");
}

- (IBAction)onbtnClick:(id)sender {
    [mApp control_toggle:FLAG_UI_COLOR LightNo:0 LightState:YES];
}

- (IBAction)offbtnClick:(id)sender {
     [mApp control_toggle:FLAG_UI_COLOR LightNo:0 LightState:NO];
}

- (IBAction)settingbtnClick:(id)sender {
   // NSLog(@"settingclick");
        // 获取故事板中某个View
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"pagesetting"];
    
    [[mApp navController] pushViewController:next animated:YES];

}
/*
- (IBAction)settingbtnClick:(id)sender {
    // 获取故事板
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 获取故事板中某个View
    UIViewController *next = [board instantiateViewControllerWithIdentifier:@"pagesetting"];
    
    [self.navigationController pushViewController:next animated:YES];

}*/

@end
