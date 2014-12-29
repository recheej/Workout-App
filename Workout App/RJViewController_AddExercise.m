//
//  RJViewController_AddExercise.m
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_AddExercise.h"

@interface RJViewController_AddExercise ()

@end

@implementation RJViewController_AddExercise

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Add Exercises";
    
    self.navigationItem.rightBarButtonItem = self.button_done;
    
    NSString *dateFormat = @"E, MMM d yyyy";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    
    NSString *dateString = [formatter stringFromDate:self.selectedDate];
    
    self.label_workoutDate.text = [NSString stringWithFormat:@"Workout for: %@", dateString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
