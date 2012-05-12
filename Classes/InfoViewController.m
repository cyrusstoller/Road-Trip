//
//  InfoViewController.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/9/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize emailButton, twitterButton, blurb, byLine;

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
	self.title = @"About";
	[self.blurb flashScrollIndicators];
		
		
	if (![MFMailComposeViewController canSendMail]) {
		self.emailButton.hidden = YES;
	}
	
    [super viewDidLoad];
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
	[emailButton release];
	[twitterButton release];
	[blurb release];
	[byLine release];
    [super dealloc];
}

#pragma mark -
#pragma mark Emailing Feedback

- (IBAction) sendFeedback:(id)sender{
	MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
	mailer.mailComposeDelegate = self;

	//mailer.modalTransitionStyle = UIModalTransitionStylePartialCurl;
	
	[mailer setToRecipients:[NSArray arrayWithObject:@"cyrus.stoller@gmail.com"]];
	
	//set the subject
	[mailer setSubject:@"[Roadtrip iPhone App] Feedback"];
	
	//should create the text for the email
	[mailer setMessageBody:@"Please find my feedback in this email" isHTML:NO];
	
	//present the editor
	[self presentModalViewController:mailer animated:YES];
	[mailer release];
}

#pragma mark -
#pragma mark MFMailComposeDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller 
		 didFinishWithResult:(MFMailComposeResult)result 
					   error:(NSError *)error{
	[controller dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Twitter

- (IBAction) goToTwitter:(id)sender{
	//NSLog(@"Go to Twitter");
	if ([self isTwitterInstalled]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=cyrusstoller"]];
	}else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mobile.twitter.com/cyrusstoller"]];
	}
	//[self.navigationController popToRootViewControllerAnimated:NO];
} 

- (BOOL) isTwitterInstalled {
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]];
}

@end
