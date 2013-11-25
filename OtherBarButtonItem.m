//
//  OtherBarButtonItem.m
//  light_controller
//
//  Created by Apple on 13-11-25.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "OtherBarButtonItem.h"

@implementation OtherBarButtonItem

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.title = NSLocalizedStringFromTable(@"Public_Setting", STRING_TABLE,nil);
    }
    return self;
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
