//
//  YelpAPICall.m
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/9/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

#import "YelpAPICall.h"
#import "OAuthConsumer.h"
#import "YelpAPICredentials.h"


@implementation YelpAPICall

@synthesize _responseData, delegate;


-(void) query: (NSURL *) URL{
	_responseData = [[NSMutableData alloc] init];
			
	// OAuthConsumer doesn't handle pluses in URL, only percent escapes
	// OK: http://api.yelp.com/v2/search?term=restaurants&location=new%20york
	// FAIL: http://api.yelp.com/v2/search?term=restaurants&location=new+york
	
	// OAuthConsumer has been patched to properly URL escape the consumer and token secrets 
	
	//URL = [NSURL URLWithString:@"http://api.yelp.com/v2/search?term=food&sort=1&ll=37.451648,-122.155905"];
	
	OAConsumer *consumer = [[[OAConsumer alloc] initWithKey:kConsumerKey secret:kConsumerSecret] autorelease];
	OAToken *token = [[[OAToken alloc] initWithKey:kToken secret:kToken_Secret] autorelease];  

	
	id<OASignatureProviding, NSObject> provider = [[[OAHMAC_SHA1SignatureProvider alloc] init] autorelease];
	NSString *realm = nil;  
    
	OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:URL
																   consumer:consumer
																	  token:token
																	  realm:realm
														  signatureProvider:provider];
	[request prepare];
		
	//[self prepare];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
		
	
	//NSLog(@"%@",[[[JSON objectForKey:@"businesses"] objectAtIndex:0] objectForKey: @"location"]);
	[connection release];
	[request release];	
}


#pragma mark -
#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Receiving");
	[_responseData appendData:data];
	
	id JSON = [_responseData yajl_JSON];
	//GHTestLog(@"JSON: %@", [JSON yajl_JSONStringWithOptions:YAJLGenOptionsBeautify indentString:@"  "]);
	
	[delegate setYelpResponseDictionary:(NSDictionary *) JSON];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if ([error localizedFailureReason] != nil) {
		[delegate yelpAPIError:[NSString stringWithFormat:@"%@, %@", [error localizedDescription], [error localizedFailureReason]]];
	}else {
		[delegate yelpAPIError:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
	}
	
	//NSLog(@"Error: %@, %@", [error localizedDescription], [error localizedFailureReason]);
	//[self notify:kGHUnitWaitStatusFailure forSelector:@selector(test)];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	//[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(test)];
	NSLog(@"Data loaded");
}

-(void) dealloc{
	delegate = nil;
	[_responseData release];
	[super dealloc];
}

@end
