//
//  CRLViewController.h
//  ColorList2
//
//  Created by HDM Ltd on 3/27/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRLViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

-(IBAction)clickedRefresh:(id)sender;
@end
