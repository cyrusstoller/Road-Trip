//
//  BusinessItem.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/19/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusinessItem : NSObject <MKAnnotation> {
	NSString *latitude;
	NSString *longitude;
	NSString *businessName;
	NSString *numStarsURL; //number of stars - have a big if tree
	NSString *numRatings;  //# of rating
	NSString *genre;	   //genre
	NSURL *yelpAppURL;
	NSURL *mobileURL;

	//distance
}

@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *businessName;
@property (nonatomic, retain) NSString *numStarsURL;
@property (nonatomic, retain) NSString *numRatings;
@property (nonatomic, retain) NSString *genre;
@property (nonatomic, retain) NSURL *yelpAppURL;
@property (nonatomic, retain) NSURL *mobileURL;


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *subtitle;

- (void) populate:(NSDictionary *) yelpJSON;

@end
