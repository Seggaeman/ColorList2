//
//  CRLViewController.h
//  ColorList2
//
//  Created by HDM Ltd on 3/27/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KANibHelper/KAViewController.h>

@interface CRLViewController : KAViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@end
