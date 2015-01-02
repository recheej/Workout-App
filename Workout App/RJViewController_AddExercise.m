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
#import "RJViewController_ChooseExercise.h"
#import "RJ_ViewController_AddSets.h"
#import "RJExercise.h"
#import "RJWebServer.h"
#import "RJSet.h"
#import "RJViewController_Calender.h"

@interface RJViewController_AddExercise ()

@end

@implementation RJViewController_AddExercise
{
    NSArray *testArray;
    RJExercise *exercise;
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
    
    [self.button_save setEnabled:false];
    
    exercise = [[RJExercise alloc] init];
    exercise.user_ID = self.user.userID;
    exercise.workout_date = self.selectedDate;
    
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    
    if([self.previousViewController isKindOfClass:[RJViewController_Calender class]])
    {
         NSArray *newStack = [NSArray arrayWithObjects:[viewControllersOnStack objectAtIndex:0], self, nil];
        
        [self.navigationController setViewControllers:newStack];
    }
}

- (UILabel *) rightCellLabel: (UITableViewCell *) cell
{
    UILabel *rightLabel = (UILabel *) [cell.contentView viewWithTag:1];
    
    return rightLabel;
}

- (void) viewWillAppear:(BOOL)animated
{
    if(self.previousViewController == nil)
        return;
    
    NSMutableArray *rightLabels = [NSMutableArray arrayWithCapacity:2];
    NSMutableArray *cells = [NSMutableArray arrayWithCapacity:3];
    for(int i = 0; i < 3; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        [self.table_exercises deselectRowAtIndexPath:indexPath animated:false];
        
        UITableViewCell *cell = [self.table_exercises cellForRowAtIndexPath:indexPath];
        [cells addObject:cell];
        
        UILabel *rightLabel = [self rightCellLabel:cell];
        [rightLabels addObject:rightLabel];
    }
    
    UILabel *firstRightLabel = (UILabel *) [rightLabels objectAtIndex:0];
    UILabel *secondRightLabel = (UILabel *) [rightLabels objectAtIndex:1];
    UILabel *thirdRightLabel = (UILabel *) [rightLabels objectAtIndex:2];
    
    UITableViewCell *firstCell = (UITableViewCell *) [cells objectAtIndex:0];
    UITableViewCell *secondCell = (UITableViewCell *) [cells objectAtIndex:1];
    UITableViewCell *thirdCell = (UITableViewCell *) [cells objectAtIndex:2];
    
    if([self.previousViewController isKindOfClass:[RJViewController_MuscleGroups class]])
    {
        if(self.selectedMuscleGroup != nil)
        {
            if(self.selectedMuscleGroup == self.oldSelectedGroup) //We have the same selected muscle group. We don't have to do an any thing
            {
                return;
            }
            
            [self.button_save setEnabled:false];
            
            firstRightLabel.text = self.selectedMuscleGroup;
            firstRightLabel.hidden = false;
            
            [self disableCell:thirdCell];

            self.selectedExerciseName = nil;
            secondRightLabel.text = @"";
            secondRightLabel.hidden = true;
 
            
            self.selectedSets = nil;
            thirdRightLabel.text = @"";
            thirdRightLabel.hidden = true;
            
            [self enableCell:secondCell];
        }
    }
    
    if([self.previousViewController isKindOfClass:[RJViewController_ChooseExercise class]])
    {
        if(self.selectedExerciseName == self.oldSelectedExerciseName)
        {
            return;
        }
        
        if(self.selectedExerciseName != nil)
        {
            secondRightLabel.text = self.selectedExerciseName;
            secondRightLabel.hidden = false;
            
            [self.button_save setEnabled:false];

            self.selectedSets = nil;
            thirdRightLabel.text = @"";
            thirdRightLabel.hidden = true;
            
            //TODO: Enable third cell
            [self enableCell:thirdCell];
        }
    }
    
    if([self.previousViewController isKindOfClass:[RJ_ViewController_AddSets class]])
    {
        if(self.selectedSets != nil)
        {
            if([self.selectedSets count] > 0)
            {
                thirdRightLabel.text = [NSString stringWithFormat:@"%d Sets", [self.selectedSets count]];
                thirdRightLabel.hidden = false;
                [self.button_save setEnabled:true];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    RJViewController_ChooseExercise *chooseExercise;
    RJ_ViewController_AddSets *addSetsController;
    
    switch (row)
    {
        case 0:
            
            muscleGroups = [exerciseStoryboard instantiateViewControllerWithIdentifier:@"MuscleGroups"];
            
            self.oldSelectedGroup = self.selectedMuscleGroup;
            
            [self.navigationController pushViewController:muscleGroups animated:true];
            
            break;
        case 1:
            
            chooseExercise = [exerciseStoryboard instantiateViewControllerWithIdentifier:@"ChooseExercise"];
            chooseExercise.selectedMuscleGroup = self.selectedMuscleGroup;
            self.oldSelectedExerciseName = self.selectedExerciseName;
            
            [self.navigationController pushViewController:chooseExercise animated:true];
            
            break;
        case 2:
            
            addSetsController = [exerciseStoryboard instantiateViewControllerWithIdentifier:@"AddSets"];
            addSetsController.selectedExercise = self.selectedExerciseName;
            addSetsController.sets = self.selectedSets;
            
            
            [self.navigationController pushViewController:addSetsController animated:true];
            
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
            cellText = @"Muscle group.";
            break;
        case 1:
            cellIdentifier = @"Exercise";
            cellText = @"Exercise.";
            break;
        case 2:
            
            cellIdentifier = @"Reps";
            cellText = @"Sets";
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
            rightLabel = [self rightCellLabel:cell];
            rightLabel.hidden = true;
            break;
        case 2:
            [self disableCell:cell];
            rightLabel = [self rightCellLabel:cell];
            rightLabel.hidden = true;
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

- (void) showAlertWithMessage: (NSString *) message title: (NSString *) title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void) showDatabaseError
{
    [self showAlertWithMessage:@"Error processing request. Please contact administrator" title:@"Critical Error"];
}

- (IBAction)saveTapped:(id)sender
{
    exercise.muscleGroup = self.selectedMuscleGroup;
    exercise.exerciseName = self.selectedExerciseName;
    
    //name=%@&userName=%@&password=%@&age=%@&gender=%@&weight=%@
    
    NSString *bodyFormat = @"userID=%d&muscleGroup=%@&exerciseName=%@&date=%@";
    
    NSString *body = [NSString stringWithFormat:bodyFormat, exercise.user_ID, exercise.muscleGroup,
                      exercise.exerciseName, [RJPatternMatching sqlDateFromDate:exercise.workout_date]];
    
    RJWebServer *webServer = [[RJWebServer alloc]init];
    
    NSDictionary *result = [webServer makePOSTRequestWithFileName:@"insert_exercise.php" body:body];
    
    if([result objectForKey:@"success"] != nil)
    {
        [self showDatabaseError];
        return;
    }
    
    NSString *exerciseIDString = [result objectForKey:@"Exercise_ID"];
    
    exercise.exerciseID = [exerciseIDString intValue];
    
    for(RJSet *set in self.selectedSets)
    {
        bodyFormat = @"exerciseID=%d&numReps=%d&weight=%d";
        
        body = [NSString stringWithFormat:bodyFormat, exercise.exerciseID, set.reps, set.weight];
        
        NSString *error = [webServer makeInsertRequestWithFileName:@"insert_set.php" body:body];
        
        if(![error isEqualToString:@""])
        {
            [self showDatabaseError];
            return;
        }
    }
    
    RJViewController_Calender *calenderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Calender"];
    calenderViewController.user = self.user;
    
    [self.navigationController pushViewController:calenderViewController animated:true];
}

@end
