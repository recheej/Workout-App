//
//  RJPatternMatching.h
//  Workout App
//
//  Created by Rechee Jozil on 12/23/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RJPatternMatching : NSObject

+ (BOOL) validateTextField: (UITextField *) textField pattern: (NSString *) pattern;

+ (NSString *) patternEmail;

+ (BOOL) stringIsEmpty: (NSString *) testString;

+ (BOOL) textFieldIsEmpty: (UITextField *) textField;

+ (NSString *) friendlyDate: (NSDate *) date;

+ (NSString *) sqlDateFromDate: (NSDate *) date;

+ (NSString *) sqlDateFormat;

+ (NSString *) dayFlowFormat;

+ (NSString  *) sqlDateStringToDayFlowString: (NSString *) sqlDateString;

@end
