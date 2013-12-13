//
//  NSString+BGStringUtilities.m
//  BGUtilities
//
//  Created by Ben Gordon on 12/12/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "NSString+BGStringUtilities.h"

@implementation NSString (BGStringUtilities)

#pragma mark - Contains
- (BOOL)contains:(NSString *)searchString {
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
    return [searchPredicate evaluateWithObject:self];
}

- (BOOL)containsAnyInArray:(NSArray *)searchArray {
    // return NO if no objects
    if (searchArray.count == 0) { return NO; }
    
    // Check against objects until a match is found
    __block BOOL returnBOOL = NO;
    [searchArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            if ([self contains:(NSString *)obj]) {
                returnBOOL = YES;
                *stop = YES;
            }
        }
    }];
    
    return returnBOOL;
}


#pragma mark - REGEX
- (BOOL)evaluateWithRegex:(NSString *)regexString {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return match ? YES : NO;
}


#pragma mark - Email Validation
- (BOOL)isValidEmail {
    return [self evaluateWithRegex:@"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$"];
}

@end