//
//  UICGRoute.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGRoute.h"

@implementation UICGRoute

@synthesize dictionaryRepresentation;
@synthesize numerOfSteps;
@synthesize steps;
@synthesize distance;
@synthesize duration;
@synthesize summaryHtml;
@synthesize startGeocode;
@synthesize endGeocode;
@synthesize endLocation;
@synthesize polylineEndIndex;

+ (UICGRoute *)routeWithDictionaryRepresentation:(NSDictionary *)dictionary {
	UICGRoute *route = [[UICGRoute alloc] initWithDictionaryRepresentation:dictionary];
	return [route autorelease];
}

- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary {
	self = [super init];
	if (self != nil) {
		dictionaryRepresentation = [dictionary retain];
        NSArray *allKeys = [dictionaryRepresentation allKeys];
        NSDictionary *k = dictionaryRepresentation[allKeys[[allKeys count] - 1]];
				
		endGeocode = dictionaryRepresentation[@"MJ"];
		startGeocode = dictionaryRepresentation[@"dT"];
		
		distance = k[@"Distance"];
		duration = k[@"Duration"];
		NSDictionary *endLocationDic = k[@"End"];
		NSArray *coordinates = endLocationDic[@"coordinates"];
		CLLocationDegrees longitude = [coordinates[0] doubleValue];
		CLLocationDegrees latitude  = [coordinates[1] doubleValue];
		endLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		summaryHtml = k[@"summaryHtml"];
		polylineEndIndex = [k[@"polylineEndIndex"] integerValue];
	}
	return self;
}

- (void)dealloc {
	[dictionaryRepresentation release];
	[steps release];
	[distance release];
	[duration release];
	[summaryHtml release];
	[startGeocode release];
	[endGeocode release];
	[endLocation release];
	[super dealloc];
}
@end
