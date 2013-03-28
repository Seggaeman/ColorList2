//
//  CRLUserDetailViewController.m
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLUserDetailViewController.h"
#import "CRLUser.h"

@interface CRLUserDetailViewController ()

@end

@implementation CRLUserDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //set info.
    [self.userNameLabel setText:self.userInstance.userName];
    [self.locationLabel setText:self.userInstance.location];
    [self.ratingLabel setText:[NSString stringWithFormat:@"%@",self.userInstance.rating]];
    [self.colourCountLabel setText:[NSString stringWithFormat:@"%@",self.userInstance.numColors]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
