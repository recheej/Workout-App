//
//  RJViewController_ChooseExercise.m
//  Workout App
//
//  Created by Rechee Jozil on 12/30/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_ChooseExercise.h"
#import "RJViewController_AddExercise.h"

@interface RJViewController_ChooseExercise ()

@end

@implementation RJViewController_ChooseExercise
{
    NSIndexPath *checkedIndexPath;
    NSDictionary *exerciseDict;
    NSString *chosenExercise;
    BOOL cancelTapped;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table_chooseExercise.delegate = self;
    self.table_chooseExercise.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    NSArray *backExercises = @[@"Lat Pull Down", @"Seated Cable Row"];
    NSArray *bicepExercises = @[@"Hammer Curls", @"Preacher Curl"];
    NSArray *chestExercises = @[@"Incline Bench Press (Barbell)", @"Flat Bench Press (Barbell)"];
    NSArray *coreExercises = @[@"Heel Touches", @"Leg Raises"];
    NSArray *legExercises = @[@"Squats", @"Leg Press"];
    NSArray *shoulderExercises = @[@"Military Press (Dumbbell)", @"Rear Deltoid Flyes"];
    NSArray *tricepExercices = @[@"Kick Backs", @"Dips"];
    
    NSArray *exercises = @[backExercises, bicepExercises, chestExercises, coreExercises, legExercises,
                           shoulderExercises, tricepExercices];
    
    NSArray *muscleGroups = @[@"Back", @"Bicep", @"Chest", @"Core(abs)", @"Legs", @"Shoulder", @"Tricep"];
    
    exerciseDict = [NSDictionary dictionaryWithObjects:exercises forKeys:muscleGroups];
    
    self.navigationItem.leftBarButtonItem = self.button_cancel;
    self.navigationItem.rightBarButtonItem = self.button_done;
}

- (void) viewWillDisappear:(BOOL)animated
{
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    
    RJViewController_AddExercise *exerciseViewController = (RJViewController_AddExercise *) [viewControllersOnStack lastObject];
    exerciseViewController.previousViewController = self;
    
    if(cancelTapped)
    {
        exerciseViewController.selectedExercise = nil;
    }
    else
    {
        exerciseViewController.selectedExercise = chosenExercise;
    }
    
    [super viewWillDisappear:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *exercises = [exerciseDict objectForKey:self.selectedMuscleGroup];
    
    NSString *exerciseName =[exercises objectAtIndex:indexPath.row];
    
    UIImage *exerciseImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", exerciseName]];
    
    UIImageView *imageView = (UIImageView *) [cell.contentView viewWithTag:1];
    imageView.image = exerciseImage;
    
    UILabel *cellLabel = (UILabel *) [cell.contentView viewWithTag:2];
    cellLabel.adjustsFontSizeToFitWidth = true;
    cellLabel.text = exerciseName;
    
    if(checkedIndexPath == nil)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        if(indexPath == checkedIndexPath)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    [self setCellSizes:cell];
    return cell;
}

- (void) setCellSizes: (UITableViewCell *) cell
{
    UIImageView *imageView = (UIImageView *) [cell.contentView viewWithTag:1];
    imageView.frame = CGRectMake(0, 8, 319, 158);
    
    UILabel *cellLabel = (UILabel *) [cell.contentView viewWithTag:2];
    cellLabel.frame = CGRectMake(0, 167, 319, 27);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.table_chooseExercise deselectRowAtIndexPath:indexPath animated:true];
    
    if(checkedIndexPath != nil && (checkedIndexPath.row == indexPath.row))
    {
        return;
    }
    
    UITableViewCell *newCell = [self.table_chooseExercise cellForRowAtIndexPath:indexPath];
    
    if(checkedIndexPath == nil)
    {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        UITableViewCell *oldCell = [self.table_chooseExercise cellForRowAtIndexPath:checkedIndexPath];
        
        if(newCell.accessoryType == UITableViewCellAccessoryNone)
        {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        if(oldCell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [self setCellSizes:oldCell];
    }
    
    chosenExercise = [[exerciseDict objectForKey:self.selectedMuscleGroup] objectAtIndex:indexPath.row];
    [self setCellSizes:newCell];
    checkedIndexPath = indexPath;
}


- (IBAction)buttonDoneTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)buttonCancelTapped:(id)sender
{
    cancelTapped = true;
    [self.navigationController popViewControllerAnimated:true];
}

@end
