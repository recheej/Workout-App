//
//  RJViewController_PreviousExercises.h
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJUser.h"

@interface RJViewController_PreviousExercises : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *label_workout_date;

@property (strong, nonatomic) NSDate *selectedDate;

@property (strong, nonatomic) IBOutlet UITableView *table_previousWorkouts;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_back;
- (IBAction)backTapped:(id)sender;

@property (strong, nonatomic) RJUser *user;

@property (strong, nonatomic) NSDictionary *workoutInfo;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_addExercise;
- (IBAction)addExerciseTapped:(id)sender;

@property BOOL addedNewExercise;

@end
