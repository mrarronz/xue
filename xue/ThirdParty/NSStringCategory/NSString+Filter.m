//
//  NSString+Filter.m
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "NSString+Filter.h"

@implementation NSString (Filter)

/**
 * Return a string without white space and new line space.
 * @return NSString
 */
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 * Return a string without white space.
 */
- (NSString *)stringByTrimmingWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 * Return a string with Capitalized first character.
 */
- (NSString *)stringByCapitalizeFirstLetter {
    if (self == nil || self.length == 0) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) {
        [string appendString:[self substringFromIndex:1]];
    }
    return string;
}

/**
 * Return a string with lowercase first letter.
 */
- (NSString *)stringByLowercaseFirstLetter {
    if (self == nil || self.length == 0) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) {
        [string appendString:[self substringFromIndex:1]];
    }
    return string;
}

/**
 * Substring to the location of a given character, example: "http://www.baidu.com", get "http://www.baidu", use [@"http://www.baidu.com" substringToLastCharacter:@"."]
 */
- (NSString *)substringToLastCharacter:(NSString *)character {
    
    NSString *string = self;
    
    NSRange range = [string rangeOfString:character options:NSBackwardsSearch];
    
    while (range.location + 1 == string.length) {
        string = [string substringToIndex:string.length - 1];
        range = [string rangeOfString:character options:NSBackwardsSearch];
    }
    if (range.length > 0) {
        return  [string substringToIndex:range.location];
    } else {
        return string;
    }
}

/**
 * Substring after the location of a given character, example: "http://www.baidu.com", get "com", use [@"http://www.baidu.com" substringFromLastCharacter:@"."]
 */
- (NSString *)substringFromLastCharacter:(NSString *)character {
    NSString *string = self;
    
    NSRange range = [string rangeOfString:character options:NSBackwardsSearch];
    
    while (range.location + 1 == string.length) {
        string = [string substringToIndex:string.length - 1];
        range = [string rangeOfString:character options:NSBackwardsSearch];
    }
    if (range.length > 0) {
        return  [string substringFromIndex:range.location+1];
    } else {
        return string;
    }
}

/**
 * Substring between two substrings, example: "123456", get "34", use [@"12345" substringBetweenSubstrings:@"2" and:@"5"]
 */
- (NSString *)substringBetweenSubstrings:(NSString *)startString and:(NSString *)endString {
    NSRange startName = [self rangeOfString:startString];
    NSRange endName = [self rangeOfString:endString];
    NSString *resStr = @"";
    if ((startName.location < self.length) && (endName.location < self.length)) {
        if (startName.location + startName.length < endName.location) {
            resStr = [self substringWithRange:NSMakeRange(startName.location + startName.length, endName.location - startName.location - startName.length)];
        }
    }
    return resStr;
}

@end
