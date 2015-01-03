//
//  RJViewController_AddNewExercise.m
//  Workout App
//
//  Created by Rechee Jozil on 1/2/15.
//  Copyright (c) 2015 Rechee Jozil. All rights reserved.
//

#import "RJViewController_AddNewExercise.h"
#import "RJPatternMatching.h"
#import "RJViewController_MuscleGroups.h"
#import "RJViewController_ChooseExercise.h"
#import "RJ_ViewController_AddSets.h"
#import "RJExercise.h"
#import "RJWebServer.h"
#import "RJSet.h"
#import "RJViewController_Calender.h"
#import "RJViewController_PreviousExercises.h"

@interface RJViewController_AddNewExercise ()

@end

@implementation RJViewController_AddNewExercise
{
    RJExercise *exercise;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.button_save;
    
    self.navigationItem.title = [RJPatternMatching friendlyDate:self.selectedDate];
    
    self.label_selectedExercise.adjustsFontSizeToFitWidth = true;
    
    exercise = [[RJExercise alloc] init];
    exercise.user_ID = self.user.userID;
    exercise.workout_date = self.selectedDate;
}

- (void) enableCell: (UITableViewCell *) cell
{
    UILabel *firstLabel = (UILabel *) [cell.contentView viewWithTag:1];
    UILabel *secondLabel = (UILabel *) [cell.contentView viewWithTag:2];
    
    cell.userInteractionEnabled = true;
    firstLabel.enabled = true;
    secondLabel.enabled = true;
}

- (void) disableCell: (UITableViewCell *) cell
{
    UILabel *firstLabel = (UILabel *) [cell.contentView viewWithTag:1];
    UILabel *secondLabel = (UILabel *) [cell.contentView viewWithTag:2];
    
    cell.userInteractionEnabled = false;
    firstLabel.enabled = false;
    secondLabel.enabled = false;
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    
    if([self.previousViewController isKindOfClass:[RJViewController_MuscleGroups class]])
    {
        if(self.selectedMuscleGroup != nil)
        {
            self.label_selectedMuscleGroup.text = self.selectedMuscleGroup;
            
            if(self.selectedMuscleGroup != self.oldSelectedGroup)
            {
                [self.button_save setEnabled:false];
                
                [self disableCell:self.cell_thirdCell];
                self.selectedExerciseName = nil;
                
                self.selectedSets = nil;
                
                self.label_selectedExercise.text = @"";
                [self enableCell:self.cell_secondCell];
            }
        }
        
        return;
    }
    
    if([self.previousViewController isKindOfClass:[RJViewController_ChooseExercise class]])
    {
        if(self.selectedExerciseName != nil)
        {
            self.label_selectedExercise.text = self.selectedExerciseName;
            if(self.selectedExerciseName != self.oldSelectedExerciseName)
            {
                [self.button_save setEnabled:false];
                
                self.selectedSets = nil;
                self.label_selectedSets.text = @"";
                
                [self enableCell:self.cell_thirdCell];
            }
        }
        
        return;
    }
    
    if([self.previousViewController isKindOfClass:[RJ_ViewController_AddSets class]])
    {
        if(self.selectedSets != nil)
        {
            if([self.selectedSets count] > 0)
            {
                [self.button_save setEnabled:true];
                
                self.label_selectedSets.text = [NSString stringWithFormat:@"%d Sets", [self.selectedSets count]];
            }
        }
        
        return;
    }
    
    [self disableCell:self.cell_secondCell];
    [self disableCell:self.cell_thirdCell];
    
}

- (void) hideAllLabels
{
    for(UILabel *label in self.labelTrio)
    {
        label.text = @"";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    UIStoryboard *exerciseStoryboard = [UIStoryboard storyboardWithName:@"Exercise" bundle:nil];
    
    //UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
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


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    NSString *bodyFormat = @"userID=%d&muscleGroup=%@&exerciseName=%@&date=%@";
    
    NSString *body = [NSString stringWithFormat:bodyFormat, exercise.user_ID, exercise.muscleGroup,
                      exercise.exerciseName, [RJPatternMatching sqlDateFromDate:exercise.workout_date]];
    
    RJWebServer *webServer = [[RJWebServer alloc]init];
    
    NSDictionary *result = [[webServer makePOSTRequestWithFileName:@"insert_exercise.php" body:body] firstObject];
    
    if([result objectForKey:@"success"] != nil)
    {
        NSLog([result objectForKey:@"error"]);
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
            NSLog(error);
            [self showDatabaseError];
            return;
        }
    }
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    int numControllersOnStack = [viewControllersOnStack count];
    
    UIViewController *previousController = [viewControllersOnStack objectAtIndex:numControllersOnStack - 2];
    
    if([previousController isKindOfClass:[RJViewController_Calender class]])
    {
        RJViewController_Calender *calenderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Calender"];
        calenderViewController.user = self.user;
        
        [self.navigationController pushViewController:calenderViewController animated:true];
    }
    else
    {
        
        NSDictionary *workoutInfo = [webServer workoutsForDate:self.selectedDate user:self.user];
        
        NSArray *viewControllersOnStack = self.navigationController.viewControllers;
        int numControllersOnStack = [viewControllersOnStack count];
        
        RJViewController_PreviousExercises *previousExercises = (RJViewController_PreviousExercises *) [viewControllersOnStack objectAtIndex:numControllersOnStack - 2];
        previousExercises.workoutInfo = workoutInfo;
        previousExercises.addedNewExercise = true;
        
        [self.navigationController popViewControllerAnimated:true];
    }
}
@end
