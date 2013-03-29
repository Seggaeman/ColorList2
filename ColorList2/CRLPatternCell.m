//
//  CRLPatternCell.m
//  ColorList2
//
//  Created by HDM Ltd on 3/29/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLPatternCell.h"

@implementation CRLPatternCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *nib= [[NSBundle mainBundle] loadNibNamed:@"CRLPatternCell" owner:self options:nil];
        self = nib[0];
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
