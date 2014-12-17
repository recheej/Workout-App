//
//  ViewController.m
//  Workout App
//
//  Created by Rechee Jozil on 12/16/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender
{
    
}
- (IBAction)signupPressed:(id)sender
{
    
}

- (IBAction)viewTapped:(id)sender
{
    [self.view endEditing:true];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue
{
    NSLog(@"Coming back from sign up");
}

@end
