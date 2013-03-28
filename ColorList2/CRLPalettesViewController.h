//
//  CRLPalettesViewController.h
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRLPalettesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@end
