//
//  TitleDescriptionCell.m
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "TitleDescriptionCell.h"

@implementation TitleDescriptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"cell init");
        // Initialization code
        //NSArray *nib= [[NSBundle mainBundle] loadNibNamed:@"TitleDescriptionCell" owner:self options:nil];
        //self = nib[0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    //self.selectedBackgroundView.backgroundColor = self.colorView.backgroundColor;
}

@end
