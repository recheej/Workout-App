//
//  ViewController.h
//  Workout App
//
//  Created by Rechee Jozil on 12/16/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *TextField_Email;

@property (strong, nonatomic) IBOutlet UITextField *TextField_Password;

@property (strong, nonatomic) IBOutlet UIButton *Button_Login;
- (IBAction)loginPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *Button_SignUp;
- (IBAction)signupPressed:(id)sender;

- (IBAction)viewTapped:(id)sender;



- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue;

@property (strong, nonatomic) IBOutlet UILabel *Label_Error;

@property BOOL successfulSignup;


@end

