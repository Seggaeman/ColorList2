//
//  TitleDescriptionCell.m
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "TitleDescriptionCell.h"
#import "UIColor+HexString.h"
@implementation TitleDescriptionCell
{
    UIColor* blackTextColor, *greyTextColor;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *nib= [[NSBundle mainBundle] loadNibNamed:@"TitleDescriptionCell" owner:self options:nil];
        self = nib[0];
        self->blackTextColor = self.titleLabel.textColor;
        self->greyTextColor = self.userNameLabel.textColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    // Configure the view for the selected state
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = self.colorView.backgroundColor;
    self.selectedBackgroundView = selectionColor;
    
    self.titleLabel.highlightedTextColor = self.userNameLabel.highlightedTextColor= [UIColor contrastAdaptedColor:self.colorView.backgroundColor];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
}
@end
