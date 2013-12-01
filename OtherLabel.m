//
//  OtherLabel.m
//  light_controller
//
//  Created by Apple on 13-11-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "OtherLabel.h"

@implementation OtherLabel
@synthesize type;
-(id)init{
    self = [super init];
    [self MyLog:@"init"];
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self MyLog:[NSString stringWithFormat:@"initWithCoder=%i", type]];
    if (self) {
        // Initialization code
      /*  if(IOS_VERSION<7){
            CGAffineTransform translate=CGAffineTransformMakeTranslation(0, IOS_PLATFORM_Y_OFFSET);//上移20像素
            self.transform=translate;
        }else{
            CGAffineTransform translate=CGAffineTransformMakeTranslation(0,IOS7_PLATFORM_Y_OFFSET);//上移20像素
            self.transform=translate;
        }*/
         [OtherTool adjustUI:self];

       }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self MyLog:[NSString stringWithFormat:@"drawRect=%i", type]];
    // Initialization code
  
}*/

-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end
