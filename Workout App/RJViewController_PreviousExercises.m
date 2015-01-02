//
//  RJViewController_PreviousExercises.m
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_PreviousExercises.h"
#import "RJPatternMatching.h"
#import "RJViewController_Calender.h"

@interface RJViewController_PreviousExercises ()

@end

@implementation RJViewController_PreviousExercises

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Previous Exercises";
    self.label_workout_date.text = [NSString stringWithFormat:@"Workout from %@", [RJPatternMatching friendlyDate:self.selectedDate]];
    
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    
    NSArray *newStack = [NSArray arrayWithObjects:[viewControllersOnStack objectAtIndex:0], self, nil];
    [self.navigationController setViewControllers:newStack];
    
    self.navigationItem.leftBarButtonItem = self.button_back;
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)backTapped:(id)sender
{
    RJViewController_Calender *calenderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Calender"];
    calenderViewController.user = self.user;
    calenderViewController.previousViewController = self;
    
    [self.navigationController pushViewController:calenderViewController animated:true];
}
@end
