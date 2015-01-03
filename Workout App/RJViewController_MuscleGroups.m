//
//  RJViewController_MuscleGroups.m
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_MuscleGroups.h"
#import "RJViewController_AddExercise.h"
#import "RJViewController_AddNewExercise.h"

@interface RJViewController_MuscleGroups ()

@end

@implementation RJViewController_MuscleGroups
{
    NSArray *muscleGroups;
    NSString *selectedMuscleGroup;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table_muscleGroups.delegate = self;
    self.table_muscleGroups.dataSource = self;
    muscleGroups = @[@"Back", @"Bicep", @"Chest", @"Core(abs)", @"Legs", @"Shoulder", @"Tricep"];
    
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    if([self isMovingFromParentViewController])
    {
        NSLog(@"Muscle groups is going back to exercise");
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    int numControllersOnStack = [viewControllersOnStack count];
    RJViewController_AddNewExercise *exerciseViewController = (RJViewController_AddNewExercise *) [viewControllersOnStack objectAtIndex:numControllersOnStack - 2];
    
    exerciseViewController.selectedMuscleGroup = [muscleGroups objectAtIndex:indexPath.row];
    exerciseViewController.previousViewController = self;
    
    [self.table_muscleGroups deselectRowAtIndexPath:indexPath animated:true];
    
    [self.navigationController popViewControllerAnimated:true];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [muscleGroups objectAtIndex:indexPath.row];
    
    return cell;
}

@end
