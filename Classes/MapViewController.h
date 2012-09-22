//
//  SBGoogleMap.h
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICGDirections.h"
#import "UICGCheckPoint.h"

@class MapView;
@class MapAnnotation;
@class UICGRoutes ;
@class SBRouteDetailView;

@interface MapViewController : UIViewController <UICGDirectionsDelegate,UIWebViewDelegate>
{

	MapView*			mMap;				// An Instance of SBMapView which holds instance of MKMapView
	UICGDirections*		mDirections;		// An Instance of UICGDirections which gives the information of directions
	NSString*			mStartPoint;		// It will take the name of source city
	NSString*			mEndPoint;			// It will take the name of source city
	MapAnnotation*      mBetweenAnnotation;	// An Instance of SBRouteAnnotation which will give the annotations for checkpoints in the route. 
	UIBarButtonItem*    mLoadBtn;			// button for loading and removing annotations for checkpoints in the route. 
	NSMutableArray*		mAnnotationArray;	// An array of  annotations for checkpoints in the route.

}
@property (nonatomic,retain) MapView* map;
@property (nonatomic,retain) NSString* startPoint;
@property (nonatomic,retain) NSString* endPoint;
@property (nonatomic,retain) UIBarButtonItem* loadBtn;
@property (nonatomic,retain) NSMutableArray* annotationArray;
@property (nonatomic)        UICGTravelModes travelMode;
@property (nonatomic,retain) NSMutableArray *destination;
@property (nonatomic,retain) UICGRoutes *		routes;	
@property (nonatomic,retain) NSMutableArray *mAnnotations;
@property (nonatomic,retain) NSArray *mRouteArray;
@property (nonatomic,retain) IBOutlet SBRouteDetailView*  mRouteDetail;
#pragma mark -
#pragma mark Instance Methods

-(void)updateRoute;
-(void)loadRouteAnnotations;	
-(void)removeRouteAnnotations;
-(void)showCheckpoints;

@end
