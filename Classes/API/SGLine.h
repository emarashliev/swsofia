//
//  CGLine.h
//  SBMapWithRoute
//
//  Created by Ivelin Georgiev on 10/24/12.
//
//

#import <Foundation/Foundation.h>

@interface SGLine : NSObject

@property (nonatomic, assign, readonly) NSInteger   lineNumber;
@property (nonatomic, assign, readonly) NSString    *lineType;
@property (nonatomic, assign, readonly) NSArray     *nextVehicles;


- (id)initWithLineNumber:(NSInteger)vLineNumber type:(NSString*)vType;
- (void)setNextVehicles:(NSArray *)nextVehicles;

@end
