//
//  RJExercise.h
//  Workout App
//
//  Created by Rechee Jozil on 1/1/15.
//  Copyright (c) 2015 Rechee Jozil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJExercise : NSObject

@property int exerciseID;

@property int user_ID;

@property (strong, nonatomic) NSString *muscleGroup;

@property (strong, nonatomic) NSString *exerciseName;

@property (strong, nonatomic) NSDate *workout_date;

@end
