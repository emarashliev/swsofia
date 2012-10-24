//
//  SBMapWithRouteViewController.h
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class StorageObject;

@interface RouteViewController : UIViewController <UITextFieldDelegate>{

	UITextField			*txtFieldFrom;		//TextField for the Source city
	UITextField			*txtFieldTo;	//TextField for the Destination city1
	UIButton			*mLoadDirection;	//Button for moving in next controller ie. GoogleMapController
	NSMutableArray      *DestinationCityArray;
    StorageObject           *storageObject;
    
}
@property (nonatomic, retain) IBOutlet UITextField  *sourceCity;
@property (nonatomic, retain) IBOutlet UITextField  *destinationCity1;
@property (nonatomic, retain) IBOutlet UIButton     *loadDirection;
@property (nonatomic, retain) IBOutlet UIButton     *btnGetLocationCurrentFrom;
@property (nonatomic, retain) IBOutlet UIButton     *btnGetLocationCurrentTo;
@property (nonatomic, retain) IBOutlet UIImageView  *imgLogo;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

#pragma mark ButtonAction
- (IBAction)updateCurrentLocation;
- (IBAction)askForGeocoderUpdate;
- (IBAction)showGoogleMap:(id)sender;		//Action for moving in next controller ie. GoogleMapController

@end

