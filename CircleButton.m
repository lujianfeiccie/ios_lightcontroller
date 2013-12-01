//
//  CircleButton.m
//  light_controller
//
//  Created by Apple on 13-10-10.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "CircleButton.h"

@implementation CircleButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    center_button_index = 0;
    
    rgb_mode = YES;//RGB模式，可以选择色盘颜色
    
    IMAGE_RGB = @"center_rpg.png";
    IMAGE_R   = @"center_r.png";
    IMAGE_G   = @"center_g.png";
    IMAGE_B   = @"center_b.png";
    
    center_button_Array =[ NSArray arrayWithObjects:IMAGE_RGB,IMAGE_R,IMAGE_G,IMAGE_B,nil];
    
    //加入交互
    [self setUserInteractionEnabled:YES];
    
    //得到宽高
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    //得出半径
    radius = width / 2;
    
    //得到中心点
    center =CGPointMake(radius, radius);
    
    [self setImage:[UIImage imageNamed:@"circle_back2.png" ]];

    small_circle = [[UIImageView alloc]init];//小圆点
    [small_circle setImage:[UIImage imageNamed:@"small_circle.png"]];
    [small_circle setFrame:CGRectMake(radius/2, radius/2, 10, 10)];
    
    center_button = [[UIImageView alloc]init];//中间按钮
    [self setCenterButtonBG: IMAGE_RGB];
    NSInteger center_width = 50,center_height = 50;//中间按钮大小
    NSInteger center_x = radius - center_width/2;
    NSInteger center_y = radius - center_height/2;
    [center_button setFrame:CGRectMake(center_x, center_y, center_width, center_height)];
    [center_button setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleSingleFingerEvent:)];
    [center_button addGestureRecognizer:singleFingerOne];
    [self addSubview:center_button];
    [self addSubview:small_circle];
    
     mApp=[[UIApplication sharedApplication] delegate];//用于通知主界面禁用/恢复手势
    
     [OtherTool adjustUI:self];
    return self;
}
- (void) setCenterButtonBG:(NSString*) imageName{
   [center_button setImage:[UIImage imageNamed:imageName] ];
}
//在有效范围内
- (Boolean) isInRange: (CGFloat) x :(CGFloat) y
{
    Boolean result = NO;
    CGFloat distance = [ self getDistance:x : y];
    if(distance < radius-5 && distance > radius/2){
        result = YES;
    }
    return result;
}
//处理单指事件
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    
    if(_delegate == nil){
        return;
    }
    if(sender.numberOfTapsRequired == 1) {

        ++center_button_index;
        center_button_index = center_button_index % 4;
        if(center_button_index == 0){
            rgb_mode = YES;
        }else{
            rgb_mode = NO;
        }
        switch (center_button_index) {
            case 1:
                [_delegate onCenterButtonClick:rgb_mode :R ];
                break;
            case 2:
                [_delegate onCenterButtonClick:rgb_mode :G ];
            case 3:
                [_delegate onCenterButtonClick:rgb_mode :B ];
            default:
                break;
        }
        
        [self setCenterButtonBG:[center_button_Array objectAtIndex:center_button_index]];
    }else if(sender.numberOfTapsRequired == 2){
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mApp notifyToEnableScrollPage:NO];
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    
    
    if(rgb_mode == NO){
        return;
    }
    
    //NSLog(@"x:%f,y:%f",x,y);
    if(_delegate == Nil){
        return;
    }
    
    if([self isInRange:x:y] == NO){
        return;
    }
    [self MyLog: @"isInRange"];
    
    [small_circle setFrame:CGRectMake(x,y, 10, 10)];
    
    /*if(delegate==Nil){
        return;
    }*/
    
    if(x-center.x == 0){
        if(y-center.y < 0){
 //           NSLog(@"0");
            [_delegate onAngleReceive:0.0f];
            return;
        }
        
        if(y-center.y>0){
//            NSLog(@"180");
            [_delegate onAngleReceive:180.0f];
            return;
        }
    }else if(y-center.y==0){
        if(x-center.x>0){
//            NSLog(@"90");
            [_delegate onAngleReceive:90.0f];
            return;
        }
        
        if(x-center.x<0){
//            NSLog(@"270");
            [_delegate onAngleReceive:270.0f];
            return;
        }
    }
    
    CGFloat opposite_side = abs(y - center.y);
    CGFloat adjacent_side = abs(x - center.x);
    CGFloat tan_value = opposite_side / adjacent_side;
    //NSLog(@"tan_value=%f",tan_value);
    CGFloat angle  = 0.0f;
    
    if(x-center.x>0){
        if(y-center.y<0){
            angle = [self getAngle:atan(1.0/tan_value) ];
            //NSLog(@"first %@",[NSString stringWithFormat:@"%f",angle]);
            [_delegate onAngleReceive:angle];
            return;
        }
        if(y-center.y>0){
             angle = 90.0 + [self getAngle:atan(tan_value) ];
            //NSLog(@"second %@",[NSString stringWithFormat:@"%f",90.0+angle]);
            [_delegate onAngleReceive:angle];
            return;
        }
    }
    
    if(x-center.x<0){
        if(y-center.y<0){
            angle = 270.0 + [self getAngle:atan(tan_value) ];
            //NSLog(@"four %@",[NSString stringWithFormat:@"%f",270.0+angle]);
            [_delegate onAngleReceive:angle];
            return;
        }
        if(y-center.y>0){
            angle = 180.0 + [self getAngle:atan(1.0/tan_value)];
            //NSLog(@"third %@",[NSString stringWithFormat:@"%f",180.0+angle]);
            [_delegate onAngleReceive:angle];
            return;
        }
    }
    // NSLog(@"touchesBegan");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mApp notifyToEnableScrollPage:YES];
}
-(CGFloat) getAngle: (CGFloat) radian{
    CGFloat result = 0.0f;
    result = 180.0f * radian / M_PI;
    return result;
}
- (CGFloat) getDistance: (CGFloat) x :(CGFloat) y
{
    CGFloat result = 0.0f;
    
    CGFloat offsetX = abs(x - center.x);
    CGFloat offsetY = abs(y - center.y);
    
    result = sqrt(offsetX*offsetX + offsetY*offsetY);
    
    return result;
}
-(void) MyLog: (NSString*) msg{
    #if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
    #endif
}
@end
