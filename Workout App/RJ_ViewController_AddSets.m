//
//  RJ_ViewController_AddSets.m
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJ_ViewController_AddSets.h"

@interface RJ_ViewController_AddSets ()

@end

@implementation RJ_ViewController_AddSets

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table_sets.delegate = self;
    self.table_sets.dataSource = self;
    self.navigationItem.rightBarButtonItem = self.button_add;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Set #%d", indexPath.row];
    
    return cell;
}


- (IBAction)addTapped:(id)sender {
}
@end
