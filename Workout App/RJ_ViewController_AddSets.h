//
//  RJ_ViewController_AddSets.h
//  Workout App
//
//  Created by Rechee Jozil on 12/29/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJ_ViewController_AddSets : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table_sets;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *button_add;
- (IBAction)addTapped:(id)sender;
@end
