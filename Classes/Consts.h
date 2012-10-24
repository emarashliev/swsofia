//
//  Consts.h
//  SBMapWithRoute
//
//  Created by TTDani on 9/27/12.
//
//

#import <UIKit/UIKit.h>

#define DEBUG

#define kNotificationGeocoderChanged    @"GeocoderChangedNotification"
#define kNotificationGeocoderError      @"GeocoderChangedError"

#define localStorageKey                 @"localStorage"


#pragma mark - Retina & Device recognition
//Check for WIDESCREEN MODE, IPHONE5 & IPOD5
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )
#define IS_IPOD_5 ( IS_IPOD && IS_WIDESCREEN )
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

static inline BOOL isRetina() {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale == 2.0));
}


#pragma mark - Helpers

static int randBetween(int start, int end) {
	if (start == end) return start;
	return start + (arc4random() % (end-start));
}

#pragma mark - Logs

#ifdef DEBUG
#define Log(message) NSLog(message @" (in %s at line %d)", __PRETTY_FUNCTION__, __LINE__);
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#define DLog(fmt, ...) printf(("%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define Log(message, ...)
#define DLog(...)
#endif


#define ERRORLog(fmt, ...) NSLog((@"ERROR: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


