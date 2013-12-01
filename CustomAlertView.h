//
//  CustomAlertView.h
//  light_controller
//
//  Created by Apple on 13-12-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
typedef enum{
    TypeClickConnect,
    TypeClickEdit,
    TypeClickDelete,
    TypeClickCancel,
    TypeClickDisconnect
}TypeClick;

typedef enum{
    TypeAlertViewTwoButtons,
    TypeAlertViewFourButtons
}TypeAlertView;
@protocol CustomAlertViewDelegate <NSObject>
@required
-(void)onAlertViewClick: (TypeClick) typeClick;
@end

@interface CustomAlertView : UIAlertView<UIAlertViewDelegate>
{
    TypeAlertView typeAlertView;
}
@property id<CustomAlertViewDelegate> delegate;
-(id) initWithType : (TypeAlertView) _typeAlertView;
@end
