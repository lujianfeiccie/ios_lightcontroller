//
//  CustomAlertView.m
//  light_controller
//
//  Created by Apple on 13-12-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // self initWithTitle:<#(NSString *)#> message:<#(NSString *)#> delegate:<#(id)#> cancelButtonTitle:<#(NSString *)#> otherButtonTitles:<#(NSString *), ...#>, nil
       /* initWithTitle:NSLocalizedStringFromTable(@"PageSetting_Tips", STRING_TABLE,nil)
            message:NSLocalizedStringFromTable(@"PageSetting_Ip_Port_Tips", STRING_TABLE,nil)
            delegate:nil
           cancelButtonTitle:NSLocalizedStringFromTable(@"PageSetting_OK",
        STRING_TABLE,nil)
           otherButtonTitles:nil, nil];
        */
      
    }
    return self;
}
-(id) initWithType : (TypeAlertView) _typeAlertView{
    self = [super init];
    [self MyLog:@"init"];
    typeAlertView = _typeAlertView;
    if (self) {
        switch (typeAlertView) {
            case TypeAlertViewTwoButtons:
            {
                               
                [self addButtonWithTitle:NSLocalizedStringFromTable(@"PageSetting_Disconnect",
                                                                    STRING_TABLE,nil)];
                [self addButtonWithTitle:NSLocalizedStringFromTable(@"SettingList_Cancel",
                                                                    STRING_TABLE,nil)];
            }
                break;
            case TypeAlertViewFourButtons:
            {
                [self addButtonWithTitle:NSLocalizedStringFromTable(@"SettingList_Connect",
                                                                    STRING_TABLE,nil)];
                [self addButtonWithTitle:NSLocalizedStringFromTable(@"SettingList_Edit",
                                                                    STRING_TABLE,nil)];
                [self addButtonWithTitle:NSLocalizedStringFromTable(@"SettingList_Delete",
                                                                    STRING_TABLE,nil)];
                [self addButtonWithTitle:NSLocalizedStringFromTable(@"SettingList_Cancel",
                                                                    STRING_TABLE,nil)];
            }
                break;
            default:
                break;
        }
        super.delegate=self;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self MyLog:[NSString stringWithFormat:@"clickedButtonAtIndex=%i",buttonIndex]];
    if (delegate!=nil) {
        switch (typeAlertView) {
            case TypeAlertViewTwoButtons:
            {
                switch (buttonIndex) {
                    case 0:
                        [delegate onAlertViewClick:TypeClickDisconnect];
                        break;
                    case 1:
                        [delegate onAlertViewClick:TypeClickCancel];
                        break;
                    default:
                        break;
                }

            }
                break;
            case TypeAlertViewFourButtons:
            {
                switch (buttonIndex) {
                    case 0:
                        [delegate onAlertViewClick:TypeClickConnect];
                        break;
                    case 1:
                        [delegate onAlertViewClick:TypeClickEdit];
                        break;
                    case 2:
                        [delegate onAlertViewClick:TypeClickDelete];
                        break;
                    case 3:
                        [delegate onAlertViewClick:TypeClickCancel];
                        break;
                        
                    default:
                        break;
                }

            }
                break;
            default:
                break;
        }
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}

@end
