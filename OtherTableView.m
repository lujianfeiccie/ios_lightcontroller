//
//  OtherTableView.m
//  light_controller
//
//  Created by Apple on 13-12-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "OtherTableView.h"
#import "AppDelegate.h"
@implementation OtherTableView

- (id)initWithCoder:(NSCoder *)aDecoder{
      self = [super initWithCoder:aDecoder];
    // Initialization code
    if(IOS_VERSION<7){
        CGAffineTransform translate=CGAffineTransformMakeTranslation(0, IOS_PLATFORM_Y_OFFSET);//上移20像素
        self.transform=translate;
    }else{
         CGAffineTransform translate=CGAffineTransformMakeTranslation(0, IOS_PLATFORM_Y_OFFSET);//上移20像素
        self.transform=translate;
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

@end
