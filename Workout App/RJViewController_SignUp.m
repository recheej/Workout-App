//
//  RJViewController_SignUp.m
//  Workout App
//
//  Created by Rechee Jozil on 12/16/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_SignUp.h"

@implementation RJViewController_SignUp

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.Label_Error.hidden = true;
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
- (IBAction)signupPressed:(id)sender
{
    //Let's verify all fields before going on
    
    [self.view endEditing:true];
    self.Label_Error.hidden = true;
    
    if(![self validateTextField:self.TextField_FirstName pattern:@"\\D"])
    {
        [self showError:@"Wrong format for first name"];
        return;
    }
    
    if(![self validateTextField:self.TextField_Email pattern:@"\\S+@\\S+\\.\\S+"])
    {
        [self showError:@"Email must be in the form of: you@email.com"];
        return;
    }
    
    if(![self.TextField_Password.text isEqualToString:self.TextField_ConfirmPassword.text])
    {
        [self showError:@"Passwords do not match. Try again."];
        return;
    }
    
    if(![self validateTextField:self.TextField_Age pattern:@"^\\d{1,3}"])
    {
        [self showError:@"Wrong age format."];
        return;
    }
    
    if(![self validateTextField:self.TextField_Weight pattern:@"^\\d{1,3}"])
    {
        [self showError:@"Wrong weight format"];
        return;
    }
}
@end
