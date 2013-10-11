//
//  PageSetting.m
//  light_controller
//
//  Created by Apple on 13-10-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "PageSetting.h"
#import "RegexKitLite.h"
@interface PageSetting ()

@end

@implementation PageSetting

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backbtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)connectbtnClick:(id)sender {
    //组装一个字符串，把里面的网址解析出来
  NSString * username = @"192.168.1.256";
    NSString *pattern = @"\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b";
    //下面的代码一样的效果
    
    if([username isMatchedByRegex:pattern]){
        
        NSLog(@"Matched");
    }else{
        NSLog(@"Not matched");
    }
}
@end
