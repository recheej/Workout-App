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

- (NSDictionary *) makePOSTRequestWithURL: (NSURL *) url body: (NSString *) body;

- (RJUser *) getUserWithUserName: (NSString *) userName password: (NSString *) password;

@end
