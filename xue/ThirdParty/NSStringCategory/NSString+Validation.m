//
//  NSString+Validation.m
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "NSString+Validation.h"

#define kValidCharacters @"0123456789."

static NSString *emailRegexp = @"^[-a-zA-Z0-9\\+#][\\+#_\\-.a-zA-Z0-9]*@[-.a-zA-Z0-9]+(\\.[-.a-zA-Z0-9]+)*\\.(com|edu|info|gov|int|mil|net|org|biz|name|museum|coop|aero|pro|tv|test|r=1|[a-zA-Z]{2})$";
static NSString *numberRegexp = @"[0-9]*";
static NSString *wordRegexp = @"[0-9a-zA-Z]*";
static NSString *characterRegexp = @"[a-zA-Z]*";
static NSString *phoneRegexp = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(147)|(145)|(17[0,0-9]))\\d{8}$";
static NSString *identityCardRegexp = @"^(\\d{14}|\\d{17})(\\d|[xX])$";



@implementation NSString (Validation)

/**
 *  Check the string with regular expression.
 */
- (BOOL)regexpCheck:(NSString *)regexp {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    BOOL result = NO;
    @try {
        result = [predicate evaluateWithObject:self];
    }
    @catch (NSException *exception) {
        NSLog(@"Util-Regexp exception: %@", exception);
    }
    return result;
}

/**
 *  Check whether a string is valid email format.
 */
- (BOOL)isValidEmail {
    return [self regexpCheck:emailRegexp];
}

/**
 *  Check whether a string only contains number.
 */
- (BOOL)isStringOnlyContainsNumber {
    return [self regexpCheck:numberRegexp];
}

/**
 *  Check whether a string only contains alphabet and numbers (0~9, a~z, A~Z)
 */
- (BOOL)isEnglishWords {
    return [self regexpCheck:wordRegexp];
}

/**
 *  Check whether a string only contains alphabet.(a~z, A~Z)
 */
- (BOOL)isPureLetter {
    return [self regexpCheck:characterRegexp];
}

/**
 *  Check whether a string is valid phone number format.
 */
- (BOOL)isValidChinesePhoneNumber {
    return [self regexpCheck:phoneRegexp];
}

/**
 *  Check whether a string is valid ID card format.
 */
- (BOOL)isValidIdentityCard {
    return [self regexpCheck:identityCardRegexp];
}

#pragma mark - Non-Regexp Validation
/**
 *  Check whether a string is integer format.
 */
- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  Check whether a string is float format.
 */
- (BOOL)isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  Check whether a string is empty.
 */
- (BOOL)isStringEmpty {
    return (self == nil || self.length == 0);
}

/**
 *  Check whether a string contains a give string with case insensitive match.
 */
- (BOOL)isStringContainTextCaseInsensitive:(NSString *)searchText {
    NSComparisonResult result = [self compare:searchText
                                      options:NSCaseInsensitiveSearch
                                        range:NSMakeRange(0, searchText.length)];
    if (result == NSOrderedSame) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  Check whether the length of a string is between minLength ~ maxLength.
 */
- (BOOL)isStringLengthBetween:(NSInteger)minLength and:(NSInteger)maxLength {
    return self.length > minLength && self.length < maxLength;
}

/**
 *  Check whether the length of a string is less than the minLength or more than the maxLength.
 */
- (BOOL)isStringLengthLessthan:(NSInteger)minLength orMorethan:(NSInteger)maxLength {
    return self.length <= minLength || self.length >= maxLength;
}

#pragma mark - CharacterSet Validation
/**
 * Check whether a string contains characters in a given string set.
 */
- (BOOL)isStringContainsCharactersInSet:(NSString *)setString {
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:setString] invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:characterSet];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

/**
 * Check whether a string contains character in float number format.
 */
- (BOOL)isStringContainFloatNumber {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kValidCharacters] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL result = [self isEqualToString:filtered];
    return result;
}

@end
