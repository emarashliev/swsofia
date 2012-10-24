//
//  SGStation.h
//  SBMapWithRoute
//
//  Created by Ivelin Georgiev on 10/24/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SGStation : NSObject

@property (nonatomic, assign) NSInteger                   stationID;
@property (nonatomic, retain) NSString                    *name;
@property (nonatomic, assign) double                      distance;
@property (nonatomic, assign) CLLocationCoordinate2D      location;
@property (nonatomic, retain) NSMutableArray /*<SGLine>*/ *lines;

- (id)initAndParseDictionary:(NSDictionary*)dictionary;

@end
