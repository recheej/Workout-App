//
//  RJViewController_SignUp.h
//  Workout App
//
//  Created by Rechee Jozil on 12/16/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJViewController_SignUp : UIViewController
//TODO: Attach textboxes to textfields. Verification, blah blah

@property (strong, nonatomic) IBOutlet UITextField *TextField_FirstName;

@property (strong, nonatomic) IBOutlet UITextField *TextField_Email;

@property (strong, nonatomic) IBOutlet UITextField *TextField_Password;
@property (strong, nonatomic) IBOutlet UITextField *TextField_ConfirmPassword;

@property (strong, nonatomic) IBOutlet UITextField *TextField_Age;

@property (strong, nonatomic) IBOutlet UITextField *TextField_Weight;

- (IBAction)signupPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *Label_Error;
@end
