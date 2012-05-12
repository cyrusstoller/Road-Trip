//
//  SearchTableViewController.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/19/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "SearchTableViewController.h"
#import "ResultModel.h" 
#import "ResultTableCell.h"
#import "BusinessItem.h"
#import "WebResultViewController.h"
#import "BusinessCallout.h"


@implementation SearchTableViewController

@synthesize mapView, resultsTableView, mapViewShown, nestView;
@synthesize yelpDirection, heading, yelpURL, locManager, currentLocation, numberOfResults, model;

#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


#pragma mark -
#pragma mark View lifecycle


#define MAP_BUTTON_TITLE @"Map"
#define LIST_BUTTON_TITLE @"List"
#define FRAME_IN_NAVCONTROLLER CGRectMake(0, 0, 320, 416)


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Yelp Results";
	
	//setting up the view hierarchy
	self.view.backgroundColor = [UIColor blackColor];
	self.nestView = [[[UIView alloc] initWithFrame:FRAME_IN_NAVCONTROLLER]autorelease];
	
	self.resultsTableView = [[UITableView alloc] initWithFrame:self.nestView.bounds];
	self.resultsTableView.delegate = self;
	self.resultsTableView.dataSource = self;
	
	self.mapView = [[MKMapView alloc] initWithFrame:self.nestView.bounds];
	self.mapView.delegate = self;
	
	
	[self.nestView insertSubview:self.resultsTableView atIndex:1];
	[self.nestView insertSubview:self.mapView atIndex:0];
	
	[self.view addSubview:self.nestView];
	
	self.mapViewShown = NO;
	
	//making the button to flip between the list and the map
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:MAP_BUTTON_TITLE 
																			   style:UIBarButtonItemStyleBordered 
																			  target:self 
																			  action:@selector(toggleMap)] autorelease];
	//Location manager
	self.locManager = [[CLLocationManager alloc] init];
	self.locManager.delegate = self;
	self.locManager.distanceFilter = kCLHeadingFilterNone;
	self.locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	[self.locManager startUpdatingLocation];
	
	//Show progress indicators saying determining location
	HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	HUD.delegate = self;
	HUD.labelText = @"Determining Location";	
	
	self.model = [[ResultModel alloc] init];
	shownError = NO;
}

- (void) toggleMap{
	
	if (self.mapViewShown) {
		self.navigationItem.rightBarButtonItem.title = MAP_BUTTON_TITLE;
		self.mapViewShown = NO;
	}else {
		self.navigationItem.rightBarButtonItem.title = LIST_BUTTON_TITLE;
		self.mapViewShown = YES;
		
		//add annotations
	}
	
	//animation for transition between the map and table
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:@"ListMap" context:context];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.nestView cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];

	[self.nestView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	
	[UIView commitAnimations];
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 55;	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [model count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
	return nil;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ResultTableCell";
    
    ResultTableCell *cell = (ResultTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ResultTableCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
 	}
    
	// Configure the cell...
	[cell populate:[self.model getNth:indexPath.row] currentLocation:currentLocation];
	
	//cell.distance.text = @"1.4 miles";
	//cell.stars.image = [UIImage imageNamed:@"stars_1.png"];	
	cell.indexNum.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
	
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	//either open the yelp app or open the mobile yelp website
	
	
	//deselect that cell
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BusinessItem *business = [self.model getNth:indexPath.row];
	[self pushDetailViewController:business];
	
//	/* selected an entry */
//	if ([self isYelpInstalled]) {
//		[[UIApplication sharedApplication] 
//		 openURL:[[self.model getNth:indexPath.row] yelpAppURL]];
//	}else {
//		WebResultViewController *vc = [[WebResultViewController alloc] init];
//		BusinessItem *item = [self.model getNth:indexPath.row];
//		[vc loadURL:[item mobileURL] busName:[item businessName]];
//		[self.navigationController pushViewController:vc animated:YES];
//		[vc	release];
		
//		[[UIApplication sharedApplication] 
//		 openURL:[[self.model getNth:indexPath.row] mobileURL]];
//	}
}

- (void) pushDetailViewController:(BusinessItem *)item{
	/* selected an entry */
	if ([self isYelpInstalled]) {
		[[UIApplication sharedApplication] 
		 openURL:[item yelpAppURL]];
	}else {
		WebResultViewController *vc = [[WebResultViewController alloc] init];
		[vc loadURL:[item mobileURL] busName:[item businessName]];
		[self.navigationController pushViewController:vc animated:YES];
		[vc	release];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	mapView = nil;
	resultsTableView = nil;
	locManager = nil;
}


- (void)dealloc {
	[mapView release];
	[resultsTableView release];
	[nestView release];
	[locManager release];
	locManager = nil; //to prevent the delegate calls after we've released
	currentLocation = nil;
	
	[yelpURL release];
	model.controller = nil;
	[model release];
    [super dealloc];
}


#pragma mark -
#pragma mark SplashViewController Search

- (void) yelpAPIURL:(NSString *) tempURL
		  direction:(YelpDirection) dir
	numberOfResults:(NSInteger) numResults{
	
	self.numberOfResults = numResults;
	self.yelpDirection = dir;
	self.yelpURL = [NSURL URLWithString:tempURL];
		
	return;
}

#pragma mark -
#pragma mark YelpAPICallDelegate

-(void) setYelpResponseDictionary:(NSDictionary *)JSONResponse{
	if ([JSONResponse objectForKey:@"error"] != nil) {
		//put up an error box
		[self yelpAPIError:[NSString stringWithFormat:@"API Error: %@",[[JSONResponse objectForKey:@"error"] objectForKey:@"text"]]];
		return;
	}
	
	HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	HUD.delegate = self;
	HUD.labelText = @"Loading Data";		
	
	
	NSLog(@"YelpApiCallDelegate");
	[self.model addJSONArray:[JSONResponse objectForKey: @"businesses"] 
					location:self.currentLocation 
				   direction:yelpDirection
					  apiURL:self.yelpURL 
				numResponses:self.numberOfResults
			 tableController:self];
	
	[self.resultsTableView reloadData];
	
	[HUD hide:YES];
	
	[self.mapView addAnnotations:self.model.entries];
	
	//setting the right map region
	if (!mapRegionSet) {

		CLLocation *centerMap = [[[CLLocation alloc]
								  initWithLatitude:[[[[JSONResponse objectForKey:@"region"] objectForKey:@"center"] objectForKey:@"latitude"] doubleValue]
								   longitude: [[[[JSONResponse objectForKey:@"region"] objectForKey:@"center"] objectForKey:@"longitude"] doubleValue]]
								  autorelease];
		MKCoordinateSpan span = MKCoordinateSpanMake(1.1*[[[[JSONResponse objectForKey:@"region"] objectForKey:@"span"] objectForKey:@"latitude_delta"] doubleValue]
													 , 1.1*[[[[JSONResponse objectForKey:@"region"] objectForKey:@"span"] objectForKey:@"longitude_delta"] doubleValue]);
		MKCoordinateRegion region = MKCoordinateRegionMake(centerMap.coordinate, span);
		
		[self.mapView setRegion:region animated:YES];	
		self.mapView.showsUserLocation = YES;
		
		mapRegionSet = YES;
	}

	//NSLog(@"%@",JSONResponse);
	
	NSLog(@"total: %@",[JSONResponse objectForKey:@"total"]);
	
	return;
}

- (void) yelpAPIError:(NSString *)message{
	NSLog(@"Error: %@",message);
	if (!shownError) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		[alertView release];
	}
	shownError = YES;
	return;
}

#pragma mark -
#pragma mark MBProgressHUDDelegate

- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidden
    [HUD removeFromSuperview];
	HUD = nil;
}


