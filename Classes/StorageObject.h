//
//  StoreObject.h
//  SBMapWithRoute
//
//  Created by TTDani on 9/23/12.
//
//

#import <Foundation/Foundation.h>

@interface StorageObject : NSObject {
    
}

@property (nonatomic, retain) NSString  *startPoint;
@property (nonatomic, retain) NSString  *endPoint;
@property (nonatomic, retain) NSMutableArray   *endPointsArr;

+ (StorageObject *)sharedStorageObject;

@end
