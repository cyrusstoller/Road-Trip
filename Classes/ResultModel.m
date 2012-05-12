//
//  ResultModel.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/17/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "ResultModel.h"
#import "BusinessItem.h"

#define MULT_REQUESTS 4
#define WEDGE_WIDTH 75 //total angle of the cone wedge

@implementation ResultModel

@synthesize entries, direction, currentLocation, controller;

-(id) init{
	self = [super init];
	if (self) {
		self.entries = [[NSArray alloc] init];
	}
	return self;
}

#pragma mark Populate Model using JSON

- (void) addJSONArray:(NSArray *)array 
			 location:(CLLocation *) cLocation
			direction:(YelpDirection) currentDirection
			   apiURL:(NSURL *)baseURL
		 numResponses:(NSInteger)numberOfResponses
	  tableController:(id<YelpAPICallDelegate>)cont{
		
	self.direction = [self getSearchDirection:currentDirection 
										  cLocation:cLocation];
	self.currentLocation = cLocation;
	controller = cont; //place to go if we need more results
		
//	NSLog(@"HI -----");
	
	NSLog(@"Current Location: %@",currentLocation);
	NSLog(@"Current Direction: %f",self.direction);
	
	id bus;
	int i = 0;
	CLLocation *tempLoc = [CLLocation alloc];
	for (bus in array) {
		//NSLog(@"%@ - url:%@",[bus objectForKey:@"name"],[bus objectForKey:@"url"]);
		
		
		
		//create business items
		NSDictionary *coord = [[bus objectForKey:@"location"] objectForKey:@"coordinate"];
		tempLoc = [tempLoc initWithLatitude:[[coord objectForKey:@"latitude"] floatValue] longitude:[[coord objectForKey:@"longitude"] floatValue]];
		if ([self buslocation:tempLoc directionOfCone:self.direction] && ([entries count] < numberOfResponses)) {
			BusinessItem *newItem = [[BusinessItem alloc] init];
			[newItem populate:bus];
			entries = [entries arrayByAddingObject:newItem];
			[newItem release];
			i++;
		}
	}
	[tempLoc release];
	
	if ([entries retainCount] ==1) {
		[entries retain];
	}
	
//	NSLog(@"BYE -----%d added to model",[entries count]);	

	if ([entries count] < numberOfResponses && offset < MULT_REQUESTS*numberOfResponses && offset < 100) { //potentially just cut it off after 100 entries
		YelpAPICall *call = [[[YelpAPICall alloc] init] autorelease];
		call.delegate = controller;
		offset = offset + 20;
		NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@&offset=%d",baseURL,offset]]);
		[call query:[NSURL URLWithString:[NSString stringWithFormat:@"%@&offset=%d",baseURL,offset]]];
	}
	
}

- (CLLocationDirection) getSearchDirection:(YelpDirection)directionSetting
								 cLocation:(CLLocation *) gpsLocation{
	switch (directionSetting) {
		case kNorth:
			NSLog(@"North");
			return 0;
			break;
		case kEast:
			NSLog(@"East");
			return 90;
			break;
		case kSouth:
			NSLog(@"South");
			return 180;
			break;
		case kWest:
			NSLog(@"West");
			return 270;
			break;
		default:
			break;
	}
	return gpsLocation.course;
}

- (NSInteger) count{
	return [self.entries count];
}

- (BusinessItem *)getNth:(NSInteger)i{
	return [self.entries objectAtIndex:i];
}

- (BOOL) buslocation:(CLLocation *) loc
   directionOfCone:(CLLocationDirection) coneDirection{

	double lat1, lat2, lon1, lon2,result;
	lat1 = currentLocation.coordinate.latitude;
	lat2 = loc.coordinate.latitude;
	lon1 = currentLocation.coordinate.longitude;
	lon2 = loc.coordinate.longitude;
	
	//NSLog(@"lat1: %f, lon1: %f, lat2: %f, lon2: %f",lat1, lon1, lat2, lon2);
	
	result = atan((lat2-lat1)/(lon2-lon1))/M_PI*180;
	if (lon1 > lon2) {
		result += 180;
	}
	
	result -= 90; // to make it aligned with the compass
	
	if (result <0 ) {
		result += 360;
	}
	
	result = 360-result;
	
	NSLog(@"angle = %f, %f",result,coneDirection);
	

	if (coneDirection >= result-WEDGE_WIDTH/2 && coneDirection <= result+WEDGE_WIDTH/2) {
		return TRUE;
	}else{
		return FALSE;
	}
}


- (void) dealloc{
	[entries release];
	[currentLocation release];
	[super dealloc];
}

@end
