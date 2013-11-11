//
//  OtherLabel.m
//  light_controller
//
//  Created by Apple on 13-11-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "OtherLabel.h"

@implementation OtherLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        if(IOS_VERSION<7){
            CGAffineTransform translate=CGAffineTransformMakeTranslation(0, -20);//上移20像素
            self.transform=translate;
        }
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
