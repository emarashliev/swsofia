//
//  StoreObject.m
//  SBMapWithRoute
//
//  Created by TTDani on 9/23/12.
//
//

#import "StorageObject.h"
#import "Consts.h"

@implementation StorageObject

+ (StorageObject *)sharedStorageObject {
    /*
     @synchronized(self){
     if (sharedMainObject == NULL) sharedMainObject = [[self alloc] init];
     }
     return sharedMainObject;
     */
    
    static dispatch_once_t pred;
    static StorageObject *storeObject = nil;
    dispatch_once(&pred, ^{
        storeObject = [[StorageObject alloc] init];
    });
    return storeObject;
}

- (void)dealloc {
    
    [_startPoint release];
    [_endPoint release];
    [_endPointsArr release];
    
    [_placemark release];
    [_locatedaddress release];
    [_streetName release];
    
    [_locationManager release];
    _locationManager = nil;
    
    [_lastLocation release];
    _lastLocation = nil;
    
    [_geocoder release];
    _geocoder = nil;
    
	[super dealloc];
}



- (id)init {
	if ((self = [super init])) {
        _startPoint     = @"";
        _endPoint       = @"";
        _endPointsArr   = nil;
        
        _locationManager    = nil;
        _geocoder           = [[CLGeocoder alloc] init];
        _lastLocation       = nil;
        
        _placemark          = [[CLPlacemark alloc] init];
        _locatedaddress     = [[NSString alloc] init];
        _streetName         = [[NSString alloc] init];
        
        [self startLocationManager];
	}
	
	return self;
}

- (void)startLocationManager {
    //Start Location services
    if (_locationManager == nil) {
        
        _locationManager                     = [[CLLocationManager alloc] init];
        _locationManager.delegate            = (id)self;
        _locationManager.desiredAccuracy     = kCLLocationAccuracyBest;
        
        [_locationManager startUpdatingLocation];
    }
}

- (void)stopLocationManager {
    _locationManager.delegate            = nil;
    [_locationManager release];
    _locationManager = nil;
}

- (NSMutableArray *)endPointsArr {
    return [NSMutableArray arrayWithObject:_endPoint];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (!self.lastLocation) {
        self.lastLocation = newLocation;
    }
    
    if (newLocation.coordinate.latitude != self.lastLocation.coordinate.latitude &&
        newLocation.coordinate.longitude != self.lastLocation.coordinate.longitude) {
        self.lastLocation = newLocation;
        NSLog(@"New location: %f, %f",
              self.lastLocation.coordinate.latitude,
              self.lastLocation.coordinate.longitude);
        [_locationManager stopUpdatingLocation];
    }
}

- (CLLocation*)getCurrentLocation {
    NSLog(@"latitude = %f ,longitude = %f", _locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude);
    return _locationManager.location;
}

- (void)updateGoecoderFromLocation:(CLLocation*)location {
    //NSLog(@"BTN PRESSED");
    
    //Block address
    [_geocoder reverseGeocodeLocation: location completionHandler: ^(NSArray *placemarks, NSError *error) {
        if (error) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationGeocoderError object:self]];
        }
        //Get address
        _placemark = [placemarks objectAtIndex:0];

        //String to address
        _locatedaddress = [[_placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
    
        _streetName = [_placemark.addressDictionary objectForKey:@"Street"];
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationGeocoderChanged object:self]];
        
        NSLog(@"placemarks = %@", placemarks);
        NSLog(@"Placemark array: %@",_placemark.addressDictionary);
        NSLog(@"Currently address is: %@",_locatedaddress);
        NSLog(@"streetName: %@",_streetName );
    }];
}

- (void)updateGoecoderFromCurrentLocation {
    [self updateGoecoderFromLocation:[self getCurrentLocation]];
}

@end
