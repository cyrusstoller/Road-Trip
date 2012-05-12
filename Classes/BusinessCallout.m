//
//  BusinessCallout.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 7/16/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "BusinessCallout.h"
#import "BusinessItem.h"


@implementation BusinessCallout

@synthesize name, genre, numRatings, stars, subView;

- (id) initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
	[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	//[self populate:annotation];
	
	self.canShowCallout = NO;
		
	return self;
}

- (void) populate:(BusinessItem *) businessItem{
	name.text = businessItem.businessName;	
	[self fillStars:businessItem.numStarsURL];	
	numRatings.text = businessItem.numRatings;
	genre.text = businessItem.genre;
	return;
}

- (void) fillStars:(NSString *)stringURL{
	stringURL = [[stringURL componentsSeparatedByString:@"/"] lastObject];
	
	if ([stringURL isEqual:@"stars_1_half.png"]) {
		stars.image = [UIImage imageNamed:@"stars_1_half.png"];
	}
	if ([stringURL isEqual:@"stars_1.png"]) {
		stars.image = [UIImage imageNamed:@"stars_1.png"];
	}
	if ([stringURL isEqual:@"stars_2_half.png"]) {
		stars.image = [UIImage imageNamed:@"stars_2_half.png"];
	}
	if ([stringURL isEqual:@"stars_2.png"]) {
		stars.image = [UIImage imageNamed:@"stars_2.png"];
	}
	if ([stringURL isEqual:@"stars_3_half.png"]) {
		stars.image = [UIImage imageNamed:@"stars_3_half.png"];
	}
	if ([stringURL isEqual:@"stars_3.png"]) {
		stars.image = [UIImage imageNamed:@"stars_3.png"];
	}
	if ([stringURL isEqual:@"stars_4_half.png"]) {
		stars.image = [UIImage imageNamed:@"stars_4_half.png"];
	}
	if ([stringURL isEqual:@"stars_4.png"]) {
		stars.image = [UIImage imageNamed:@"stars_4.png"];
	}
	if ([stringURL isEqual:@"stars_5.png"]) {
		stars.image = [UIImage imageNamed:@"stars_5.png"];
	}
}			


-(void) dealloc{
	[name release];
	[genre release];
	[numRatings release];
	[stars release];
	[super dealloc];
}


@end
