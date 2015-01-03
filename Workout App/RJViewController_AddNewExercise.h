//
//  RJViewController_AddNewExercise.h
//  Workout App
//
//  Created by Rechee Jozil on 1/2/15.
//  Copyright (c) 2015 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RJUser.h"

@interface RJViewController_AddNewExercise : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *label_selectedMuscleGroup;
@property (strong, nonatomic) IBOutlet UILabel *label_selectedExercise;
@property (strong, nonatomic) IBOutlet UILabel *label_selectedSets;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelTrio;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *tableCells;

@property (strong, nonatomic) NSDate *selectedDate;

@property (strong, nonatomic) NSString *selectedMuscleGroup;
@property (strong, nonatomic) NSString *oldSelectedGroup;

@property (strong, nonatomic) NSString *selectedExerciseName;
@property (strong, nonatomic) NSString *oldSelectedExerciseName;

@property (strong, nonatomic) UIViewController *previousViewController;

@property (strong, nonatomic) NSMutableArray *selectedSets;

@property (strong , nonatomic) RJUser *user;

@property (strong, nonatomic) IBOutlet UITableViewCell *cell_firstCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell_secondCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell_thirdCell;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_save;
- (IBAction)saveTapped:(id)sender;


@end
