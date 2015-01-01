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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table_sets.delegate = self;
    self.table_sets.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    self.label_prompt.adjustsFontSizeToFitWidth = true;
    self.label_prompt.text = [NSString stringWithFormat:@"Add Sets for %@", self.selectedExercise];
    
    if(self.sets == nil)
    {
        self.sets = [NSMutableArray arrayWithCapacity:0];
    }
    
    self.table_sets.allowsSelection = false;
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
    exerciseViewController.selectedSets = self.sets;
    
    [super viewWillDisappear:true];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    RJSet *set = [self.sets objectAtIndex:indexPath.row];
    
    NSString *cellText = [NSString stringWithFormat:@"Set #%d: Reps: %d Weight: %d", indexPath.row + 1, set.reps, set.weight];
    cell.textLabel.text = cellText;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arrayWithIndex = [NSArray arrayWithObject:indexPath];
    
    [self.table_sets beginUpdates];
    
    [self.sets removeObjectAtIndex:indexPath.row];
    
    [self.table_sets reloadData];
    
    [self.table_sets deleteRowsAtIndexPaths:arrayWithIndex withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.table_sets endUpdates];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if(editing)
    {
        self.navigationItem.hidesBackButton = true;
    }
    else
    {
        self.navigationItem.hidesBackButton = false;
    }
    
    [self.table_sets setEditing:editing animated:animated];
    
}

- (void) showAlertWithMessage: (NSString *) message title: (NSString *) title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (IBAction)addSetTapped:(id)sender
{
    [self.textField_reps becomeFirstResponder];
    
    if([RJPatternMatching textFieldIsEmpty:self.textField_reps] || [RJPatternMatching textFieldIsEmpty:self.text_field_weight])
    {
        [self showAlertWithMessage:@"Both fields required" title:@"Error"];
    }
    else
    {
        [self.table_sets beginUpdates];
        
        RJSet *newSet = [[RJSet alloc] init];
        
        newSet.reps = [self.textField_reps.text intValue];
        newSet.weight = [self.text_field_weight.text intValue];
        
        self.textField_reps.text = @"";
        self.text_field_weight.text = @"";
        
        [self.sets addObject:newSet];
        
        [self.table_sets reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.sets count] - 1 inSection:0];
        
        NSArray *arrayWithIndex = [NSArray arrayWithObject:indexPath];
        
        [self.table_sets insertRowsAtIndexPaths:arrayWithIndex withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.table_sets endUpdates];
        
        [self.table_sets scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
    }
}
@end
