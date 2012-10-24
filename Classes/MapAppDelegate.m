//
//  SBMapWithRouteAppDelegate.m
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAppDelegate.h"
#import "RouteViewController.h"
#import "StorageObject.h"

@implementation MapAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[RouteViewController alloc] initWithNibName:@"RouteViewController" bundle:nil];
    
    navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    navigationController.navigationBarHidden = YES;
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    
    //Start Location services as fast as possible to get most acurate result in the root VC
    [StorageObject sharedStorageObject];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [viewController release];
	[navigationController release];
    
    [window release];
    [super dealloc];
}


@end
