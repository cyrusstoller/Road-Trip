//
//  ResultModel.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/17/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpSearchParamsEnum.h"
#import "YelpAPICall.h"
#import <MapKit/MapKit.h>

@class BusinessItem;

@interface ResultModel : NSObject {
	NSArray *entries;
	CLLocationDirection direction;
	CLLocation *currentLocation;	
	//need to have things from the JSON about bounding the map
	//need current location
	int offset; //for repeat calls
	
	id<YelpAPICallDelegate> controller;
}

@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, assign) CLLocationDirection direction;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, assign) id<YelpAPICallDelegate> controller;

- (void) addJSONArray:(NSArray *)array 
			 location:(CLLocation *) cLocation
			direction:(YelpDirection) currentDirection
			   apiURL:(NSURL *)baseURL
		 numResponses:(NSInteger)numberOfResponses
	  tableController:(id<YelpAPICallDelegate>)cont;
- (CLLocationDirection) getSearchDirection:(YelpDirection)directionSetting
								 cLocation:(CLLocation *) gpsLocation;

- (NSInteger) count;
- (BusinessItem *)getNth:(NSInteger)i;

- (BOOL) buslocation:(CLLocation *) loc
	 directionOfCone:(CLLocationDirection) coneDirection;
	


@end
