//
//  RJWebServer.m
//  Workout App
//
//  Created by Rechee Jozil on 12/27/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJWebServer.h"


@implementation RJWebServer

+ (NSURL *) baseURL
{
    return [NSURL URLWithString:@"http://ec2-54-148-233-70.us-west-2.compute.amazonaws.com/"];
}

- (NSDictionary *) getDictforJson: (NSData *) jsonData
{
    NSError *error = nil;
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:nil error:&error];
    
    if(error)
    {
        NSLog([error localizedDescription]);
        return nil;
    }
    
    if([jsonObjects isKindOfClass:[NSArray class]])
    {
        return [ (NSArray *) jsonObjects firstObject];
    }
    
    
    return (NSDictionary *) jsonObjects;
}

- (NSString *) makeInsertRequestWithURL: (NSURL *) url body: (NSString *) body
{
    NSDictionary *responseDict = [self makePOSTRequestWithURL:url body:body];
    
    int success = [[responseDict objectForKey: @"success"] intValue];
    NSString *error = [responseDict objectForKey:@"error"];
    
    if(success == 0 && [error isEqualToString:@""]) //Success in json comes back as string 1 or 0. Let's test that to see if error exists
    {
        return nil;
    }
    
    return error;
}

- (NSDictionary *) makePOSTRequestWithURL: (NSURL *) url body: (NSString *) body
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = bodyData;
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSData __block *resultData;
    
    NSURLSessionTask *task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        
        if (error)
        {
            NSLog([error localizedDescription]);
            resultData = nil;
        }
        
        
        NSString *dataReturned = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        resultData = data;
        
    }];
    
    [task resume];
    [NSThread sleepForTimeInterval:5];
    
    return [self getDictforJson:resultData];
}

- (RJUser *) userFromJson: (NSDictionary *) json
{
    RJUser *user = [[RJUser alloc] init];
    
    id age = [json objectForKeyedSubscript:@"Age"];
    user.userID = [[json objectForKey:@"User_ID"] intValue];
    user.age =  [[json objectForKey:@"Age"] intValue];
    user.firstName = [json objectForKey:@"First_Name"];
    user.lastName = [json objectForKey:@"Last_Name"];
    user.gender = [json objectForKey:@"Gender"];
    user.userName = [json objectForKey:@"User_Name"];
    user.password = [json objectForKey:@"Password"];
    user.weight = [[json objectForKey:@"Weight"] intValue];
    
    return user;
}

- (RJUser *) getUserWithUserName: (NSString *) userName password: (NSString *) password
{
    NSString *parameters = [NSString stringWithFormat:@"userName=%@&password=%@", userName, password];
    
    NSURL *loginURL = [NSURL URLWithString:@"login.php" relativeToURL:[RJWebServer baseURL]];
    
    RJWebServer *server = [[RJWebServer alloc] init];
    
    NSDictionary *json = [server makePOSTRequestWithURL:loginURL body:parameters];
    
    if(!json)
    {
        return nil;
    }
    
    return [self userFromJson:json];
}



@end
