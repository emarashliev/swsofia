//
//  SofiaGoAPI.m
//  SBMapWithRoute
//
//  Created by Ivelin Georgiev on 10/17/12.
//
//

#import "SofiaGoAPI.h"
#import "JSON.h"
#import "Consts.h"

#import "SGStation.h"
#import "SGLine.h"

#define kAPIUrlFormat @"http://sofia-go.com/stops.php?lat=%f&lon=%f"

@implementation SofiaGoAPI

+ (NSDictionary*)stationsAroundMe:(CLLocationCoordinate2D)coordinate
{
    NSMutableDictionary *stations = [[NSMutableDictionary alloc] init];
    NSError *error = nil;
    NSString *url = [NSString stringWithFormat:kAPIUrlFormat, coordinate.latitude, coordinate.longitude];
    NSString *jsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&error];
    
    if ( jsonString != nil )
    {
        SBJSON *parser = [[SBJSON alloc] init];
        NSArray *requestData = [[parser objectWithString:jsonString] retain];
        
        [requestData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:obj copyItems:YES];
            
            SGStation *station = [[SGStation alloc] initAndParseDictionary:dict];
            
            [stations setObject:station forKey:[NSString stringWithFormat:@"%d", station.stationID]];
            [station release];
            [dict release];
        }];
        
        [parser release];
        [requestData release];
    }
    
    return [stations autorelease];
}

@end
