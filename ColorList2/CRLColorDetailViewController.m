//
//  CRLColorDetailViewController.m
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLColorDetailViewController.h"
#import "UIColor+HexString.h"
#import "URLBuilder.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSString+URLEncoding.h"
#import "CRLUser.h"
#import "CRLUserDetailViewController.h"

@interface CRLColorDetailViewController ()
@property (weak,nonatomic) IBOutlet UIView* colorView;
@property (weak,nonatomic) IBOutlet UILabel* colorViewLabel;
@property (weak,nonatomic) IBOutlet UILabel* titleLabel;
@property (weak,nonatomic) IBOutlet UILabel* userNameLabel;

-(void) displayUser:(CRLUser*)theUser;
@end

@implementation CRLColorDetailViewController

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
    [self.colorView setBackgroundColor:[UIColor colorWithHexString:self.colorInstance.colorString inverted:NO]];
    [self.colorViewLabel setTextColor:[UIColor colorWithHexString:self.colorInstance.colorString inverted:YES]];
    [self.colorViewLabel setText:[@"#" stringByAppendingString:self.colorInstance.colorString]];
    [self.titleLabel setText:self.colorInstance.title];
    [self.userNameLabel setText:self.colorInstance.userName];
    UIButton* theButton = (UIButton*)[self.view viewWithTag:1];
    UIImage* normalStateImage =[[UIImage imageNamed:@"button.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:20];
    UIImage* pressedStateImage= [[UIImage imageNamed:@"button_pressed.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:20];
    [theButton setBackgroundImage:normalStateImage forState:UIControlStateNormal];
    [theButton setBackgroundImage:pressedStateImage forState:UIControlStateHighlighted];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showDetailsButtonClick:(id)sender
{
    //Check if the entry exists
    ARLazyFetcher* fetcher = [[CRLUser lazyFetcher] whereField:@"userName" equalToValue:self.colorInstance.userName];
    NSArray* users= [fetcher fetchRecords];
    
    if ([users count] > 0)
    {
        [users enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CRLUser* colorOwner= (CRLUser*)obj;
            [self displayUser:colorOwner];
        }];
    }
    else
    {
        NSString* urlString = [@"http://www.colourlovers.com/api/lover/" stringByAppendingString:[self.colorInstance.userName urlEncodeUsingEncoding:NSUTF8StringEncoding]];
        urlString = [urlString stringByAppendingString:@"?format=json"];

        NSLog(@"%@", urlString);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^void(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [SVProgressHUD showSuccessWithStatus:@"Done"];
            //the JSON is a NSMutableArray containing one object. (Assume nevertheless that there can be several users)
            [(NSMutableArray*)JSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                CRLUser* colorOwner= [[CRLUser newRecord] initWithDictionary:(NSDictionary*)obj];
                [colorOwner save];
                [self displayUser:colorOwner];
            }];
        }
        failure:^void(NSURLRequest *request, NSHTTPURLResponse* response, NSError* error, id JSON) {
            [SVProgressHUD showErrorWithStatus:[error description]];
        }];
        [operation start];
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    }
}

-(void)displayUser:(CRLUser *)theUser
{
    CRLUserDetailViewController* leControlleur = [[CRLUserDetailViewController alloc] init];
    leControlleur.userInstance = theUser;
    [self.navigationController pushViewController:leControlleur animated:YES];
    /*
    NSString* details = [NSString stringWithFormat:@"Username: %@\nRating: %@\nLocation: %@\nNumColors: %@", theUser.userName, theUser.rating, theUser.location, theUser.numColors];
    UIAlertView* detailAlert = [[UIAlertView alloc] initWithTitle:@"Details" message:details delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [detailAlert show];
    */
}

@end
