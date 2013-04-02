//
//  CRLColorDetailViewController.h
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRLColors.h"
#import <KANibHelper/KAViewController.h>

@interface CRLColorDetailViewController : KAViewController

@property (strong, nonatomic) CRLColors* colorInstance;

-(IBAction)showDetailsButtonClick:(id)sender;
@end
