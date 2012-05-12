//
//  BusinessItem.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/19/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "BusinessItem.h"


@implementation BusinessItem

@synthesize latitude, longitude, businessName;
@synthesize numStarsURL,numRatings, genre,yelpAppURL,mobileURL;

#pragma mark -
#pragma mark MKAnnotation

- (CLLocationCoordinate2D) coordinate{
	CLLocationCoordinate2D location;
	location.longitude = [self.longitude doubleValue];
	location.latitude = [self.latitude doubleValue];
	return location;
}

- (NSString *) title{
	return self.businessName;
}

- (NSString *) subtitle{
	return self.numRatings;
}

#pragma mark -
#pragma mark Populate from JSON

- (void) populate:(NSDictionary *) yelpJSON{
	NSString *temp;
	
	latitude = [[NSString stringWithFormat:@"%@",[[[yelpJSON objectForKey:@"location"] objectForKey:@"coordinate"] objectForKey:@"latitude"]] retain];
	longitude = [[NSString stringWithFormat:@"%@",[[[yelpJSON objectForKey:@"location"] objectForKey:@"coordinate"] objectForKey:@"longitude"]] retain];
	businessName = [[NSString stringWithFormat:@"%@",[yelpJSON objectForKey:@"name"]] retain];
	numStarsURL = [[NSString stringWithFormat:@"%@",[yelpJSON objectForKey:@"rating_img_url"]] retain];
	numRatings = [[NSString stringWithFormat:@"%@ Ratings",[yelpJSON objectForKey:@"review_count"]] retain];
	
	temp = [[[yelpJSON objectForKey:@"categories"] objectAtIndex:0] objectAtIndex:0];
	if (temp != nil){
		genre = [[NSString stringWithFormat:@"%@",temp] retain];
	}
	
	temp = [NSString stringWithFormat:@"yelp:///biz/%@",[yelpJSON objectForKey:@"id"]];
	yelpAppURL = [[NSURL URLWithString:temp] retain];
	mobileURL = [[NSURL URLWithString:[yelpJSON objectForKey:@"mobile_url"]] retain];
	
	/*
	NSLog(@"name: %@\nlatitude: %@\nlongitude: %@\nnumStarsURL: %@\nnumRatings: %@\ngenre: %@\nyelpAppURL: %@\nmobileURL: %@\n",
		  businessName,latitude,longitude,numStarsURL,numRatings,genre,yelpAppURL,mobileURL);
	*/
	return;
}

- (void) dealloc{
	[latitude release];
	[longitude release];
	[businessName release];
	[numStarsURL release];
	[numRatings release];
	[genre release];
	[yelpAppURL release];
	[mobileURL release];
	[super dealloc];
}

@end
