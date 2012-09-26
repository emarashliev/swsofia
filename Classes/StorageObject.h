//
//  StoreObject.h
//  SBMapWithRoute
//
//  Created by TTDani on 9/23/12.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface StorageObject : NSObject <CLLocationManagerDelegate>{

    
}

@property (nonatomic, retain) NSString          *startPoint;
@property (nonatomic, retain) NSString          *endPoint;
@property (nonatomic, retain) NSMutableArray    *endPointsArr;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation        *lastLocation;
@property (nonatomic, retain) CLGeocoder        *geocoder;

@property (nonatomic, retain) CLPlacemark       *placemark;
@property (nonatomic, retain) NSString          *locatedaddress;
@property (nonatomic, retain) NSString          *streetName;

+ (StorageObject *)sharedStorageObject;
- (void)updateGoecoderFromCurrentLocation;

@end
