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
     mApp=[[UIApplication sharedApplication] delegate];
    
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
    [mApp control_toggle:FLAG_UI_RGB LightNo:btnID LightState:enable];
}
-(void)onAngleReceive:(CGFloat) angle{
    [self MyLog:[NSString stringWithFormat:@"angle receive %f",angle]];
    NSInteger angleDistance = 29;
    if (angle >= 0 && angle <= angleDistance) {
        //1
        [self MyLog:@"1"];
        [mApp control_rgb:0x09];
    }else if (angle >= 30 && angle <= 30+angleDistance){
        //2
        [self MyLog:@"2"];
        [mApp control_rgb:0x08];
    }else if (angle >= 60 && angle <= 60+angleDistance){
        //3
        [self MyLog:@"3"];
        [mApp control_rgb:0x07];
    }else if (angle >= 90 && angle <= 90+angleDistance){
        //4
        [self MyLog:@"4"];
        [mApp control_rgb:0x06];
    }else if (angle >= 120 && angle <= 120+angleDistance){
        //5
        [self MyLog:@"5"];
        [mApp control_rgb:0x05];
    }else if (angle >= 150 && angle <= 150+angleDistance){
        //6
        [self MyLog:@"6"];
        [mApp control_rgb:0x04];
    }else if (angle >= 180 && angle <= 180+angleDistance){
        //7
        [self MyLog:@"7"];
        [mApp control_rgb:0x03];
    }else if (angle >= 210 && angle <= 210+angleDistance){
        //8
        [self MyLog:@"8"];
        [mApp control_rgb:0x02];
    }else if (angle >= 240 && angle <= 240+angleDistance){
        //9
        [self MyLog:@"9 red"];
        [mApp control_rgb:0x01];
    }else if (angle >= 270 && angle <= 270+angleDistance){
        //10
        [self MyLog:@"10"];
         [mApp control_rgb:0x0c];
    }else if (angle >= 300 && angle <= 300+angleDistance){
        //11
        [self MyLog:@"11"];
         [mApp control_rgb:0x0b];
    }else if (angle >= 330 && angle <= 330+angleDistance){
        //12
        [self MyLog:@"12"];
         [mApp control_rgb:0x0a];
    }
}
-(void)onCenterButtonClick:(Boolean) rgb_mode :(RGBIndex) index{
    [self MyLog:[NSString stringWithFormat:@"%hhu %i",rgb_mode,index]];
    if (rgb_mode == NO) {
        switch (index) {
            case R:
                [mApp control_rgb:0x01];
                break;
            case G:
                [mApp control_rgb:0x05];
                break;
            case B:
                [mApp control_rgb:0x09];
                break;
            default:
                break;
        }
    }
}
- (IBAction)onbtnClick:(id)sender {
     [mApp control_toggle:FLAG_UI_RGB LightNo:0 LightState:YES];
}

- (IBAction)offbtnClick:(id)sender {
     [mApp control_toggle:FLAG_UI_RGB LightNo:0 LightState:NO];
}

- (IBAction)brightUp:(id)sender {
    [mApp control_bright_dark:FLAG_FUNCTION_BRIGHTUP];
}

- (IBAction)brightDown:(id)sender {
     [mApp control_bright_dark:FLAG_FUNCTION_BRIGHTDOWN];
}

- (IBAction)settingbtnClick:(id)sender {
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"pagesetting"];
    [[mApp navController] pushViewController:next animated:YES];
}

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