#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[HUD hide:YES];
	
	//stop the location manager
	//[self.locManager stopUpdatingLocation];	
	
	NSLog(@"CLLocationManagerDelegate %@",newLocation);
	
	if (newLocation.course < 0 && (self.yelpDirection <= 1)) { //this is an error condition when current direction is selected
		[self yelpAPIError:@"Cannot determine direction"];
		return;
	}
	
	YelpAPICall *call = [[[YelpAPICall alloc] init] autorelease];//needs to be autoreleased
	call.delegate = self;
	
	self.currentLocation = newLocation;
	
	//need to determine current location and heading
	self.yelpURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@&ll=%f,%f",self.yelpURL,
												  newLocation.coordinate.latitude,newLocation.coordinate.longitude]];
	
	mapRegionSet = NO;
	
	NSLog(@"%@",yelpURL);
	
	[call query:yelpURL];
	
	
	//[call query:[NSURL URLWithString:[NSString stringWithFormat:@"%@&offset=%d",self.yelpURL,20]]];
	
	//set the center of the map
	//MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 6000, 6000);
	//[self.mapView setRegion:region animated:NO];
	
	return;
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	[HUD hide:YES];
	[self yelpAPIError:@"Unable to determine location"];
	return;
}

#pragma mark -
#pragma mark Checking if yelp app is installed

- (BOOL)isYelpInstalled { return [[UIApplication sharedApplication] 
								  canOpenURL:[NSURL URLWithString:@"yelp:"]]; }


#pragma mark -
#pragma mark MapViewDelegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	if ([annotation isKindOfClass:[BusinessItem class]]) {
		
//		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ResultMapCallout" owner:self options:nil];
//		BusinessCallout *aView = [nib objectAtIndex:0];
		BusinessCallout *aView = [[[BusinessCallout alloc] initWithAnnotation:annotation reuseIdentifier:@"aView"] autorelease];
		[aView populate:annotation];
//		[aView initWithAnnotation:annotation reuseIdentifier:@"aView"];
//		aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//		aView.canShowCallout = YES;
		
//		UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(0,0,20,20)] autorelease];
//		v.backgroundColor = [UIColor redColor];		
//		[aView addSubview:v];
		return aView;
	}
	return nil;
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	if ([view.annotation isKindOfClass:[BusinessItem class]]) {
		[self pushDetailViewController:view.annotation];
	}
}


@end

