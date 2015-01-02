//
//  RJViewController_Calender.h
//  Workout App
//
//  Created by Rechee Jozil on 12/28/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RSDFDatePickerView.h>
#import "RJUser.h"

@interface RJViewController_Calender : UIViewController <RSDFDatePickerViewDataSource, RSDFDatePickerViewDelegate>

@property (nonatomic, strong) RJUser *user;

@property (nonatomic, strong) UIViewController *previousViewController;

@end
