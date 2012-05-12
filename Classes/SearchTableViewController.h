//
//  SearchTableViewController.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/19/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "YelpSearchParamsEnum.h"
#import "YelpAPICall.h" 

#import "MBProgressHUD.h" //for the progress indicator

@class ResultTableCell;
@class ResultModel;
@class BusinessItem;

@interface SearchTableViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, 
YelpAPICallDelegate, MBProgressHUDDelegate, CLLocationManagerDelegate> {
	IBOutlet MKMapView *mapView;
	IBOutlet UITableView *resultsTableView;
	UIView *nestView;
	
	MBProgressHUD *HUD;
	
	BOOL mapViewShown;
	BOOL mapRegionSet;
	
	NSURL *yelpURL;
	YelpDirection yelpDirection;
	CLLocation *currentLocation;
	CLLocationManager *locManager;
	
	NSInteger numberOfResults;
	ResultModel *model;
	
	BOOL shownError;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UITableView *resultsTableView;
@property (nonatomic, retain) UIView *nestView;

@property (readwrite) BOOL mapViewShown;

@property (nonatomic, retain) NSURL *yelpURL;
@property (nonatomic, assign) YelpDirection yelpDirection;
@property (nonatomic, assign) CLLocationDirection heading;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) CLLocationManager *locManager;

@property (nonatomic, assign) NSInteger numberOfResults;
@property (nonatomic, retain) ResultModel *model;


- (void) toggleMap;
- (void) pushDetailViewController:(BusinessItem *)item;

- (void) yelpAPIURL:(NSString *) tempURL
		  direction:(YelpDirection) dir
	numberOfResults:(NSInteger) numResults;

- (BOOL)isYelpInstalled;


@end
