//
//  RJ_ViewController_AddSets.h
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJ_ViewController_AddSets : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table_sets;

@property (strong, nonatomic) IBOutlet UITextField *textField_reps;

@property (strong, nonatomic) IBOutlet UITextField *text_field_weight;

@property (strong, nonatomic) IBOutlet UIButton *button_addSet;
- (IBAction)addSetTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *label_prompt;

@property (strong, nonatomic) UIColor *color_errorRed;

@property (strong, nonatomic) NSString *selectedExercise;

@property (strong, nonatomic) NSMutableArray *sets;

@end
