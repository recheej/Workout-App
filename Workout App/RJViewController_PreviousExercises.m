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
#import "RJViewController_AddNewExercise.h"

@interface RJViewController_PreviousExercises ()

@end

@implementation RJViewController_PreviousExercises
{
    NSArray *muscleGroups;
    
    NSMutableArray *tableData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.label_workout_date.text = [NSString stringWithFormat:@"Workout from %@", [RJPatternMatching friendlyDate:self.selectedDate]];
    
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    
    NSArray *newStack = [NSArray arrayWithObjects:[viewControllersOnStack objectAtIndex:0], self, nil];
    [self.navigationController setViewControllers:newStack];
    
    self.navigationItem.leftBarButtonItem = self.button_back;
    self.navigationItem.rightBarButtonItem = self.button_addExercise;
    
    NSString *dateString = [RJPatternMatching friendlyDate:self.selectedDate];
    self.navigationItem.title = dateString;
    
    self.table_previousWorkouts.delegate = self;
    self.table_previousWorkouts.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    muscleGroups = [self sortArray: [self.workoutInfo allKeys]];
    
    [self setUpData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.addedNewExercise)
    {
        muscleGroups = [self sortArray: [self.workoutInfo allKeys]];
        
        [self setUpData];
        
        [self.table_previousWorkouts reloadData];
    }
}

- (void) setUpData
{
    int numMuscleGroups = [muscleGroups count];
    tableData = [NSMutableArray arrayWithCapacity:numMuscleGroups];
    
    for(int i = 0; i < numMuscleGroups; i++)
    {
        NSMutableArray *innerData = [NSMutableArray arrayWithCapacity:2];
        
        NSString *muscleGroup = [muscleGroups objectAtIndex:i];
        NSDictionary *exerciseDict = [self.workoutInfo objectForKey:muscleGroup];
        
        NSArray *exerciseNames = [self sortArray: [exerciseDict allKeys]];
        
        for(NSString *exerciseName in exerciseNames)
        {
            [innerData addObject:exerciseName];
            NSArray *sets = (NSArray *) [exerciseDict objectForKey:exerciseName];
            
            for(NSDictionary *setInfo in sets)
            {
                [innerData addObject:setInfo];
            }
            
        }
        
        [tableData addObject:innerData];
    }
}

- (NSArray *) sortArray: (NSArray *) array
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    NSArray *data = [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    return data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[ (NSArray *) tableData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *sectionInfo = (NSArray *) [tableData objectAtIndex:indexPath.section];
    
    NSDictionary *exerciseDict = [self.workoutInfo objectForKey:[muscleGroups objectAtIndex:indexPath.section]];
    
    NSArray *sets = [exerciseDict objectForKey:[sectionInfo firstObject]];
    
    id rowObject = [sectionInfo objectAtIndex:indexPath.row];
    
    if([rowObject isKindOfClass:[NSString class]])
    {
        cell.textLabel.text = (NSString *) rowObject;
    }
    else
    {
        NSDictionary *rowInfo = (NSDictionary *) rowObject;
        
        int reps = [[rowInfo objectForKey:@"Num_Reps"] intValue];
        int weight = [[rowInfo objectForKey:@"Weight"] intValue];
        NSString *cellFormat = @"Set %d | Reps: %d Weight: %d";

        NSString *cellText = [NSString stringWithFormat:cellFormat, [sets indexOfObject:rowObject] + 1, reps, weight];
        
        cell.textLabel.text = cellText;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > 0)
    {
        return 3;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [muscleGroups objectAtIndex:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [muscleGroups count];
}

- (IBAction)backTapped:(id)sender
{
    RJViewController_Calender *calenderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Calender"];
    calenderViewController.user = self.user;
    calenderViewController.previousViewController = self;
    
    self.addedNewExercise = false;
    
    [self.navigationController pushViewController:calenderViewController animated:true];
}
- (IBAction)addExerciseTapped:(id)sender
{
    RJViewController_AddNewExercise *exerciseController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewExercise"];
    
    exerciseController.selectedDate = self.selectedDate;
    exerciseController.user = self.user;
    exerciseController.previousViewController = self;
    
    self.addedNewExercise = false;
    
    [self.navigationController pushViewController:exerciseController animated:true];
}
@end
