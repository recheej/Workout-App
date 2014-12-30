//
//  RJViewController_MuscleGroups.m
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_MuscleGroups.h"
#import "RJViewController_AddExercise.h"

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
    
    self.navigationController.delegate = self;
    
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

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController == self)
        return;
    
    NSLog(@"Muscle groups navigation showing exercises");

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    int numControllersOnStack = [viewControllersOnStack count];
    RJViewController_AddExercise *exerciseViewController = (RJViewController_AddExercise *) [viewControllersOnStack objectAtIndex:numControllersOnStack - 2];
    
    exerciseViewController.selectedMuscleGroup = [muscleGroups objectAtIndex:indexPath.row];
    
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
