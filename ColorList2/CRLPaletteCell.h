//
//  CRLPaletteCell.h
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRLPaletteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView* paletteView;
@property (weak, nonatomic) IBOutlet UIImageView* paletteViewDummy;

@end
