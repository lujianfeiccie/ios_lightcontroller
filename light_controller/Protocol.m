//
//  Protocol.m
//  light_controller
//
//  Created by Apple on 13-10-13.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "Protocol.h"
 Byte const FLAG_HEADER = 0x4a;
 Byte const FLAG_TAIL = 0x6a;
 NSInteger const FLAG_CONTROL = 1;
 Byte const FLAG_UI_RGB = 0x01;
 Byte const FLAG_UI_COLOR = 0x02;
 Byte const FLAG_UI_MODE = 0x03;
 Byte const FLAG_FUNCTION_ONOFF_ON = 0x01;
 Byte const FLAG_FUNCTION_ONOFF_OFF = 0x00;
 Byte const FLAG_FUNCTION_ONOFF = 0x01;
 Byte const FLAG_FUNCTION_BRIGHTDARK = 0x02;
 Byte const FLAG_FUNCTION_BRIGHTUP = 0x01;
 Byte const FLAG_FUNCTION_BRIGHTDOWN = 0x00;
 Byte const FLAG_FUNCTION_COLOR = 0x03;
 Byte const FLAG_FUNCTION_COOL_WARM = 0x00;
 Byte const FLAG_FUNCTION_COOL_BRIGHT = 0x01;
 Byte const FLAG_FUNCTION_WARM_BRIGHT = 0x02;
 Byte const FLAG_FUNCTION_COOL_DARK = 0x03;
 Byte const FLAG_FUNCTION_WARM_DARK = 0x04;
 Byte const FLAG_FUNCTION_COOL_WARM_INCREASE = 0x01;
 Byte const FLAG_FUNCTION_COOL_WARM_STOP = 0x00;
 Byte const FLAG_FUNCTION_NIGHT = 0x01;
 Byte const FLAG_FUNCTION_MEETING = 0x02;
 Byte const FLAG_FUNCTION_READING = 0x03;
 Byte const FLAG_FUNCTION_MODE = 0x04;
 Byte const FLAG_FUNCTION_TIMER = 0x05;
 Byte const FLAG_FUNCTION_ALARM = 0x06;
 Byte const FLAG_FUNCTION_SLEEP = 0x07;
 Byte const FLAG_FUNCTION_RECREATION = 0x08;
 Byte const FLAG_EXIT = 0xff;
@implementation Protocol
@end
