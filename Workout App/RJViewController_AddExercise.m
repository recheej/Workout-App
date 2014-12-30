//
//  RJViewController_AddExercise.m
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_AddExercise.h"
#import "RJPatternMatching.h"
#import "RJViewController_MuscleGroups.h"

@interface RJViewController_AddExercise ()

@end

@implementation RJViewController_AddExercise
{
    NSArray *testArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Add Exercise";
    
    self.label_workoutDate.text = [NSString stringWithFormat:@"Workout for: %@", [RJPatternMatching friendlyDate:self.selectedDate]];
    
    self.table_exercises.delegate = self;
    self.table_exercises.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.navigationItem.rightBarButtonItem = self.button_save;
}

- (UILabel *) rightCellLabel: (UITableViewCell *) cell
{
    UILabel *rightLabel = (UILabel *) [cell.contentView viewWithTag:1];
    
    return rightLabel;
}

- (void) viewWillAppear:(BOOL)animated
{
    if(self.selectedMuscleGroup != nil) //TODO: check if also don't have an exercise
    {
        [self.table_exercises deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:false];
        
        UITableViewCell *secondCell = [self.table_exercises cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        
        [self enableCell:secondCell];
        
        UITableViewCell *firstCell = [self.table_exercises cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        UILabel *rightLabel = [self rightCellLabel:firstCell];
        rightLabel.text = self.selectedMuscleGroup;
        rightLabel.hidden = false;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"hello world");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Exercise";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    UIStoryboard *exerciseStoryboard = [UIStoryboard storyboardWithName:@"Exercise" bundle:nil];
    
    UITableViewCell *selectedCell = [self.table_exercises cellForRowAtIndexPath:indexPath];
    
    RJViewController_MuscleGroups *muscleGroups;
    
    switch (row)
    {
        case 0:
            
            muscleGroups = [exerciseStoryboard instantiateViewControllerWithIdentifier:@"MuscleGroups"];
            [self.navigationController pushViewController:muscleGroups animated:true];
            
            break;
            
        default:
            break;
    }
}

- (void) enableCell: (UITableViewCell *) cell
{
    cell.userInteractionEnabled = true;
    cell.textLabel.enabled = true;
    cell.detailTextLabel.enabled = true;
}

- (void) disableCell: (UITableViewCell *) cell
{
    cell.userInteractionEnabled = false;
    cell.textLabel.enabled = false;
    cell.detailTextLabel.enabled = false;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    NSString *cellText;
    switch (indexPath.row)
    {
        case 0:
            cellIdentifier = @"Cell";
            cellText = @"Choose muscle group.";
            break;
        case 1:
            cellIdentifier = @"Exercise";
            cellText = @"Choose exercise.";
            break;
        case 2:
            
            cellIdentifier = @"Reps";
            cellText = @"Add sets";
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UILabel *rightLabel;
    switch (indexPath.row)
    {
        case 0:
            rightLabel = [self rightCellLabel:cell];
            rightLabel.hidden = true;
            break;
        case 1:
            [self disableCell:cell];
            break;
        case 2:
            [self disableCell:cell];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = cellText;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (IBAction)saveTapped:(id)sender
{
    
}

@end
