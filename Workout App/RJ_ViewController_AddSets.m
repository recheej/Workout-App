//
//  RJ_ViewController_AddSets.m
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJ_ViewController_AddSets.h"
#import "RJSet.h"
#import "RJViewController_AddExercise.h"
#import "RJPatternMatching.h"

@interface RJ_ViewController_AddSets ()

@end

@implementation RJ_ViewController_AddSets
{
    NSMutableArray *sets;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table_sets.delegate = self;
    self.table_sets.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    self.navigationItem.leftBarButtonItem = self.button_back;
    
    sets = [NSMutableArray arrayWithCapacity:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    NSArray *viewControllersOnStack = self.navigationController.viewControllers;
    
    RJViewController_AddExercise *exerciseViewController = (RJViewController_AddExercise *) [viewControllersOnStack lastObject];
    exerciseViewController.previousViewController = self;
    
    if([sets count] == 0)
    {
        exerciseViewController.selectedSets = nil;
    }
    else
    {
        
        exerciseViewController.selectedSets = sets;
    }
    
    [super viewWillDisappear:true];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([sets count] == 0)
    {
        if(section == 1)
            return 0;
        
        return 1;
    }
    
    return [sets count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([sets count] == 0)
    {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    
    if([sets count] == 0)
    {
        cellIdentifier = @"StartCell";
    }
    else
    {
        cellIdentifier = @"Cell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if([sets count] > 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Set #%d", indexPath.row];
    }
    
    if([cellIdentifier isEqualToString:@"Cell"])
    {
        UITextField *repsField = (UITextField *) [cell.contentView viewWithTag:1];
        
        if(repsField.delegate != self)
        {
            UITextField *weightField = (UITextField *) [cell.contentView viewWithTag:2];
            
            repsField.delegate = self;
            weightField.delegate = self;
        }
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([sets count] == 0)
    {
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([sets count] == 0)
    {
        return false;
    }
    
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arrayWithIndex = [NSArray arrayWithObject:indexPath];
    
    [self.table_sets beginUpdates];
    
    [sets removeObjectAtIndex:indexPath.row];
    
    if([sets count] == 0)
    {
        [self.table_sets insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [self.table_sets reloadData];
    
    [self.table_sets deleteRowsAtIndexPaths:arrayWithIndex withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.table_sets endUpdates];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.table_sets setEditing:editing animated:animated];
    
    NSIndexPath *startIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *startCell = [self.table_sets cellForRowAtIndexPath:startIndex];
    
    if(editing)
    {
        if([sets count] == 0)
        {
            
            UILabel *promptField = (UILabel *) [startCell.contentView viewWithTag:1];
            promptField.text = @"Tap \"+\" to add a new set.";
        }
        
        self.navigationItem.leftBarButtonItem = self.button_add;
    }
    else
    {
        if([sets count] == 0)
        {
            UILabel *promptField = (UILabel *) [startCell.contentView viewWithTag:1];
            promptField.text = @"Tap \"Edit\" to begin adding sets";
        }
        
        self.navigationItem.leftBarButtonItem = self.button_back;
    }
}


- (IBAction)addTapped:(id)sender
{
    [self.table_sets beginUpdates];
    RJSet *newSet = [[RJSet alloc] init];
    
    if([sets count] == 0)
    {
        newSet.setNumber = 1;
        
        [sets addObject:newSet];
        
        [self.table_sets deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        newSet.setNumber = [sets count] + 1;
        
        [sets addObject:newSet];
        
        [self.table_sets reloadData];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sets count] - 1 inSection:0];
    
    NSArray *arrayWithIndex = [NSArray arrayWithObject:indexPath];
    
    [self.table_sets insertRowsAtIndexPaths:arrayWithIndex withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.table_sets endUpdates];
}

- (IBAction)backTapped:(id)sender
{
    for(int i = 0; i < [sets count]; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.table_sets cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
            
        UITextField *repsField = (UITextField *) [cell.contentView viewWithTag:1];
        UITextField *weightField = (UITextField *) [cell.contentView viewWithTag:2];
        
        RJSet *set = [sets objectAtIndex:i];
        set.weight = [weightField.text intValue];
        set.reps = [repsField.text intValue];
        set.setNumber = i + 1;
            
        if([RJPatternMatching textFieldIsEmpty:repsField] || [RJPatternMatching textFieldIsEmpty:weightField])
        {
            NSString *message = [NSString stringWithFormat:@"Set %d contains empty fields. All fields required.", i + 1];
            
            cell.backgroundColor = self.color_errorRed;
            
            [self.table_sets scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:true];
            
            [self showAlertWithMessage:message title:@"Error"];
            return;
        }
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void) showAlertWithMessage: (NSString *) message title: (NSString *) title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

@end
