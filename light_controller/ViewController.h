//
//  ViewController.h
//  light_controller
//
//  Created by Apple on 13-10-7.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController<UIScrollViewDelegate,MyScrollPageDelegate>
{
    AppDelegate *mApp;
}
@end
