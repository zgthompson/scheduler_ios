// Zachary Thompson
//
//  AppDelegate.m
//  Scheduler
//
//  Created by student on 4/13/14.
//  Copyright (c) 2014 SSU. All rights reserved.
//

#import "AppDelegate.h"
#import "CourseSearchViewController.h"
#import "CourseFavoriteViewController.h"
#import "Meteor.h"
#import "ObjectiveDDP/MeteorClient.h"
#import "ObjectiveDDP/ObjectiveDDP.h"

@implementation AppDelegate {
    MeteorClient *mc;
    ObjectiveDDP *ddp;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CourseSearchViewController *searchController = [[CourseSearchViewController alloc] init];
    CourseFavoriteViewController *favoriteController = [[CourseFavoriteViewController alloc] init];
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    [tabController setViewControllers:@[searchController, favoriteController]];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabController];
    
    [self.window setRootViewController:nav];
    
    [self.window makeKeyAndVisible];
    
    [self connectToServer];

    return YES;
}

-(void) connectToServer {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reportConnection) name:MeteorClientDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reportDisconnection) name:MeteorClientDidDisconnectNotification object:nil];
    
    [[Meteor sharedInstance] connect];
}

- (void)reportConnection {
    NSLog(@"================> connected to server!");
}

- (void)reportDisconnection {
    NSLog(@"================> disconnected from server!");
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
