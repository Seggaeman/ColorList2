//
//  CRLUserDetailViewController.h
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KANibHelper/KAViewController.h>

@class CRLUser;
@interface CRLUserDetailViewController : KAViewController

@property (strong,nonatomic) CRLUser* userInstance;
@property (weak,nonatomic) IBOutlet UILabel* userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* locationLabel;
@property (weak,nonatomic) IBOutlet UILabel* ratingLabel;
@property (weak,nonatomic) IBOutlet UILabel* colourCountLabel;
@end
