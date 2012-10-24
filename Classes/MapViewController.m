//
//  SBGoogleMap.m
//  SBMapWithRoute
//
//  Created by Surya Kant on 15/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MapView.h"
#import "MapAnnotation.h"
#import "City.h"
#import "UICGRoutes.h"
#import "CheckPointViewController.h"
//#import "SBRouteDetailView.h"
#import "StorageObject.h"

@interface MapViewController(Private)
-(void)releaseAllViews;
-(void)customInitialization;
@end

@implementation MapViewController

@synthesize map				= _map;
@synthesize startPoint		= _startPoint;
@synthesize endPoint		= _endPoint;
@synthesize loadBtn         = _loadBtn;
@synthesize annotationArray = _annotationArray;
@synthesize destination;
@synthesize routes          = _routes;
@synthesize mAnnotations;
@synthesize mRouteArray;
@synthesize mRouteDetail;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    mDirections			 = [UICGDirections sharedDirections];
	mDirections.delegate = self;
    
	self.title = @"Maps";
	_map = [[MapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[self.view addSubview:_map];
	
	self.view.backgroundColor = [UIColor blackColor];
	_annotationArray = [[NSMutableArray alloc]init];
	_routes			 = [[UICGRoutes alloc]init];
    
	if (mDirections.isInitialized) {
		[self updateRoute];
        //[self drawRoute];
	}
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -
#pragma mark Instance Methods

- (NSDictionary*)loadStationsFromPlist {
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"StationsList.plist"];
    NSDictionary *plistData = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];
    
	return [plistData autorelease];
}

- (MKMapPoint*)mallocPointsArrFromDescriptionArr:(NSArray*)descriptionArr {
    
    
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * [descriptionArr count]);
    
    for(int idx = 0; idx < [descriptionArr count]; idx++)
	{
        NSDictionary *pointDict = descriptionArr[idx];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([(NSNumber*)pointDict[@"latitude"] floatValue], [(NSNumber*)pointDict[@"longitude"] floatValue]);
        
		//CLLocation *location = (CLLocation *)[descriptionArr objectAtIndex:idx];
		
		//CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
		
		// break the string down even further to latitude and longitude fields.
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        pointArr[idx] = point;
        
        NSLog(@"pointDict = %@", pointDict);
    }
    
    return pointArr;
}

- (void)drawRoute {
	if (mDirections.isInitialized) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        UICGDirectionsOptions *options = [[[UICGDirectionsOptions alloc] init] autorelease];
        options.travelMode = UICGTravelModeDriving;
        City *mFirstCity = [[[City alloc]init] autorelease];
        
        mFirstCity.mCityName = _startPoint;
        
        NSMutableArray *waypoints = [NSMutableArray array];
        [waypoints addObject:_startPoint];
        [waypoints addObjectsFromArray:destination];
        //[waypoints addObject:@"Hladilnika"];
        
        [mDirections loadFromWaypoints:waypoints options:options];
	}
}

- (void)updateRoute
{	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	UICGDirectionsOptions *options = [[[UICGDirectionsOptions alloc] init] autorelease];
	options.travelMode = UICGTravelModeDriving;
	City *mFirstCity = [[[City alloc]init] autorelease];
	mFirstCity.mCityName = [StorageObject sharedStorageObject].startPoint;
    
    NSLog(@"destination = %@", destination);
    
	[mDirections loadWithStartPoint:mFirstCity.mCityName endPoint:[StorageObject sharedStorageObject].endPointsArr options:options];
}

-(void)loadRouteAnnotations
{
	self.mRouteArray = [mDirections routeArray];
    NSLog(@"mRouteArray %@",mRouteArray);
	self.mAnnotations = [[NSMutableArray alloc]init];
	for (int idx = 0; idx < [mRouteArray count]; idx++) {
		NSArray *_routeWayPoints1 = [mRouteArray[idx] wayPoints];
		NSArray *mPlacetitles = [mRouteArray[idx] mPlaceTitle]; 
		self.annotationArray = [NSMutableArray arrayWithCapacity:[_routeWayPoints1 count]-2];
                        
		_loadBtn.title = @"OFF";
		_loadBtn.target = self;
		_loadBtn.action = @selector(removeRouteAnnotations);
		
		for(int idx = 0; idx < [_routeWayPoints1 count]-1; idx++)
		{
			
			mBetweenAnnotation = [[[MapAnnotation alloc] initWithCoordinate:[_routeWayPoints1[idx]coordinate]
																		  title:mPlacetitles[idx]
																 annotationType:SBRouteAnnotationTypeWayPoint] autorelease];
			[self.annotationArray addObject:mBetweenAnnotation];
		}
		[mAnnotations addObject:_annotationArray];
		[self.map.mapView addAnnotations:mAnnotations[idx]];
        NSLog(@"map %@",_map);

	}	
	[mAnnotations release];
}


