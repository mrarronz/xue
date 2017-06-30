//
//  NSString+Filter.h
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Filter)

/**
 * Return a string without white space and new line space.
 * @return NSString
 */
- (NSString *)trim;

/**
 * Return a string without white space.
 */
- (NSString *)stringByTrimmingWhiteSpace;

/**
 * Return a string with Capitalized first character.
 */
- (NSString *)stringByCapitalizeFirstLetter;

/**
 * Return a string with lowercase first letter.
 */
- (NSString *)stringByLowercaseFirstLetter;

/**
 * Substring to the location of a given character, example: "http://www.baidu.com", get "http://www.baidu", use [@"http://www.baidu.com" substringToLastCharacter:@"."]
 */
- (NSString *)substringToLastCharacter:(NSString *)character;

/**
 * Substring after the location of a given character, example: "http://www.baidu.com", get "com", use [@"http://www.baidu.com" substringFromLastCharacter:@"."]
 */
- (NSString *)substringFromLastCharacter:(NSString *)character;

/**
 * Substring between two substrings, example: "123456", get "34", use [@"12345" substringBetweenSubstrings:@"2" and:@"5"]
 */
- (NSString *)substringBetweenSubstrings:(NSString *)startString and:(NSString *)endString;

@end
