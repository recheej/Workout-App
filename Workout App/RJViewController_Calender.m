//
//  RJViewController_Calender.m
//  Workout App
//
//  Created by Rechee Jozil on 12/28/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJViewController_Calender.h"
#import "RJViewController_AddExercise.h"
#import "RJViewController_PreviousExercises.h"
#import "RJWebServer.h"


@interface RJViewController_Calender ()

@end

@implementation RJViewController_Calender
{
    NSDate *selectedDate;
    
    NSDictionary *markableDates;
    
    RJWebServer *server;
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
    
    selectedDate = [self todayWithoutTime];
    
    server = [[RJWebServer alloc] init];
    
    if([self.previousViewController isKindOfClass:[RJViewController_PreviousExercises class]])
    {
        self.navigationItem.hidesBackButton = true;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *body = [NSString stringWithFormat:@"userID=%d", self.user.userID];
    
    markableDates = [server allDatesForUser:self.user];
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

- (BOOL) dateIsMarked: (NSDate *) date
{
    if([markableDates objectForKey:[date description]] != nil)
    {
        return true;
    }
    
    return false;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    selectedDate = date;
    
    if([self dateIsMarked:date])
    {
        //If date is marked let's go to previous exercises
        
        RJViewController_PreviousExercises *previousController = [self.storyboard instantiateViewControllerWithIdentifier:@"PreviousExercises"];
        
        previousController.selectedDate = selectedDate;
        previousController.user = self.user;
        
        [self.navigationController pushViewController:previousController animated:true];
    }
    else
    {
        RJViewController_AddExercise *exerciseController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddExercise"];
        
        exerciseController.selectedDate = selectedDate;
        exerciseController.user = self.user;
        exerciseController.previousViewController = self;
        
        [self.navigationController pushViewController:exerciseController animated:true];
    }
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
    if([date isEqual:[self todayWithoutTime]] || [self dateIsMarked:date])
    {
        return true;
    }
    
    return false;
}

// Returns YES if all tasks on the date are completed or NO if they are not completed.
- (BOOL)datePickerView:(RSDFDatePickerView *)view isCompletedAllTasksOnDate:(NSDate *)date
{
    return YES;
}

@end
