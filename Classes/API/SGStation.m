//
//  SGStation.m
//  SBMapWithRoute
//
//  Created by Ivelin Georgiev on 10/24/12.
//
//

#import "SGStation.h"
#import "SGLine.h"


@implementation SGStation

- (id)initAndParseDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    [dictionary retain];
    
    //NSLog(@"dict: %@", dictionary);
    
    if (self) {
        _stationID  = [dictionary[@"id"] integerValue];
        _distance   = [dictionary[@"dist"] doubleValue];
        _name       = dictionary[@"name"];
        _location   = CLLocationCoordinate2DMake([dictionary[@"lat"] doubleValue], [dictionary[@"lon"] doubleValue]);
        _lines      = [[NSMutableArray alloc] init];
        
        if ( dictionary[@"lines"] != nil )
        {
            NSDictionary *tmpLines = [dictionary[@"lines"] retain];
            
            [tmpLines enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSInteger lineNumber    = [obj[@"number"] intValue];
                NSString  *lineType     = obj[@"type"];
                NSArray   *coming       = obj[@"coming"];
                
                SGLine *line = [[SGLine alloc] initWithLineNumber:lineNumber type:lineType];
                [line setNextVehicles:coming];
                
                [_lines addObject:line];
                [line release];
                
            }];
            
            [tmpLines release];
        }
    }
    
    return self;
}

- (void)dealloc {
    [_lines release];
    [_name release];
    
    [super dealloc];
}

- (NSString *)description {
	//return [NSString stringWithFormat:@"<%@ %p | stationID=%d | Name=%@ | distance=%f | lines=%@ | location {%f, %f}>", [self class], self, self.stationID, self.name, self.distance, self.lines, self.location.latitude, self.location.longitude];
    
    return [NSString stringWithFormat:@"<%@ %p | stationID=%d  | distance=%f | lines=%@ | location {%f, %f}>", [self class], self, _stationID, _distance, _lines, _location.latitude, _location.longitude];
}

@end
