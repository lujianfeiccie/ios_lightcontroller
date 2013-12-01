//
//  SettingList.h
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PageSetting.h"
#import "CustomAlertView.h"
@interface SettingList : UIViewController<UITableViewDelegate,
UITableViewDataSource,
PageSettingDelegate,
CustomAlertViewDelegate,
MyAsyncSocketDelegate>{
      AppDelegate *mApp;
    NSUInteger selectedIndex;
    CustomAlertView* alertView;
}
@property (strong,nonatomic) NSMutableArray* datalist;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (void)backClick;
- (void)addClick;

@end
