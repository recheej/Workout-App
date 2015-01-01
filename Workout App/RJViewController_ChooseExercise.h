//
//  RJViewController_ChooseExercise.h
//  Workout App
//
//  Created by Rechee Jozil on 12/30/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJViewController_ChooseExercise : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table_chooseExercise;

@property (strong, nonatomic) NSString *selectedMuscleGroup;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_done;
- (IBAction)buttonDoneTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_cancel;
- (IBAction)buttonCancelTapped:(id)sender;

@end
