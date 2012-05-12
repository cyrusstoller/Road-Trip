//
//  InfoViewController.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/9/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	IBOutlet UIButton *emailButton;
	IBOutlet UIButton *twitterButton;
	IBOutlet UITextView *blurb;
	IBOutlet UILabel *byLine;
}

@property (nonatomic, retain) IBOutlet UIButton *emailButton;
@property (nonatomic, retain) IBOutlet UIButton *twitterButton;
@property (nonatomic, retain) IBOutlet UITextView *blurb;
@property (nonatomic, retain) IBOutlet UILabel *byLine;

- (IBAction) sendFeedback:(id)sender;
- (IBAction) goToTwitter:(id)sender;
- (BOOL) isTwitterInstalled;	


@end