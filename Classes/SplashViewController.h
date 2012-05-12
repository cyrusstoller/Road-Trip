//
//  SplashViewController.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/8/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpSearchParamsEnum.h"

@interface SplashViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>{
	IBOutlet UIPickerView *pickerView;
	
	IBOutlet UISegmentedControl *headingControl;
	IBOutlet UISegmentedControl *numResults;

	IBOutlet UIButton *searchButton;
	
	UIBarButtonItem *infoButton;
	
	NSArray *genreTypes;
	NSArray *distances;
	NSArray *sortingPriority;
	
	UITextField *nameField;
	UIAlertView *dialog;
	
	NSString *tempURL;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *numResults;
@property (nonatomic, retain) IBOutlet UISegmentedControl *headingControl;
@property (nonatomic, retain) IBOutlet UIButton *searchButton;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@property (nonatomic, retain) UIBarButtonItem *infoButton;

@property (nonatomic, retain) NSArray *genreTypes;
@property (nonatomic, retain) NSArray *distances;
@property (nonatomic, retain) NSArray *sortingPriority;

@property (nonatomic, copy) NSString *tempURL;

-(void) showInfo:(UIBarButtonItem *)sender;

-(NSURL *) apiRequestURL;
-(NSString *) urlForCategory:(YelpCategoryType)category;
-(NSString *) urlForMaxDistance:(YelpMaxDistance)maxDistance;
-(NSString *) urlForSortingPriority:(YelpSortingPriority)sortingPriority;

-(IBAction) search:(UIButton *)sender;
-(NSInteger) numberOfResultsRequested;
-(YelpDirection) getDirection;

@end
