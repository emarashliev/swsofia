//
//  UICGPolyline.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGPolyline.h"

@implementation UICGPolyline

@synthesize dictionaryRepresentation;
@synthesize routePoints;
@synthesize vertexCount;
@synthesize length;
@synthesize vertices;

+ (UICGPolyline *)polylineWithDictionaryRepresentation:(NSDictionary *)dictionary {
	UICGPolyline *polyline = [[UICGPolyline alloc] initWithDictionaryRepresentation:dictionary];
	return [polyline autorelease];
}

- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary {
	self = [super init];
	if (self != nil) {
		dictionaryRepresentation = [dictionary retain];
        
        if (!vertices || (NSNull *)vertices == [NSNull null]) {
            vertices = [dictionaryRepresentation[@"k"] retain];
        }
        if (!vertices || (NSNull *)vertices == [NSNull null]) {
            vertices = [dictionaryRepresentation[@"g"] retain];
        }
        if (!vertices || (NSNull *)vertices == [NSNull null]) {
            vertices = [dictionaryRepresentation[@"j"] retain];
        }
        
        vertexCount = [vertices count];
		routePoints = [NSMutableArray arrayWithCapacity:vertexCount];
		for (NSDictionary *vertex in vertices) {
			CLLocationDegrees latitude  = [vertex[@"y"] doubleValue];
			CLLocationDegrees longitude = [vertex[@"x"] doubleValue];
			CLLocation *location = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
			[routePoints addObject:location];
		}
	}
	return self;
}

- (void)dealloc {
	[dictionaryRepresentation release];
	[vertices release];
	[super dealloc];
}

- (CLLocation *)vertexAtIndex:(NSInteger)index {
	return routePoints[index];
}

- (void)insertVertexAtIndex:(NSInteger)index inLocation:(CLLocation *)location {
	//TODO
}

@end
