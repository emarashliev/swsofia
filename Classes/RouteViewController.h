//
//  SBMapWithRouteViewController.h
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RouteViewController : UIViewController <UITextFieldDelegate>{

	UITextField			*txtFieldFrom;		//TextField for the Source city
	UITextField			*txtFieldTo;	//TextField for the Destination city1
	UIButton			*mLoadDirection;	//Button for moving in next controller ie. GoogleMapController
	NSMutableArray      *DestinationCityArray;
    
    CLLocationCoordinate2D coordinatesFrom;
    CLLocationCoordinate2D coordinatesTo;
    
    CLLocationManager *lm;
    CLGeocoder *geocoder;
}
@property (nonatomic, retain) IBOutlet UITextField  *sourceCity;
@property (nonatomic, retain) IBOutlet UITextField  *destinationCity1;
@property (nonatomic, retain) IBOutlet UIButton     *loadDirection;
@property (nonatomic, retain) IBOutlet UIButton     *btnGetLocationCurrentFrom;
@property (nonatomic, retain) IBOutlet UIButton     *btnGetLocationCurrentTo;
@property (nonatomic, retain) IBOutlet UIImageView  *imgLogo;

@property (nonatomic, retain) NSMutableArray        *DestinationCityArray;

#pragma mark ButtonAction
- (IBAction)getCurrentLocation:(UIButton*)sender;
- (IBAction)showGoogleMap:(id)sender;		//Action for moving in next controller ie. GoogleMapController

@end

