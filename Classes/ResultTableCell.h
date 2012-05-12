//
//  ResultTableCell.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/16/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class BusinessItem;

@interface ResultTableCell : UITableViewCell {
	IBOutlet UILabel *name;
	IBOutlet UIImageView *stars;
	IBOutlet UILabel *numReview;
	IBOutlet UILabel *distance;
	IBOutlet UILabel *genre;
	IBOutlet UILabel *indexNum;
}

@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UIImageView *stars;
@property (nonatomic, retain) IBOutlet UILabel *numReview;
@property (nonatomic, retain) IBOutlet UILabel *distance;
@property (nonatomic, retain) IBOutlet UILabel *genre;
@property (nonatomic, retain) IBOutlet UILabel *indexNum;

//need to make a method that can take a BusinessItem and populate the cell

- (void) populate:(BusinessItem *)businessItem currentLocation:(CLLocation *)loc;
- (void) fillStars:(NSString *)stringURL;


@end
