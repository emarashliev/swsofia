//
//  CGLine.m
//  SBMapWithRoute
//
//  Created by Ivelin Georgiev on 10/24/12.
//
//

#import "SGLine.h"

@implementation SGLine

- (void)dealloc {
    [_lineType release];
    [_nextVehicles release];
    
    [super dealloc];
}

- (id)initWithLineNumber:(NSInteger)vLineNumber type:(NSString *)vType
{
    self = [super init];
    if (self) {
        _lineNumber = vLineNumber;
        _lineType = [vType copy];
    }
    return self;
}

- (void)setNextVehicles:(NSArray *)nextVehicles
{
    _nextVehicles = nil;
    _nextVehicles = nextVehicles;
}

@end
