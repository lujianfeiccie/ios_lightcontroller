//
//  FourKeyButton.m
//  light_controller
//
//  Created by Apple on 13-10-9.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "FourKeyButton.h"

@implementation FourKeyButton
@synthesize leftMode;
@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    //NSLog(@"initWithCoder");
  
    leftMode = YES;//冷光
    //加入交互
    [self setUserInteractionEnabled:YES];
    
    //设置背景图
    NSString* image_name = [NSString stringWithFormat:@"four.png"];
    [self setImage:[UIImage imageNamed:image_name ]];
    
    //得到宽高
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    //得出半径
    radius = width / 2;
    
    center_button = [[UIImageView alloc]init];//中间按钮
   [center_button setImage:[UIImage imageNamed:@"center_w.png" ]];
    NSInteger center_width = 50,center_height = 50;//中间按钮大小
    NSInteger center_x = radius - center_width/2;
    NSInteger center_y = radius - center_height/2;
    [center_button setFrame:CGRectMake(center_x, center_y, center_width, center_height)];
    [center_button setUserInteractionEnabled:YES];
    [self addSubview:center_button];
    
    //得到中心点
    center =CGPointMake(radius, radius);
    
    IMAGE_UP = @"four_up.png";
    IMAGE_DOWN = @"four_down.png";
    IMAGE_LEFT = @"four_left.png";
    IMAGE_RIGHT = @"four_right.png";
    IMAGE_LEFT_UP = @"four_left_up.png";
    IMAGE_LEFT_DOWN = @"four_left_down.png";
    IMAGE_RIGHT_UP = @"four_right_up.png";
    IMAGE_RIGHT_DOWN = @"four_right_down.png";
    
    mApp=[[UIApplication sharedApplication] delegate];//用于通知主界面禁用/恢复手势
    
    if(IOS_VERSION<7){
        CGAffineTransform translate=CGAffineTransformMakeTranslation(0, -20);//上移20像素
        self.transform=translate;
    }
    return self;
}
- (void) setBgImage: (NSString*) imageName
{
    [self setImage:[UIImage imageNamed:imageName ]];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat x = point.x;
    CGFloat y = point.y;
    //NSLog(@"x:%f,y:%f",x,y);
    [mApp notifyToEnableScrollPage:NO];
    if([self isInRange:x:y] == NO){
        return;
    }
    if(delegate==Nil){
        return;
    }
    Boolean areaX = (x > width / 4 )&&(x < width * 3/4);
    Boolean areaY = (y > height / 4)&&(y < height * 3/4);
    if(areaX && y >0 && y< height/4){
        
       // NSLog(@"up");
        if(leftMode){
            [self setBgImage : IMAGE_LEFT_UP];
        }else{
            [self setBgImage : IMAGE_RIGHT_UP];
        }
        [delegate onUpTouchDown:leftMode];
    }else if(areaX && y >height *3/4 && y< height){
        
        //NSLog(@"down");
        if(leftMode){
           [self setBgImage : IMAGE_LEFT_DOWN];
        }else{
           [self setBgImage : IMAGE_RIGHT_DOWN];
        }
        [delegate onDownTouchDown:leftMode];
    }else if(areaY && x >0 && x< width/4){
        
        //NSLog(@"left");
        leftMode = YES;
        [self setBgImage : IMAGE_LEFT];
    }else if(areaY && x >width *3/4 && x< width){
        
        //NSLog(@"right");
        leftMode = NO;
        [self setBgImage : IMAGE_RIGHT];
    }

    // NSLog(@"touchesBegan");
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat x = point.x;
    CGFloat y = point.y;
    //NSLog(@"x:%f,y:%f",x,y);
    
    [mApp notifyToEnableScrollPage:YES];
    
    if([self isInRange:x:y] == NO){
        return;
    }
    
    Boolean areaX = (x > width / 4 )&&(x < width * 3/4);
    
    if(areaX && y >0 && y< height/4){
        
       // NSLog(@"up end");
        if(leftMode){
            [self setBgImage : IMAGE_LEFT];
        }else{
            [self setBgImage : IMAGE_RIGHT];
        }
        [delegate onUpTouchUp:leftMode];
    }else if(areaX && y >height *3/4 && y< height){
        
       // NSLog(@"down end");
        if(leftMode){
            [self setBgImage : IMAGE_LEFT];
        }else{
            [self setBgImage : IMAGE_RIGHT];
        }
        [delegate onDownTouchUp:leftMode];
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
   [self MyLog: @"drawRect"];
    
}


- (CGFloat) getDistance: (CGFloat) x :(CGFloat) y
{
    CGFloat result = 0.0f;
    
    CGFloat offsetX = abs(x - center.x);
    CGFloat offsetY = abs(y - center.y);
    
    result = sqrt(offsetX*offsetX + offsetY*offsetY);
    
    return result;
}
//在有效范围内
- (Boolean) isInRange: (CGFloat) x :(CGFloat) y
{
    Boolean result = NO;
    CGFloat distance = [ self getDistance:x : y];
    if(distance < radius){
        result = YES;
    }
    return result;
}

-(void) MyLog: (NSString*) msg{
    #if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
    #endif
}
@end
