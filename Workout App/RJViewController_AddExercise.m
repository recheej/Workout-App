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
{
    NSArray *testArray;
}

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
    
    self.table_exercises.delegate = self;
    self.table_exercises.dataSource = self;
    
     testArray = @[@"hello world"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [testArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionFormat = [NSString stringWithFormat:@"Exercise #%d", section + 1];
    return sectionFormat;
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
        default:
            
            cellIdentifier = @"Reps";
            cellText = [NSString stringWithFormat:@"Set #%d", (indexPath.row + 1) - 2];
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = cellText;
    
    return cell;
}




@end
