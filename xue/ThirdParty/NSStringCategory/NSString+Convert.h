//
//  NSString+Convert.h
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Convert)

/**
 * Convert json string to object.
 * @return an object
 */
- (id)jsonStringToObject;

/**
 * Convert an object to json string.
 * @return NSString
 */
+ (NSString *)stringFromJsonObject:(id)object;

/**
 * Transfer string data value.
 */
+ (NSString *)replacedStringWithOriginal:(NSString *)originalStr replaceData:(NSString *)data;

/**
 * Convert a character string to an array, the array contains each character in the string.
 */
- (NSArray *)stringToArray;

/**
 * Generate a QRCode image with a given string.
 */
- (UIImage *)generateQRCodeImage;

/**
 * Calculate age with a date string.
 */
- (int)ageFromBirthday;

/**
 * Convert base64 encoded string to NSData.
 */
- (NSData *)base64EncodedStringToData;

/**
 * Convert NSData to base64 encoded string.
 */
+ (NSString *)base64EncodedStringFromData:(NSData *)data;

/**
 * Generate a unique UUID string.
 */
+ (NSString *)uniqueString;

/**
 *  Convert string to formatted number string.
 */
- (NSString *)numberString;

/**
 * Convert current string to mac address format.
 */
- (NSString *)formattedMacAddress;

/**
 * Convert a dictionary to string format, used for generating string params for GET request.
 */
- (NSString *)stringWithRequestParams:(NSDictionary *)requestParams;

/**
 * Convert a dictionary to string and append to an existed string.
 */
- (NSString *)stringByAppendingParams:(NSDictionary *)params;

@end
