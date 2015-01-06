//
//  RJWebServer.m
//  Workout App
//
//  Created by Rechee Jozil on 12/27/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJWebServer.h"
#import "RJPatternMatching.h"
#import "RJSet.h"


@implementation RJWebServer

+ (NSURL *) baseURL
{
    return [NSURL URLWithString:@"http://ec2-54-149-189-149.us-west-2.compute.amazonaws.com/"];
}

- (NSArray *) jsonResults: (NSData *) jsonData
{
    NSError *error = nil;
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:nil error:&error];
    
    if(error)
    {
        NSLog([error localizedDescription]);
        return nil;
    }
    
    return (NSArray *) jsonObjects;
}

- (NSString *) parseSuccessJson: (NSDictionary *) successJson
{
    int success = [[successJson objectForKey: @"success"] intValue];
    NSString *error = [successJson objectForKey:@"error"];
    
    if(success == 0 && [error isEqualToString:@""]) //Success in json comes back as string 1 or 0. Let's test that to see if error exists
    {
        return nil;
    }
    
    return error;
}

- (NSString *) makeInsertRequestWithFileName: (NSString *) fileName body: (NSString *) body
{
    NSDictionary *responseDict = [self makePOSTRequestWithFileName:fileName body:body];
    
    return [self parseSuccessJson:responseDict];
}

- (NSArray *) makePOSTRequestWithFileName: (NSString *) fileName body: (NSString *) body
{
    NSURL *url = [NSURL URLWithString:fileName relativeToURL:[RJWebServer baseURL]];
    
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
    
    while(resultData == nil)
    {
        //we don't want to continue on with nil data so let's wait until we do.
        continue;
    }
    
    return [self jsonResults:resultData];
}

- (NSDate *) dateWithoutTime: (NSDate *) date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *todayComponents = [calendar components:unitFlags fromDate:date];
    NSDate *dateWithoutTime = [calendar dateFromComponents:todayComponents];
    
    return dateWithoutTime;
}

- (NSDictionary *) allDatesForUser: (RJUser *) user
{
    NSMutableDictionary *allDates = [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *body = [NSString stringWithFormat:@"userID=%d", user.userID];
    
    NSArray *results = [self makePOSTRequestWithFileName:@"get_all_workouts.php" body:body];
    
    for(NSDictionary *result in results)
    {
        NSString *dateString = (NSString *) [result objectForKey:@"Workout_Date"];
        dateString = [RJPatternMatching sqlDateStringToDayFlowString:dateString];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = [RJPatternMatching dayFlowFormat];
        
        NSDate *date = [formatter dateFromString:dateString];
        date = [self dateWithoutTime:date];
        
        [allDates setObject:date forKey:[date description]];
    }
    
    return [NSDictionary dictionaryWithObjects:[allDates allValues] forKeys:[allDates allKeys]];
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
    
    RJWebServer *server = [[RJWebServer alloc] init];
    
    NSArray *jsonResults = [server makePOSTRequestWithFileName:@"login.php" body:parameters];
    
    if(!jsonResults)
    {
        return nil;
    }
    
    return [self userFromJson:[jsonResults firstObject]];
}

- (NSDictionary *) workoutsForDate: (NSDate *) date user: (RJUser *) user
{
    NSString *sqlDate = [RJPatternMatching sqlDateFromDate:date];
    
    NSString *body = [NSString stringWithFormat:@"workoutDate=%@&userID=%d", sqlDate, user.userID];
    
    NSArray *results = [self makePOSTRequestWithFileName:@"workout_for_date.php" body:body];
    
    NSDictionary *result = [results firstObject];
    
    return result;
}

@end
