//
//  WebResultViewController.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 3/13/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "WebResultViewController.h"


@implementation WebResultViewController

@synthesize webView;
@synthesize backButton, forwardButton, refreshButton, stopButton;

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
	[super viewDidLoad];

	self.webView.delegate = self;
	[self.webView loadRequest:request];
	
	
	activityMonitor = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
	//activityMonitor = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[activityMonitor startAnimating];
	activityBarButton = [[UIBarButtonItem alloc] initWithCustomView:activityMonitor];
	self.refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
	self.backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_left.png"] 
													   style:UIBarButtonItemStylePlain target:self action:@selector(back)];
	self.forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right.png"] 
													   style:UIBarButtonItemStylePlain target:self action:@selector(forward)];					   
	self.stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stop)];

	
	activityMonitor = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	activityBarButton = [[UIBarButtonItem alloc] initWithCustomView:activityMonitor];\
		
	self.refreshButton = activityBarButton;
	self.backButton.enabled = self.webView.canGoBack;
	self.forwardButton.enabled = self.webView.canGoForward;
	
	UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	buttons = [[NSMutableArray alloc] initWithObjects:self.backButton, self.forwardButton, flex, activityBarButton, self.stopButton,activityBarButton, nil];
	[flex release];
	
	[self setToolbarItems:buttons];
	[self.navigationController setToolbarHidden:NO animated:YES];
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

- (void)viewWillDisappear:(BOOL)animated{
	[self.navigationController setToolbarHidden:YES animated:animated];
}

#pragma mark -
#pragma mark My Methods

- (void) loadURL:(NSURL *)inputURL busName:(NSString *)businessName{
	NSLog(@"%@",inputURL);
	request = [NSURLRequest requestWithURL:inputURL];
	self.title = businessName;
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods

-(void) webViewDidStartLoad:(UIWebView *)webView{
	NSLog(@"Started Loading");
	self.stopButton.enabled = YES;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"Finished Loading");
	self.backButton.enabled = self.webView.canGoBack;
	self.forwardButton.enabled = self.webView.canGoForward;
	self.stopButton.enabled = NO;
	
	[self toggleRefresh];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	NSLog(@"Error: %@",error);
}


-(void) toggleRefresh{
	
	if ([[buttons objectAtIndex:3] isEqual:self.refreshButton] ) {
		[buttons replaceObjectAtIndex:3 withObject:activityBarButton];
	}else{
		[buttons replaceObjectAtIndex:3 withObject:self.refreshButton];
	}
	
	[self setToolbarItems:buttons];
}


-(IBAction) back{
	[self.webView goBack];
}

-(IBAction) forward{
	[self.webView goForward];
}

-(IBAction) stop{
	[self.webView stopLoading];
	self.stopButton.enabled = NO;
}

-(IBAction) refresh{
	[self.webView reload];
}

- (void)dealloc {
	[webView release];
    [super dealloc];
}


@end
