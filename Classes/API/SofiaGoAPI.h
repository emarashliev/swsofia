//
//  SofiaGoAPI.h
//  SBMapWithRoute
//
//  Created by Ivelin Georgiev on 10/17/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SofiaGoAPI : NSObject

+ (NSDictionary*)stationsAroundMe:(CLLocationCoordinate2D)coordinate;

@end
