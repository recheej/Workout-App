//
//  RJUser.h
//  Workout App
//
//  Created by Rechee Jozil on 12/26/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJUser : NSObject

@property int userID;

@property (weak, nonatomic) NSString *lastName;

@property (weak, nonatomic) NSString *firstName;

@property int age;

@property int weight;

@property (weak, nonatomic) NSString *gender;

@property (weak, nonatomic) NSString *userName;

@property (weak, nonatomic) NSString *password;

@end
