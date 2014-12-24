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
    
    NSLog(@"view did appear");
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
    
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"email like %@ AND password like %@", self.TextField_Email.text, self.TextField_Password.text];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    request.predicate = searchPredicate;
    
    NSError *error = nil;
    NSArray *users = [context executeFetchRequest:request error:&error];
    
    if([users count] == 0)
    {
        [self showAlertWithMessage:@"No account for that e-mail and password found." title:@""];
        return;
    }
    
    NSManagedObjectContext *userContext = [users firstObject];
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
    NSLog(@"coming back from sign up");
    if(self.successfulSignup)
    {
        self.Label_Error.textColor = [UIColor greenColor];
        self.Label_Error.text = @"Congrats. You have successfully signed up.\nYou may now log in.";
    }
}

@end
