//
//  SBMapWithRouteAppDelegate.h
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RouteViewController;

@interface MapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RouteViewController *viewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RouteViewController *viewController;

@end

