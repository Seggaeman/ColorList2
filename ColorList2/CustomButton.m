//
//  CustomButton.m
//  ColorList2
//
//  Created by HDM Ltd on 3/29/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    UIImage* normalStateImage =[[UIImage imageNamed:@"button.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:20];
    UIImage* pressedStateImage= [[UIImage imageNamed:@"button_pressed.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:20];
    [self setBackgroundImage:normalStateImage forState:UIControlStateNormal];
    [self setBackgroundImage:pressedStateImage forState:UIControlStateHighlighted];
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
