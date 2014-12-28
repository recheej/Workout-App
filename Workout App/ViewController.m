//
//  ViewController.m
//  Workout App
//
//  Created by Rechee Jozil on 12/16/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "ViewController.h"
#import "RJPatternMatching.h"
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "RJWebServer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.TextField_Email.delegate = self;
    self.TextField_Password.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.Label_Error.adjustsFontSizeToFitWidth = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (void) showAlertWithMessage: (NSString *) message title: (NSString *) title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void) processLogin
{
    if(![RJPatternMatching validateTextField:self.TextField_Email pattern:[RJPatternMatching patternEmail]])
    {
        [self showAlertWithMessage:@"Wrong format for email. Try again" title:@""];
        return;
    }
    
    if([RJPatternMatching textFieldIsEmpty:self.TextField_Email] || [RJPatternMatching textFieldIsEmpty:self.TextField_Password])
    {
        [self showAlertWithMessage:@"Both fields required" title:@""];
        return;
    }
    
    //POST METHOD
    
    NSString *userName = self.TextField_Email.text;
    NSString *password = self.TextField_Password.text;
    
    RJWebServer *server = [[RJWebServer alloc] init];
    RJUser *user = [server getUserWithUserName:userName password:password];
    
    if(!user)
    {
        [self showAlertWithMessage:@"That does not belong to any account. Try again." title:@""];
        return;
    }
}

- (IBAction)loginPressed:(id)sender
{
    [self processLogin];
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
//RJDayFlow
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.TextField_Email)
    {
        [self.TextField_Password becomeFirstResponder];
    }
    else
    {
        [self processLogin];
    }

    return true;
}


- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue
{
    self.Label_Error.textColor = [UIColor redColor];
    self.Label_Error.text = @"";
    
    //If we get a successful sign up from the sign up view controller, let's display a message to user
    if(self.successfulSignup)
    {
        self.Label_Error.textColor = [UIColor greenColor];
        self.Label_Error.text = @"Congrats. You have successfully signed up.\nYou may now log in.";
    }
}

@end
