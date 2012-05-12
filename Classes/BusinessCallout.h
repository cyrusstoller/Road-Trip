//
//  BusinessCallout.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 7/16/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class BusinessItem;


@interface BusinessCallout : MKPinAnnotationView {
	IBOutlet UILabel *genre;
	IBOutlet UILabel *numRatings;
	IBOutlet UILabel *name;
	IBOutlet UIImageView *stars;
	
	IBOutlet UIView *subView;
}

@property (nonatomic, retain) IBOutlet UILabel *genre;
@property (nonatomic, retain) IBOutlet UILabel *numRatings;
@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UIImageView *stars;

@property (nonatomic, retain) IBOutlet UIView *subView;

- (void) populate:(BusinessItem *) businessItem;
- (void) fillStars:(NSString *)stringURL;


@end
