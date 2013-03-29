//
//  CRLPalettesViewController.m
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLPalettesViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import "CRLPalettes.h"
#import "CRLPaletteCell.h"
#import "UIColor+HexString.h"
#import "URLBuilder.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface CRLPalettesViewController ()
{
    NSMutableArray* palettes;
}
@end

@implementation CRLPalettesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //NSLog(@"initing");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->palettes = [[CRLPalettes allRecords] mutableCopy];
    }
    return self;
}
-(id)init
{
    //NSLog(@"init");
    if (self= [super init])
    {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = TRUE;
    //self->colors = [[CRLPalettes allRecords] mutableCopy];
    //application was crashing when this was placed in initWithNibName:bundle:
    //possibly because self.tableView hasn't been generated yet at that point.
    [self.tableView registerNib:[UINib nibWithNibName:@"CRLPaletteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CRLPaletteCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CRLDummyPaletteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CRLDummyPaletteCell"];    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //NSLog(@"%d", [self->palettes count]);
    [self.navigationController setNavigationBarHidden:TRUE animated:YES];
    //retrieve text from standard user defaults
    NSUserDefaults* standards= [NSUserDefaults standardUserDefaults];
    NSString* previousValue= (NSString*)[standards objectForKey:@"paletteKeywords"];
    if (previousValue == nil)
        [self downloadJSONDataFromURL:@"http://www.colourlovers.com/api/palettes/new?format=json"];
    else
    {
        NSDictionary* argumentsDict= @{@"format":@"json", @"keywords":previousValue};
        NSString* urlString= [URLBuilder serializeURLString:@"http://www.colourlovers.com/api/palettes/new?" withArguments:argumentsDict];
        [self downloadJSONDataFromURL:urlString];
        [self.searchBar setText:previousValue];
    }
}

-(void)downloadJSONDataFromURL:(NSString *)theURL
{
    //download JSON only if content array is empty
    if ([self->palettes count] == 0)
    {
        NSURL *url = [NSURL URLWithString:theURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^void(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            //NSLog(@"%@", JSON); //the class is of type NSMutableArray. Apparently using SBJson won't be necessary.
            //save the color array.
            [(NSMutableArray*)JSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                CRLPalettes* paletteInstance = [[CRLPalettes newRecord] initWithDictionary:(NSDictionary*)obj];
                [paletteInstance save];
                [self->palettes addObject:paletteInstance];
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
    [self.tableView reloadData];
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
    return [self->palettes count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRLPalettes* thePalette = self->palettes[indexPath.row];
    
    CRLPaletteCell* theCell= [tableView dequeueReusableCellWithIdentifier:@"CRLPaletteCell"];
    CRLPaletteCell* theCell2 = [tableView dequeueReusableCellWithIdentifier:@"CRLDummyPaletteCell"];

    theCell.titleLabel.text = theCell2.titleLabel.text = thePalette.title;
    theCell.userNameLabel.text = theCell2.userNameLabel.text = thePalette.userName;
    
    [theCell.paletteView setImageWithURL:[NSURL URLWithString:thePalette.imageUrl] placeholderImage:nil];
    [theCell2.paletteView setImageWithURL:[NSURL URLWithString:thePalette.imageUrl] placeholderImage:nil];
    
    if ([thePalette.isSelected isEqualToNumber:[NSNumber numberWithInt:NO]])
    {
        theCell.selected = NO;
        //NSLog(@"not selected");
        return theCell;
    }
    else
    {
        theCell2.selected = YES;
        //NSLog(@"selected");
        return theCell2;
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRLPalettes* lePalet= self->palettes[indexPath.row];
    lePalet.isSelected = [NSNumber numberWithInt:YES];
    //[lePalet save];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRLPalettes* lePalet= self->palettes[indexPath.row];
    lePalet.isSelected = [NSNumber numberWithInt:NO];
    //[lePalet save];
}
#pragma mark - UISearchBarDelegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //register the text in standard user defaults
    NSUserDefaults* standards= [NSUserDefaults standardUserDefaults];
    [standards setObject:[searchBar text] forKey:@"paletteKeywords"];
    
    //NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"keywords"]);
    NSDictionary* argumentsDict= @{@"format":@"json", @"keywords":[searchBar text]};
    NSString* urlString= [URLBuilder serializeURLString:@"http://www.colourlovers.com/api/palettes/new?" withArguments:argumentsDict];
    
    [CRLPalettes dropAllRecords]; //clearDatabase deletes all the tables.
    [self->palettes removeAllObjects];
    [self downloadJSONDataFromURL:urlString];
    [searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
