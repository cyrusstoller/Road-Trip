//
//  ResultTableCell.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/16/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "ResultTableCell.h"
#import "BusinessItem.h"

@implementation ResultTableCell

@synthesize name, stars, numReview, distance, genre, indexNum;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void) populate:(BusinessItem *)businessItem currentLocation:(CLLocation *)loc{
		
	name.text = businessItem.businessName;	
	[self fillStars:businessItem.numStarsURL];	
	numReview.text = businessItem.numRatings;
	genre.text = businessItem.genre;
	
	CLLocation *busLoc = [[CLLocation alloc] initWithLatitude:[businessItem.latitude floatValue] longitude:[businessItem.longitude floatValue]];
	
	distance.text = [NSString stringWithFormat:@"%.2f miles",[loc distanceFromLocation:busLoc]/1609];
	[busLoc release];
	
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

- (void)dealloc {
	[name release];
	[stars release];
	[numReview release];
	[distance release];
	[genre release];
	[indexNum release];
    [super dealloc];
}


@end
