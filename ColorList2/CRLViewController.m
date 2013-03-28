//
//  CRLViewController.m
//  ColorList2
//
//  Created by HDM Ltd on 3/27/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import "CRLColors.h"
#import "TitleDescriptionCell.h"
#import "UIColor+HexString.h"
#import "CRLColorDetailViewController.h"
#import "URLBuilder.h"

@interface CRLViewController ()
{
    NSMutableArray* colors;
}

-(void)downloadJSONDataFromURL:(NSString*)theURL;
@end

@implementation CRLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->colors = [[CRLColors allRecords] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //application was crashing when this was placed in initWithNibName:bundle:
    //possibly because self.tableView hasn't been generated yet at that point.
    //[self.tableView registerNib:[UINib nibWithNibName:@"TitleDescriptionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TitleDescriptionCell"];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:TRUE animated:YES];
    //retrieve text from standard user defaults
    NSUserDefaults* standards= [NSUserDefaults standardUserDefaults];
    NSString* previousValue= (NSString*)[standards objectForKey:@"keywords"];
    if (previousValue == nil)
        [self downloadJSONDataFromURL:@"http://www.colourlovers.com/api/colors/new?format=json"];
    else
    {
        NSDictionary* argumentsDict= @{@"format":@"json", @"keywords":previousValue};
        NSString* urlString= [URLBuilder serializeURLString:@"http://www.colourlovers.com/api/colors/new?" withArguments:argumentsDict];
        [self downloadJSONDataFromURL:urlString];
        [self.searchBar setText:previousValue];
    }
}

-(void)downloadJSONDataFromURL:(NSString *)theURL
{
    //download JSON only if content array is empty
    if ([self->colors count] == 0)
    {
        NSURL *url = [NSURL URLWithString:theURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^void(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSLog(@"%@", JSON); //the class is of type NSMutableArray. Apparently using SBJson won't be necessary.
            //save the color array.
            [(NSMutableArray*)JSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                CRLColors* colorInstance = [[CRLColors newRecord] initWithDictionary:(NSDictionary*)obj];
                [colorInstance save];
                [self->colors addObject:colorInstance];
            }];
            [self.tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"Done"];
        }
        failure:^void(NSURLRequest *request, NSHTTPURLResponse* response, NSError* error, id JSON) {
            [SVProgressHUD showErrorWithStatus:[error description]];
        }];
        [operation start];
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->colors count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRLColors* theColor = self->colors[indexPath.row];
    
    TitleDescriptionCell* theCell= [tableView dequeueReusableCellWithIdentifier:@"TitleDescriptionCell"];
    
    if(theCell == nil)
    {
        theCell = [[TitleDescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDescriptionCell"];
    }
    theCell.titleLabel.text = theColor.title;
    theCell.userNameLabel.text = theColor.userName;
    [theCell.colorView setBackgroundColor:[UIColor colorWithHexString:theColor.colorString inverted:NO]];
    
    return theCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRLColors* colorInst= self->colors[indexPath.row];
    CRLColorDetailViewController* leControlleur= [[CRLColorDetailViewController alloc] init];
    leControlleur.colorInstance = colorInst;
    [self.navigationController pushViewController:leControlleur animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchBarDelegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //register the text in standard user defaults
    NSUserDefaults* standards= [NSUserDefaults standardUserDefaults];
    [standards setObject:[searchBar text] forKey:@"keywords"];

    //NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"keywords"]);
    NSDictionary* argumentsDict= @{@"format":@"json", @"keywords":[searchBar text]};
    NSString* urlString= [URLBuilder serializeURLString:@"http://www.colourlovers.com/api/colors/new?" withArguments:argumentsDict];
    
    [CRLColors clearDatabase];
    [self->colors removeAllObjects];
    [self downloadJSONDataFromURL:urlString];
    [searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
@end
