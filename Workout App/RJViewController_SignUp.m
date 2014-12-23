//
//  RJViewController_SignUp.m
//  Workout App
//
//  Created by Rechee Jozil on 12/16/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_SignUp.h"
#import <CoreData/CoreData.h>
#import "RJPatternMatching.h"
#import "ViewController.h"

@implementation RJViewController_SignUp
{
    BOOL success;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.Label_Error.hidden = true;
    
    success = false;
}

- (BOOL) validateTextField: (UITextField *) textField pattern: (NSString *) pattern
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:nil error:nil];
    
    NSTextCheckingResult *match = [regex firstMatchInString:textField.text options:nil range:NSMakeRange(0, textField.text.length)];
    
    if(match)
        return true;
    return false;
}

- (void) showError: (NSString *) errorMessage
{
    self.Label_Error.hidden = false;
    self.Label_Error.text = errorMessage;
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

- (IBAction)signupPressed:(id)sender
{
    //Let's verify all fields before going on
    
    [self.view endEditing:true];
    self.Label_Error.hidden = true;
    
    //TODO: Validate that all textfields have a value for them
    
    if(![RJPatternMatching validateTextField:self.TextField_FirstName pattern:@"\\D"])
    {
        [self showError:@"Wrong format for first name"];
        return;
    }
    
    if(![RJPatternMatching validateTextField:self.TextField_Email pattern:[RJPatternMatching patternEmail]])
    {
        [self showError:@"Email must be in the form of: you@email.com"];
        return;
    }
    
    if(![self.TextField_Password.text isEqualToString:self.TextField_ConfirmPassword.text])
    {
        [self showError:@"Passwords do not match. Try again."];
        return;
    }
    
    if(![RJPatternMatching validateTextField:self.TextField_Age pattern:@"^\\d{1,3}"])
    {
        [self showError:@"Wrong age format."];
        return;
    }
    
    if(![RJPatternMatching validateTextField:self.TextField_Weight pattern:@"^\\d{1,3}"])
    {
        [self showError:@"Wrong weight format"];
        return;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    [newUser setValue:self.TextField_FirstName.text forKey:@"first_name"];
    [newUser setValue:self.TextField_Email.text forKey:@"email"];
    [newUser setValue:self.TextField_Password.text forKey:@"password"];
    [newUser setValue: [NSNumber numberWithInt:[self.TextField_Age.text intValue]] forKey:@"age"];
    [newUser setValue:[NSNumber numberWithInt:[self.TextField_Weight.text intValue]] forKey:@"weight"];
    
    BOOL isMale = true;
    
    if(self.Segment_Male.selectedSegmentIndex == 1)
        isMale = false;
    
    [newUser setValue:[NSNumber numberWithBool:isMale] forKey:@"gender"];
    
    NSError *error = nil;
    if(![context save: &error])
    {
        NSLog(@"Error %@", [error localizedDescription]);
        self.Label_Error.text = @"Error signing up.";
    }
    
    success = true;
    
    [self performSegueWithIdentifier:@"toLogin" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    //We want to set a flag on the log in view controller to let it know we are coming from a successful sign up
    ViewController *loginViewController = [segue destinationViewController];
    
    loginViewController.successfulSignup = success;
}
@end
