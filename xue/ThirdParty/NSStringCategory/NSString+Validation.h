//
//  NSString+Validation.h
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

/**
 *  Check the string with regular expression.
 */
- (BOOL)regexpCheck:(NSString *)regexp;

/**
 *  Check whether a string is valid email format.
 */
- (BOOL)isValidEmail;

/**
 *  Check whether a string only contains number (0~9).
 */
- (BOOL)isStringOnlyContainsNumber;

/**
 *  Check whether a string only contains alphabet and numbers (0~9, a~z, A~Z)
 */
- (BOOL)isEnglishWords;

/**
 *  Check whether a string only contains alphabet.(a~z, A~Z)
 */
- (BOOL)isPureLetter;

/**
 *  Check whether a string is valid phone number format.
 */
- (BOOL)isValidChinesePhoneNumber;

/**
 *  Check whether a string is valid ID card format.
 */
- (BOOL)isValidIdentityCard;



#pragma mark - NonRegexp Validation

/**
 *  Check whether a string is integer format.
 */
- (BOOL)isPureInt;

/**
 *  Check whether a string is float format.
 */
- (BOOL)isPureFloat;

/**
 *  Check whether a string is empty.
 */
- (BOOL)isStringEmpty;

/**
 *  Check whether a string contains a give string with case insensitive match.
 */
- (BOOL)isStringContainTextCaseInsensitive:(NSString *)searchText;

/**
 *  Check whether the length of a string is between minLength ~ maxLength.
 */
- (BOOL)isStringLengthBetween:(NSInteger)minLength and:(NSInteger)maxLength;

/**
 *  Check whether the length of a string is less than the minLength or more than the maxLength.
 */
- (BOOL)isStringLengthLessthan:(NSInteger)minLength orMorethan:(NSInteger)maxLength;

#pragma mark - CharacterSet Validation

/**
 * Check whether a string contains characters in a given string set.
 */
- (BOOL)isStringContainsCharactersInSet:(NSString *)setString;

/**
 * Check whether a string contains character in float number format.
 */
- (BOOL)isStringContainFloatNumber;

@end
