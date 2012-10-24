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
@property (nonatomic, retain, readonly) NSString    *lineType;
@property (nonatomic, retain, readonly) NSArray     *nextVehicles;


- (id)initWithLineNumber:(NSInteger)vLineNumber type:(NSString*)vType;
- (void)setNextVehicles:(NSArray *)nextVehicles;

@end
