//
//  CRLAppDelegate.m
//  ColorList2
//
//  Created by HDM Ltd on 3/27/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLAppDelegate.h"
#import "CRLViewController.h"
#import "CRLPalettesViewController.h"

@implementation CRLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //[[NSBundle mainBundle] loadNibNamed:@"CRLTabBarController" owner:self options:nil];
    //self.window.rootViewController = self.tbController;
    
    //initialize color list view controller
    CRLViewController* colorListVC= [[CRLViewController alloc] initWithNibName:@"CRLViewController" bundle:[NSBundle mainBundle]];
    UINavigationController* colorListNav = [[UINavigationController alloc] initWithRootViewController:colorListVC];
    colorListNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Colors" image:nil tag:0];
    
    //initialize palette view controller
    CRLPalettesViewController*  paletteListVC= [[CRLPalettesViewController alloc] initWithNibName:@"CRLPalettesViewController" bundle:[NSBundle mainBundle]];
    UINavigationController* paletteListNav = [[UINavigationController alloc] initWithRootViewController:paletteListVC];
    paletteListNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Palettes" image:nil tag:0];
    
    self.tbController = [[UITabBarController alloc] init];
    self.tbController.viewControllers = @[colorListNav, paletteListNav];
    self.window.rootViewController = self.tbController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
