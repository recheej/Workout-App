//
//  RJPatternMatching.m
//  Workout App
//
//  Created by Rechee Jozil on 12/23/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "RJPatternMatching.h"

@implementation RJPatternMatching

+ (BOOL) validateTextField: (UITextField *) textField pattern: (NSString *) pattern
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:nil error:nil];
    
    NSTextCheckingResult *match = [regex firstMatchInString:textField.text options:nil range:NSMakeRange(0, textField.text.length)];
    
    if(match)
        return true;
    return false;
}

+ (NSString *) patternEmail
{
    return @"\\S+@\\S+\\.\\S+";
}

+ (BOOL) stringIsEmpty:(NSString *)testString
{
    testString = [testString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(testString.length == 0)
    {
        return true;
    }
    
    return false;
}

+ (BOOL) textFieldIsEmpty: (UITextField *) textField
{
    return [RJPatternMatching stringIsEmpty:textField.text];
}

@end
