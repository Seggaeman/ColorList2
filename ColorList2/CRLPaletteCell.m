//
//  CRLPaletteCell.m
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLPaletteCell.h"

@implementation CRLPaletteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //NSArray *nib= [[NSBundle mainBundle] loadNibNamed:@"CRLPaletteCell" owner:self options:nil];
        //self = nib[0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected == TRUE)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        self.paletteView.frame= CGRectMake(0.0, 0.0, 320.0, 60.0);
        //[UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        self.paletteView.frame= CGRectMake(260.0, 0.0, 60.0, 60.0);
        [UIView commitAnimations];
    }
}
@end