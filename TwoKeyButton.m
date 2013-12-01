//
//  TwoKeyButton.m
//  light_controller
//
//  Created by Apple on 13-10-8.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "TwoKeyButton.h"

@implementation TwoKeyButton
//对外接口
@synthesize enable = _enable;//是否打开
@synthesize btnID = _btnID;
@synthesize delegate = _delegate;

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
       _enable = NO;
    }
    
    [self addTarget:self action:@selector(butonPress) forControlEvents:UIControlEventTouchUpInside];

    [OtherTool adjustUI:self];
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (_enable == YES) {
        NSString* image_name = [NSString stringWithFormat:@"btn_on%i.png",_btnID];
        //NSLog(image_name,nil);
        [self setBackgroundImage:[UIImage imageNamed:image_name ]  forState:UIControlStateNormal];
    }else{
         NSString* image_name = [NSString stringWithFormat:@"btn_off%i.png",_btnID];
        [self setBackgroundImage:[UIImage imageNamed:image_name ]  forState:UIControlStateNormal];
       // NSLog(image_name,nil);
    }
}
-(void) butonPress{
    _enable = !_enable;
    [self setNeedsDisplay];
    if(_delegate!=Nil){
      [_delegate onTwoKeyButtonClick:_btnID :_enable];
    }
}

-(void) MyLog: (NSString*) msg{
    #if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
    #endif
}
@end
