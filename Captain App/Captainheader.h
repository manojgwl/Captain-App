//
//  Captainheader.h
//  Captain App
//
//  Created by Shabeer on 25/07/16.
//  Copyright © 2016 GoodworkLabs. All rights reserved.
//

#ifndef Captainheader_h
#define Captainheader_h


// Debug and live sessions

#define DEBUG_VALUE     1
#define RELEASE_VALUE   0

#define DEBUG_MODE      1 // Change this value(1 or 0) to change your server. 0 for live & 1 for development server.

#if DEBUG_MODE==DEBUG_VALUE
#define kBASE_URL                         @"http://52.74.36.61/"
#else
#define kBASE_URL                          @"http://photographers.canvera.com/"
#endif


// Validation Messgaes

#define APPLICATION_NAME  @"Captain App"
#define VALIDATE_WAITERID @"please enter the waiter id"
#define VALIDATE_MOBILE @"Please enter your mobile number"
#define LOGOUT @"/logout"
#define DELETEORDER @"/deleteorder"
#define GETORDER @"/getordersforwaiter"


#define VALIDATE_PHONE_MSG @"Please provide your mobile no."
#define POST_ASSIGNMENT @"AssignmentPosted"
#define SKIP_PHOTOBOOK @"Skip_Photobook"
#define SET_PHOTOBOOK_FIRSTTAB @"Set_Photobook_FirstTab"
#define PHOTOBOOK_PIN @"pbPin"
#define VALIDATE_EMAILADDRESS @"Please enter a valid email id"
#define VALIDATE_MSG_NAME @"Please enter your name"
#define NO_NETWORK_AVAILABLE_MSG @"Please check if you are connected to the Internet and retry.."
#define VALIDATE_MSG_VALID_EMAIL @"Please enter valid email id"
#define VALIDATE_ADD_PHOTOBOOK   @"Please enter your PIN to download your Photobook"
#define VALIDATE_MSG_DOWNLOADING_PHOTBOOK  @"Please wait for your Photobook to download. "


#define ShareDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)



#define CNVprint if(0); else print





#endif /* Captainheader_h */
