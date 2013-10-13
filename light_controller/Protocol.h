//
//  Protocol.h
//  light_controller
//
//  Created by Apple on 13-10-13.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
extern Byte const FLAG_HEADER;
extern Byte const FLAG_TAIL;
extern NSInteger const FLAG_CONTROL;
extern Byte const FLAG_UI_RGB ;
extern Byte const FLAG_UI_COLOR;
extern Byte const FLAG_UI_MODE;
extern Byte const FLAG_FUNCTION_ONOFF_ON;
extern Byte const FLAG_FUNCTION_ONOFF_OFF;
extern Byte const FLAG_FUNCTION_ONOFF;
extern Byte const FLAG_FUNCTION_BRIGHTDARK;
extern Byte const FLAG_FUNCTION_BRIGHTUP;
extern Byte const FLAG_FUNCTION_BRIGHTDOWN;
extern Byte const FLAG_FUNCTION_COLOR;
extern Byte const FLAG_FUNCTION_COOL_WARM;
extern Byte const FLAG_FUNCTION_COOL_BRIGHT;
extern Byte const FLAG_FUNCTION_WARM_BRIGHT;
extern Byte const FLAG_FUNCTION_COOL_DARK;
extern Byte const FLAG_FUNCTION_WARM_DARK;
extern Byte const FLAG_FUNCTION_COOL_WARM_INCREASE;
extern Byte const FLAG_FUNCTION_COOL_WARM_STOP;
extern Byte const FLAG_FUNCTION_NIGHT;
extern Byte const FLAG_FUNCTION_MEETING;
extern Byte const FLAG_FUNCTION_READING;
extern Byte const FLAG_FUNCTION_MODE;
extern Byte const FLAG_FUNCTION_TIMER;
extern Byte const FLAG_FUNCTION_ALARM;
extern Byte const FLAG_FUNCTION_SLEEP;
extern Byte const FLAG_FUNCTION_RECREATION;
extern Byte const FLAG_EXIT;
@interface Protocol : NSObject
@end
