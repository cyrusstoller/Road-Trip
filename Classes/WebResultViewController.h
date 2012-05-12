//
//  WebResultViewController.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 3/13/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebResultViewController : UIViewController <UIWebViewDelegate>{
	NSURLRequest *request;
	IBOutlet UIWebView *webView;

	IBOutlet UIBarButtonItem *backButton;
	IBOutlet UIBarButtonItem *forwardButton;
	
	IBOutlet UIBarButtonItem *refreshButton;
	IBOutlet UIActivityIndicatorView *activityMonitor;
	IBOutlet UIBarButtonItem *activityBarButton;

	IBOutlet UIBarButtonItem *stopButton;
	NSMutableArray *buttons;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *stopButton;


- (void) loadURL:(NSURL *)inputURL busName:(NSString *)businessName;
- (void) toggleRefresh;


@end
