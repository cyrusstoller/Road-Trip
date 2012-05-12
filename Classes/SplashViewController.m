//
//  SplashViewController.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/8/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "SplashViewController.h"
#import "YelpAPICall.h"
#import "InfoViewController.h"

#import "SearchTableViewController.h"

@implementation SplashViewController

@synthesize headingControl, numResults, searchButton, pickerView, 
	infoButton;
@synthesize genreTypes, distances, sortingPriority, tempURL;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Road Trip";
		
	//Enums for these are listed in YelpSearchParamsEnum.h
	self.genreTypes = [[NSArray alloc] initWithObjects:@"Other", @"All", @"Food", @"Gas", @"Bars", @"Banks", @"Drugstores", @"Coffee/Tea", nil];
	self.distances = [[NSArray alloc] initWithObjects:@"<1 mi", @"1 mi", @"5 mi", @"10 mi", @"20 mi", nil];
	self.sortingPriority = [[NSArray alloc] initWithObjects:@"Ratings",@"Distance",@"Best", nil];

	[self.pickerView selectRow:2 inComponent:0 animated:NO];//starting at Food
	[self.pickerView selectRow:1 inComponent:1 animated:NO];//starting at Distance	
	[self.pickerView selectRow:3 inComponent:2 animated:NO];//starting at 10 mi	
	
	self.numResults.selectedSegmentIndex = 1; //start with 20 results by default
	
	self.infoButton = [[UIBarButtonItem alloc] initWithTitle:@"Info" 
												  style:UIBarButtonItemStylePlain
												 target:self 
												 action:@selector(showInfo:)];      
	self.navigationItem.rightBarButtonItem = infoButton;
	
    [super viewDidLoad];
	
	
	//for other option
	nameField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
	[nameField setBackgroundColor:[UIColor whiteColor]];
	[nameField setPlaceholder:@"Query"];
	[nameField setBorderStyle:UITextBorderStyleLine];
	[nameField setClearButtonMode:UITextFieldViewModeWhileEditing];
	dialog = [[UIAlertView alloc] initWithTitle:@"Yelp Search Term" message:@" " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
	[dialog addSubview:nameField];

}

