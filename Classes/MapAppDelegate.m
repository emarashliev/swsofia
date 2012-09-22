//
//  SBMapWithRouteAppDelegate.m
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAppDelegate.h"
#import "RouteViewController.h"

@implementation MapAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
   	viewController = [[RouteViewController alloc]initWithNibName:@"RouteViewController" bundle:nil];
    
	navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    navigationController.navigationBarHidden = YES;
    
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
