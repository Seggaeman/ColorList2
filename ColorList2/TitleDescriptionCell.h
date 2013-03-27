//
//  TitleDescriptionCell.h
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleDescriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* userNameLabel;
@property (weak, nonatomic) IBOutlet UIView* colorView;

@end
