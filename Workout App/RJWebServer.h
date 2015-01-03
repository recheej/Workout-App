//
//  RJWebServer.h
//  Workout App
//
//  Created by Rechee Jozil on 12/27/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJUser.h"

@interface RJWebServer : NSObject

+ (NSURL *) baseURL;

- (NSArray *) makePOSTRequestWithFileName: (NSString *) fileName body: (NSString *) body;

- (NSDictionary *) allDatesForUser: (RJUser *) user;

- (RJUser *) getUserWithUserName: (NSString *) userName password: (NSString *) password;

- (NSString *) makeInsertRequestWithFileName: (NSString *) fileName body: (NSString *) body;

- (NSString *) parseSuccessJson: (NSDictionary *) successJson;

- (NSDictionary *) workoutsForDate: (NSDate *) date user: (RJUser *) user;

@end
