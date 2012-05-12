//
//  YelpAPICall.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/9/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol YelpAPICallDelegate

-(void) setYelpResponseDictionary:(NSDictionary *)JSONResponse;
-(void) yelpAPIError:(NSString *)message;


@end

@interface YelpAPICall : NSObject {
	NSMutableData *_responseData;
	id <YelpAPICallDelegate> delegate;
}

@property (nonatomic, retain) NSMutableData *_responseData;
@property (nonatomic, retain) id <YelpAPICallDelegate> delegate;

-(void) query:(NSURL *) URL;

@end
