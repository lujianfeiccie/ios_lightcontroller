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
    [self MyLog:@"initWithNibName"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self MyLog:@"viewDidLoad"];
    
    mApp=[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view from its nib.
    _twokeybtn1.delegate = self;
    _twokeybtn2.delegate = self;
    _twokeybtn3.delegate = self;
    _twokeybtn4.delegate = self;
    _fourkeybtn.delegate = self;
    
    
   
    
     UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BACKGROUND_IMAGE]];
    [self.view addSubview:customBackground];
    [self.view sendSubviewToBack:customBackground];

    [mApp addDelegateForViewDidAppear: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTwoKeyButtonClick:(NSInteger) btnID :(Boolean) enable{
    [self MyLog:[NSString stringWithFormat:@"onTwoKeyButtonClick btnID %i enable %i",btnID,enable]];
   // mApp.control_toggle(Protocol.FLAG_UI_COLOR, 1, btn_1.isStateOn());
     [mApp control_toggle:FLAG_UI_COLOR LightNo:btnID LightState:enable];
      _toolbar.frame =CGRectMake(0, 0, _toolbar.frame.size.width, _toolbar.frame.size.height);
}

-(void)onUpTouchDown:(Boolean) leftMode{
    [self MyLog:[NSString stringWithFormat:@"up touchDown %hhu",leftMode]];
    [mApp control_cool_or_warm_up:FLAG_FUNCTION_COOL_WARM_INCREASE IsCool:leftMode];//调亮按下
}
-(void)onUpTouchUp:(Boolean) leftMode{
    [self MyLog:[NSString stringWithFormat:@"up touchUp %hhu",leftMode]];
     [mApp control_cool_or_warm_up:FLAG_FUNCTION_COOL_WARM_STOP IsCool:leftMode];//调亮抬起
}
-(void)onDownTouchDown:(Boolean) leftMode{
    [self MyLog:[NSString stringWithFormat:@"down touchDown %hhu",leftMode]];
     [mApp control_cool_or_warm_down:FLAG_FUNCTION_COOL_WARM_INCREASE IsCool:leftMode];//调暗按下
}
-(void)onDownTouchUp:(Boolean) leftMode{
    [self MyLog:[NSString stringWithFormat:@"down touchUp %hhu",leftMode]];
    [mApp control_cool_or_warm_down:FLAG_FUNCTION_COOL_WARM_STOP IsCool:leftMode];//调暗按下
}
- (IBAction)middleButtonClick:(id)sender {
    [self MyLog:@"middleButtonClick"];
}

- (IBAction)onbtnClick:(id)sender {
    [self MyLog:[NSString stringWithFormat:@"onbtnClick"]];
    [mApp control_toggle:FLAG_UI_COLOR LightNo:0 LightState:YES];
}

- (IBAction)offbtnClick:(id)sender {
     [self MyLog:[NSString stringWithFormat:@"offbtnClick"]];
     [mApp control_toggle:FLAG_UI_COLOR LightNo:0 LightState:NO];
}

/*
- (IBAction)settingbtnClick:(id)sender {
    // 获取故事板
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 获取故事板中某个View
    UIViewController *next = [board instantiateViewControllerWithIdentifier:@"pagesetting"];
    
    [self.navigationController pushViewController:next animated:YES];

}*/
-(void) onMyViewDidAppear{
    [self MyLog:@"viewDidAppear"];
    if(iPhone5){
    _toolbar.frame =CGRectMake(0, 23, _toolbar.frame.size.width, _toolbar.frame.size.height);
  //  NSLog(@"_toolbar bounds width=%f height=%f",_toolbar.frame.origin.x,_toolbar.frame.origin.y);
    }
}
-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end
