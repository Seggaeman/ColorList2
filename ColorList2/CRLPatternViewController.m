//
//  CRLPatternViewController.m
//  ColorList2
//
//  Created by HDM Ltd on 3/29/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLPatternViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import "CRLPattern.h"
#import "CRLPatternCell.h"
#import "UIColor+HexString.h"
#import "URLBuilder.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CRLPatternViewController ()
{
    NSMutableArray* patterns;
}
@end

@implementation CRLPatternViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //NSLog(@"initing");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self->patterns = [[CRLPattern allRecords] mutableCopy];
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
    //self->colors = [[CRLPattern allRecords] mutableCopy];
    //application was crashing when this was placed in initWithNibName:bundle:
    //possibly because self.collectionView hasn't been generated yet at that point.
    [self.collectionView registerClass:[CRLPatternCell class] forCellWithReuseIdentifier:@"CRLPatternCell"];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //NSLog(@"%d", [self->patterns count]);
    [self.navigationController setNavigationBarHidden:TRUE animated:YES];
    //retrieve text from standard user defaults
    NSUserDefaults* standards= [NSUserDefaults standardUserDefaults];
    NSString* previousValue= (NSString*)[standards objectForKey:@"patternKeywords"];
    if (previousValue == nil)
        [self downloadJSONDataFromURL:@"http://www.colourlovers.com/api/patterns/new?format=json"];
    else
    {
        NSDictionary* argumentsDict= @{@"format":@"json", @"keywords":previousValue};
        NSString* urlString= [URLBuilder serializeURLString:@"http://www.colourlovers.com/api/patterns/new?" withArguments:argumentsDict];
        [self downloadJSONDataFromURL:urlString];
        [self.searchBar setText:previousValue];
    }
}

-(void)downloadJSONDataFromURL:(NSString *)theURL
{
    //download JSON only if content array is empty
    if ([self->patterns count] == 0)
    {
        NSURL *url = [NSURL URLWithString:theURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^void(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            //NSLog(@"%@", JSON); //the class is of type NSMutableArray. Apparently using SBJson won't be necessary.
            //save the color array.
            [(NSMutableArray*)JSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                CRLPattern* paletteInstance = [[CRLPattern newRecord] initWithDictionary:(NSDictionary*)obj];
                [paletteInstance save];
                [self->patterns addObject:paletteInstance];
            }];
            [self.collectionView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"Done"];
        }
        failure:^void(NSURLRequest *request, NSHTTPURLResponse* response, NSError* error, id JSON) {
            [SVProgressHUD showErrorWithStatus:[error description]];
        }];
        [operation start];
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    }
    //[self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self->patterns count];
}

#pragma mark - UISearchBarDelegate methods
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CRLPattern* thePattern = self->patterns[indexPath.row];
    
    CRLPatternCell* laCellule= [collectionView dequeueReusableCellWithReuseIdentifier:@"CRLPatternCell" forIndexPath:indexPath];
    
    [laCellule.patternImage setImageWithURL:[NSURL URLWithString:thePattern.imageUrl]];
    
    return laCellule;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //register the text in standard user defaults
    NSUserDefaults* standards= [NSUserDefaults standardUserDefaults];
    [standards setObject:[searchBar text] forKey:@"patternKeywords"];
    
    //NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"keywords"]);
    NSDictionary* argumentsDict= @{@"format":@"json", @"keywords":[searchBar text]};
    NSString* urlString= [URLBuilder serializeURLString:@"http://www.colourlovers.com/api/patterns/new?" withArguments:argumentsDict];
    
    [CRLPattern dropAllRecords]; //clearDatabase deletes all the tables.
    [self->patterns removeAllObjects];
    [self downloadJSONDataFromURL:urlString];
    [searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
