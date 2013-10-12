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
    appDelegate=[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTwoKeyButtonClick:(NSInteger) btnID :(Boolean) enable{
    NSLog(@"onTwoKeyButtonClick %@",[NSString stringWithFormat:@"btnID %i enable %i",btnID,enable]);
}

-(void)onUpTouchDown:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"up touchDown %hhu",leftMode],Nil);
}
-(void)onUpTouchUp:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"up touchUp %hhu",leftMode],Nil);
}
-(void)onDownTouchDown:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"down touchDown %hhu",leftMode],Nil);
}
-(void)onDownTouchUp:(Boolean) leftMode{
    NSLog([NSString stringWithFormat:@"down touchUp %hhu",leftMode],Nil);
}
- (IBAction)middleButtonClick:(id)sender {
    NSLog(@"middleButtonClick");
}

- (IBAction)onbtnClick:(id)sender {
    Byte s = 0x0b;
    Byte byte[] = {0x0a,s};
    NSInteger length = sizeof(byte) / sizeof(Byte);
    NSLog(@"%i",length);
    NSData *data = [[NSData alloc] initWithBytes:byte length:length];
    [appDelegate write:data];
}

- (IBAction)offbtnClick:(id)sender {
}

- (IBAction)settingbtnClick:(id)sender {
   // NSLog(@"settingclick");
        // 获取故事板中某个View
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"pagesetting"];
    
    [[appDelegate navController] pushViewController:next animated:YES];

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
