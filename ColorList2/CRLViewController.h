//
//  CRLViewController.h
//  ColorList2
//
//  Created by HDM Ltd on 3/27/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRLViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* colors;
}

@property (weak, nonatomic) IBOutlet UITableView* tableView;


@end