-(void)showCheckpoints
{
	CheckPointViewController *_Controller	= [[CheckPointViewController alloc]initWithNibName:@"SBCheckPoint" bundle:nil];
	[self.navigationController pushViewController:_Controller animated:YES];
	NSMutableArray *arr = [[mDirections checkPoint] mPlaceTitle];
	_Controller.mCheckPoints = arr ;
	
	[_Controller release];
}


-(void)removeRouteAnnotations
{
	NSMutableArray *mTempAnnotation = [mAnnotations retain];
	for (int idx = 0; idx < [mTempAnnotation count]; idx++) {
		[_map.mapView removeAnnotations:mTempAnnotation[idx] ];
	}	
	_loadBtn.title = @"ON";
	_loadBtn.target = self;
	_loadBtn.action = @selector(loadRouteAnnotations);
	[mTempAnnotation release];
}


#pragma mark <UICGDirectionsDelegate> Methods

- (void)directionsDidFinishInitialize:(UICGDirections *)directions {
	[self updateRoute];
    //[self drawRoute];
}

- (void)directions:(UICGDirections *)directions didFailInitializeWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:[error localizedFailureReason] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}

- (void)directionsDidUpdateDirections:(UICGDirections *)indirections {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	UICGPolyline *polyline = [indirections polyline];
	NSArray *routePoints = [polyline routePoints];
	
	[_map loadRoutes:routePoints]; // Loads route by getting the array of all coordinates in the route.
    
    UIToolbar *tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 103.0f, 44.01f)]; // 44.01 shifts it up 1px for some reason
    tools.clearsContextBeforeDrawing = NO;
    tools.clipsToBounds = NO;
    tools.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f]; // closest I could get by eye to black, translucent style.
    
    // anyone know how to get it perfect?
    tools.barStyle = -1; // clear background
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
    // Create a standard Load button.
    
    self.loadBtn = [[UIBarButtonItem alloc]initWithTitle:@"ON" 
                                                style:UIBarButtonItemStyleBordered 
                                               target:self 
                                               action:@selector(loadRouteAnnotations)];
    
    [buttons addObject:_loadBtn];
    
    
    // Add Go button. Bar Buttons
    UIBarButtonItem *mGoBtn = [[UIBarButtonItem alloc] initWithTitle:@"Go" 
                                          style:UIBarButtonItemStyleBordered 
                                         target:self 
                                         action:@selector(showCheckpoints)];
    [buttons addObject:mGoBtn];
    [mGoBtn release];
    
    // Add buttons to toolbar and toolbar to nav bar.
    //[tools setItems:buttons animated:NO];
    [buttons release];
    UIBarButtonItem *twoButtons = [[UIBarButtonItem alloc] initWithCustomView:tools];
    [tools release];
    self.navigationItem.rightBarButtonItem = twoButtons;
    [twoButtons release];
    
	
	//Add annotations of different colors based on initial and final places.
	MapAnnotation *startAnnotation = [[[MapAnnotation alloc] initWithCoordinate:[routePoints[0] coordinate]
																					title:_startPoint
																		   annotationType:SBRouteAnnotationTypeStart] autorelease];
	MapAnnotation *endAnnotation = [[[MapAnnotation alloc] initWithCoordinate:[[routePoints lastObject] coordinate]
																				  title:_endPoint
																		 annotationType:SBRouteAnnotationTypeEnd] autorelease];
	
	
	[_map.mapView addAnnotations:@[startAnnotation, endAnnotation]];
}

- (void)directions:(UICGDirections *)directions didFailWithMessage:(NSString *)message {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}

#pragma mark -
#pragma mark releasing instances
- (void)dealloc {
	//remove as Observer from NotificationCenter, if this class has registered for any notifications
	//release all you member variables and appropriate caches
    
    [myRoutSummary release];
    
	[_routes release];
	[_annotationArray release];
    [_loadBtn release];
    [_map release];
	[self releaseAllViews];
    [super dealloc];
}


@end
