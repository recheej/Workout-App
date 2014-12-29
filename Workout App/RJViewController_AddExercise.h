//
//  RJViewController_AddExercise.h
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJViewController_AddExercise : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_done;

@property (strong, nonatomic) IBOutlet UILabel *label_workoutDate;

@property (strong, nonatomic) NSDate *selectedDate;

@end
