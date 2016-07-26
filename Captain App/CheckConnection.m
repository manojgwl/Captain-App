//
//  CheckConnection.m
//  PerformRx
//
//  Created by SivaSankar on 05/10/15.
//  Copyright © 2015 PCS. All rights reserved.
//

#import "CheckConnection.h"
#import <UIKit/UIKit.h>

@class Reachability;
@implementation CheckConnection

- (BOOL) checkIntenetRechable
{
	internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	
	
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    BOOL connectionRequired= [internetReach connectionRequired];
    NSString* statusString= @"";
	
	

    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = @"Access Not Available";
			isInternetAvailable=FALSE;
            break;
        }
            
        case ReachableViaWWAN:
        {
			isInternetAvailable=TRUE;
            statusString = @"Reachable WWAN";
            break;
        }
        case ReachableViaWiFi:
        {
			isInternetAvailable=TRUE;
			statusString= @"Reachable WiFi";
            break;
		}
    }
    if(connectionRequired)
    {
        //statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
		isInternetAvailable=FALSE;
    }
	return isInternetAvailable;
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self checkIntenetRechable];
}

- (BOOL) connectedToNetwork
{
	// Create zero addy
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	return (isReachable && !needsConnection) ? YES : NO;
}


//call like:
-(void) startWithCurrentClass:(id)currentClass {
	if (![self connectedToNetwork]) {
        
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"This action could not be completed. Please check your network connection." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        
        [currentClass presentViewController:alert animated:YES completion:nil];

        
	} else {
		//do something
	}
}



@end
