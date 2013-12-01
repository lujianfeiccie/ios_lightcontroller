//
//  CustomCell.m
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize name;
@synthesize ip;

-(void) setName:(NSString *)_name{
    if(![_name isEqualToString:name]){
        name = [_name copy];
        self.lblname.text = name;
    }
}
-(void) setIp:(NSString *)_ip{
    if (![_ip isEqualToString:ip]) {
        ip = [_ip copy];
        self.lblip.text = ip;
    }
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
