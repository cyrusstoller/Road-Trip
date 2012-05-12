//
//  RoadTripAppDelegate.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/8/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoadTripAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

