//
//  CRLPatternViewController.h
//  ColorList2
//
//  Created by HDM Ltd on 3/29/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRLPatternViewController : UIViewController <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak,nonatomic) IBOutlet UICollectionView* collectionView;
@property (weak,nonatomic) IBOutlet UISearchBar* searchBar;

@end
