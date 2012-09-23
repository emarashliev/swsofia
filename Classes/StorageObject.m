//
//  StoreObject.m
//  SBMapWithRoute
//
//  Created by TTDani on 9/23/12.
//
//

#import "StorageObject.h"

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

    
	[super dealloc];
}



- (id)init {
	if ((self = [super init])) {
        _startPoint     = @"";
        _endPoint       = @"";
        _endPointsArr   = nil;
	}
	
	return self;
}

- (NSMutableArray *)endPointsArr {
    return [NSMutableArray arrayWithObject:_endPoint];
}

@end