- (void) showOtherDialog{
	[dialog show];
	[nameField becomeFirstResponder];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[numResults release];
	[headingControl release];
	[searchButton release];
	[pickerView release];
	[infoButton release];
	
	[genreTypes release];
	[distances release];
	[sortingPriority release];
	
	[nameField release];
	[dialog release];
	
	tempURL = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark What the buttons do


//To show my contact info
- (void) showInfo:(UIBarButtonItem *)sender{
	
	/*
	NSLog(@"Category: %d, Sorting by: %d, Distance: %d, Num Results: %d, Heading Type: %d",
		  [self.pickerView selectedRowInComponent:0],
		  [self.pickerView selectedRowInComponent:1],
		  [self.pickerView selectedRowInComponent:2],
		  [self.numResults selectedSegmentIndex],
		  [self.headingControl selectedSegmentIndex]);
	 */
	
	InfoViewController *vc = [[InfoViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

#pragma mark Yelp

- (NSURL *) apiRequestURL{

	NSMutableString *tempURLString = [[NSMutableString alloc] initWithString:@"http://api.yelp.com/v2/search?"];

	[tempURLString appendString:[self urlForCategory:[self.pickerView selectedRowInComponent:0]]];
	[tempURLString appendString:[self urlForMaxDistance:[self.pickerView selectedRowInComponent:2]]];
	[tempURLString appendString:[self urlForSortingPriority:[self.pickerView selectedRowInComponent:1]]];

	//NSLog(@"%@",tempURLString);
	
	tempURL = tempURLString;
	//[tempURLString release];
	
	return nil;
	
}


- (NSString *) urlForCategory:(YelpCategoryType)category{
	NSString *temp, *temp2;
	switch (category) {
		case kFood:
			temp = [NSString stringWithFormat:@"term=food&"];
			break;
		case kGas:
			temp2 = @"term=gas station&";
			temp = [temp2 stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
			break;
		case kBars:
			temp = [NSString stringWithFormat:@"term=bar&"];
			break;
		case kBanks:
			temp = [NSString stringWithFormat:@"term=bank&"];
			break;
		case kDrugstores:
			temp = [NSString stringWithFormat:@"term=drugstore&"];
			break;
		case kCoffeeTea:
			temp = [NSString stringWithFormat:@"term=coffee&"];
			break;
		default:
			temp = [NSString stringWithFormat:@""];
			break;
	}
	return temp;
}

- (NSString *) urlForMaxDistance:(YelpMaxDistance)maxDistance{
	NSString *temp;
	switch (maxDistance) {
		case kSmall:
			temp = [NSString stringWithFormat:@"radius_filter=1000&"];
			break;
		case k1mile:
			temp = [NSString stringWithFormat:@"radius_filter=1610&"];
			break;
		case k5miles:
			temp = [NSString stringWithFormat:@"radius_filter=8047&"];
			break;
		case k10miles:
			temp = [NSString stringWithFormat:@"radius_filter=16094&"];
			break;
		case k20miles:
			temp = [NSString stringWithFormat:@"radius_filter=32187&"];
			break;
		case k50miles:
			temp = [NSString stringWithFormat:@"radius_filter=80467&"];
			break;
		default:
			temp = [NSString stringWithFormat:@""];
			break;
	}
	return temp;
}

- (NSString *) urlForSortingPriority:(YelpSortingPriority)sPriority{
	NSString *temp;
	switch (sPriority) {
		case kRatings:
			temp = [NSString stringWithFormat:@"sort=2"];
			break;
		case kDistance:
			temp = [NSString stringWithFormat:@"sort=1"];
			break;
		case kBestMatch:
			temp = [NSString stringWithFormat:@"sort=0"];
			break;
		default:
			temp = [NSString stringWithFormat:@""];
			break;
	}
	return temp;
}



#pragma mark Yelp Action

-(IBAction) search:(UIButton *)sender{
	//NSLog(@"Search Yelp");
	[self apiRequestURL];
	
	if ([self.pickerView selectedRowInComponent:0] == 0) {
		[self showOtherDialog];		
	}else{
		SearchTableViewController *vc = [[SearchTableViewController alloc] init];
		[vc yelpAPIURL:tempURL direction:[self getDirection] numberOfResults:[self numberOfResultsRequested]];
		
		[self.navigationController pushViewController:vc animated:YES];
		[vc release];
	}
}

-(NSInteger) numberOfResultsRequested{
	switch (self.numResults.selectedSegmentIndex) {
		case 0:
			return 10;
			break;
		case 1:
			return 20;
			break;
		case 2:
			return 50;
			break;
		default:
			break;
	}
	return 0;
}

-(YelpDirection) getDirection{
	YelpDirection temp = [self.headingControl selectedSegmentIndex];
	if (temp != 0) {
		temp++;
	}
	return temp;
}

#pragma mark -
#pragma mark UIPickerViewDelegate



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	//NSLog(@"row: %d, component: %d",row, component);
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch(component) {
		case 0: return 125;
		case 1: return 100;
		case 2: return 70;
        default: return 0;
    }
	
    //NOT REACHED
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	switch (component) {
		case 0:
			return [genreTypes count];
			break;
		case 1:
			return [sortingPriority count];
			break;
		case 2:
			return [distances count];
			break;
		default:
			return 0;
			break;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
	switch (component) {
		case 0:
			return [genreTypes objectAtIndex:row];
			break;
		case 1:
			return [sortingPriority objectAtIndex:row];
			break;
		case 2:
			return [distances objectAtIndex:row];
			break;
		default:
			return @"Error";
			break;
	}
}

#pragma mark -
#pragma mark UIAlertViewDelegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	//NSLog(@"%@, %d",tempURL,[tempURL retainCount]);

	if (buttonIndex == 1) { //means ok
		if (![[nameField text] isEqual:@""]) {
			tempURL = [NSString stringWithFormat:@"%@&term=%@",tempURL, [[nameField text] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
		}
		
		SearchTableViewController *vc = [[SearchTableViewController alloc] init];
		[vc yelpAPIURL:tempURL direction:[self getDirection] numberOfResults:[self numberOfResultsRequested]];
		
		[self.navigationController pushViewController:vc animated:YES];
		[vc release];
	}

}


@end
