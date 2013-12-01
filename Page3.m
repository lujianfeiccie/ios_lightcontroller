//
//  Page3.m
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "Page3.h"
#import "Constant.h"
#import "AppDelegate.h"
@interface Page3 ()

@end

@implementation Page3

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
	// Do any additional setup after loading the view.
    _twokeybtn1.delegate = self;
    _twokeybtn2.delegate = self;
    _twokeybtn3.delegate = self;
    _twokeybtn4.delegate = self;
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
    [mApp control_toggle:FLAG_UI_MODE LightNo:btnID LightState:enable];
}
- (IBAction)onbtnClick:(id)sender {
    [self MyLog:@"onbtnClick"];
    [mApp control_toggle:FLAG_UI_MODE LightNo:0 LightState:YES];
}

- (IBAction)offbtnClick:(id)sender {
    [self MyLog:@"offbtnClick"];
    [mApp control_toggle:FLAG_UI_MODE LightNo:0 LightState:NO];
}


- (IBAction)night_modeClick:(id)sender {
    [self MyLog:@"night_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_NIGHT];
}

- (IBAction)meeting_modeClick:(id)sender {
    [self MyLog:@"meeting_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_MEETING];
}

- (IBAction)reading_modeClick:(id)sender {
        [self MyLog:@"reading_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_READING];
}

- (IBAction)mode_modeClick:(id)sender {
           [self MyLog:@"mode_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_MODE];
}

- (IBAction)timer_modeClick:(id)sender {
     [self MyLog:@"timer_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_TIMER];
}

- (IBAction)alarm_modeClick:(id)sender {
         [self MyLog:@"alarm_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_ALARM];
}

- (IBAction)sleep_modeClick:(id)sender {
       [self MyLog:@"sleep_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_SLEEP];
}

- (IBAction)recreation_modeClick:(id)sender {
     [self MyLog:@"recreation_modeClick"];
    [mApp control_mode:FLAG_FUNCTION_RECREATION];
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
