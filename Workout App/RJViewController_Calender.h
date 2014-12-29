//
//  RJViewController_Calender.h
//  Workout App
//
//  Created by Rechee Jozil on 12/28/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RSDFDatePickerView.h>

@interface RJViewController_Calender : UIViewController <RSDFDatePickerViewDataSource, RSDFDatePickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *Button_Plus;
- (IBAction)buttonPlusTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@end
