//
//  RJViewController_PreviousExercises.h
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJViewController_PreviousExercises : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *label_workout_date;

@property (strong, nonatomic) NSDate *selectedDate;

@property (strong, nonatomic) IBOutlet UITableView *table_previousWorkouts;

@end
