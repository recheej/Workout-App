//
//  RJViewController_AddExercise.h
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJUser.h"

@interface RJViewController_AddExercise : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *label_workoutDate;

@property (strong, nonatomic) NSDate *selectedDate;

@property (strong, nonatomic) IBOutlet UITableView *table_exercises;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_save;
- (IBAction)saveTapped:(id)sender;

@property (strong, nonatomic) NSString *selectedMuscleGroup;
@property (strong, nonatomic) NSString *oldSelectedGroup;

@property (strong, nonatomic) NSString *selectedExerciseName;

@property (strong, nonatomic) NSString *oldSelectedExerciseName;

@property (strong, nonatomic) UIViewController *previousViewController;

@property (strong, nonatomic) NSMutableArray *selectedSets;

@property (strong , nonatomic) RJUser *user;
@end
