//
//  CheckConnection.h
//  PerformRx
//
//  Created by SivaSankar on 05/10/15.
//  Copyright © 2015 PCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>

@interface CheckConnection : NSObject {
	Reachability* hostReach;
	Reachability* internetReach;
	Reachability* wifiReach;
	BOOL isInternetAvailable;
}
- (BOOL) checkIntenetRechable;
-(void) startWithCurrentClass:(id)currentClass ;
- (BOOL) connectedToNetwork;

@end
