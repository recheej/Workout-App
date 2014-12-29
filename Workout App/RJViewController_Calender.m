//
//  RJViewController_Calender.m
//  Workout App
//
//  Created by Rechee Jozil on 12/28/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_Calender.h"
#import "RJViewController_AddExercise.h"


@interface RJViewController_Calender ()

@end

@implementation RJViewController_Calender
{
    NSDate *selectedDate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RSDFDatePickerView *datePickerView = [[RSDFDatePickerView alloc] initWithFrame: self.view.bounds];
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    [self.view addSubview:datePickerView];
    
    self.navigationItem.title = @"Workout Calender";
    self.navigationItem.rightBarButtonItem = self.Button_Plus;
    
    selectedDate = [self todayWithoutTime];
}

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    selectedDate = date;
    
    RJViewController_AddExercise *exerciseController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddExercise"];
    
    exerciseController.selectedDate = selectedDate;
    
    [self.navigationController pushViewController:exerciseController animated:true];
}

- (NSDate *) dateWithoutTime: (NSDate *) date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *todayComponents = [calendar components:unitFlags fromDate:date];
    NSDate *dateWithoutTime = [calendar dateFromComponents:todayComponents];
    
    return dateWithoutTime;
}

- (NSDate *) todayWithoutTime
{
    return [self dateWithoutTime:[NSDate date]];
}

- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date
{
    // The date is an `NSDate` object without time components.
    // So, we need to use dates without time components.
    
    return [date isEqual:[self todayWithoutTime]];
}

// Returns YES if all tasks on the date are completed or NO if they are not completed.
- (BOOL)datePickerView:(RSDFDatePickerView *)view isCompletedAllTasksOnDate:(NSDate *)date
{
    return YES;
}

@end
