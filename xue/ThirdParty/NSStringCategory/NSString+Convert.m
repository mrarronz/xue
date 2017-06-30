//
//  NSString+Convert.m
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "NSString+Convert.h"
#import <CoreImage/CoreImage.h>

static const char encodingCharacterSet[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (Convert)

/**
 * Convert json string to object.
 * @return an object
 */
- (id)jsonStringToObject {
    if (self.length > 0) {
        NSError *error = nil;
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"JSON parser error: %@", error.description);
        } else {
            return object;
        }
    }
    return nil;
}

/**
 * Convert an object to json string.
 * @return NSString
 */
+ (NSString *)stringFromJsonObject:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/**
 * Transfer string data value.
 */
+ (NSString *)replacedStringWithOriginal:(NSString *)originalStr replaceData:(NSString *)data {
    if ([data isKindOfClass:[NSNull class]] || data == nil) {
        return originalStr;
    }
    return data;
}

/**
 * Convert a character string to an array, the array contains each character in the string.
 */
- (NSArray *)stringToArray {
    NSMutableArray *charArray = [[NSMutableArray alloc] initWithCapacity:self.length];
    
    for (int i = 0; i < self.length; i ++) {
        NSString *charStr = [NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
        [charArray addObject:charStr];
    }
    return charArray;
}

/**
 * Generate a QRCode image with a given string.
 */
- (UIImage *)generateQRCodeImage {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1.
                                   orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    return image;
}

/**
 * Calculate age with a date string.
 */
- (int)ageFromBirthday {
    if (self.length < 1) {
        return 0;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:self];
    NSTimeInterval time = [date timeIntervalSinceNow] * (-1);
    int age = trunc(time / (60 * 60 * 24)) / 365;
    return age;
}

/**
 * Convert base64 encoded string to NSData.
 */
- (NSData *)base64EncodedStringToData {
    NSString *string = self;
    if (string == nil)
        return nil;
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL) {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++) {
            decodingTable[(short)encodingCharacterSet[i]] = i;
        }
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL) //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES) {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++) {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX) { //  Illegal character!
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1) { //  At least two characters are needed to produce one byte!
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/**
 * Convert NSData to base64 encoded string.
 */
+ (NSString *)base64EncodedStringFromData:(NSData *)data {
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length]) {
        char buffer[3] = {0, 0, 0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingCharacterSet[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingCharacterSet[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingCharacterSet[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else
            characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingCharacterSet[buffer[2] & 0x3F];
        else
            characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

/**
 * Generate a unique UUID string.
 */
+ (NSString *)uniqueString {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

/**
 *  Convert string to formatted number string.
 */
- (NSString *)numberString {
    NSNumber *number = @([self floatValue]);
    return number.stringValue;
}

/**
 * Convert current string to mac address format.
 */
- (NSString *)formattedMacAddress {
    
    NSMutableString *macAddress = [NSMutableString string];
    
    if ([self rangeOfString:@":"].length == 0) {
        for (int i = 0; i < self.length; i++) {
            NSString *str = [NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
            [macAddress appendString:str];
            
            if (i % 2 != 0 && i < self.length - 1) {
                [macAddress appendString:@":"];
            }
        }
    }
    if (macAddress.length == 0) {
        macAddress = [self mutableCopy];
    }
    return macAddress;
}

/**
 * Convert a dictionary to string format, used for generating string params for GET request.
 */
- (NSString *)stringWithRequestParams:(NSDictionary *)requestParams {
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:[requestParams count]];
    for (NSString *key in requestParams) {
        NSString *strValue = [NSString stringWithFormat:@"%@", [requestParams objectForKey:key]];
        [tmpArray addObject:[NSString stringWithFormat:@"%@=%@", key, strValue]];
    }
    NSString *finalString = [[self stringByAppendingFormat:@"?%@", [tmpArray componentsJoinedByString:@"&"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return finalString;
}

/**
 * Convert a dictionary to string and append to an existed string.
 */
- (NSString *)stringByAppendingParams:(NSDictionary *)params {
    NSString *str = self;
    NSStringCompareOptions compareOptions = NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1, NSString *obj2) {
        NSRange range = NSMakeRange(0, obj1.length);
        return [obj1 compare:obj2 options:compareOptions range:range];
    };
    
    NSArray *allKeys = [[params allKeys] sortedArrayUsingComparator:sort];
    for (int i = 0; i < allKeys.count; i++) {
        NSString *key = allKeys[i];
        id value = params[key];
        if ([value isKindOfClass:[NSURL class]]) {
            continue;
        }
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@", key, value]];
    }
    return str;
}

@end
