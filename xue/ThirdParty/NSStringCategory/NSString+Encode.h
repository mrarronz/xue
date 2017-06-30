//
//  NSString+Encode.h
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encode)

/**
 *  Encode string with MD5 encryption.
 */
- (NSString *)md5String;

/**
 *  Encode string with DES encryption.
 */
- (NSString *)DESEncryptedString;

/**
 *  Decode string with DES decryption.
 */
- (NSString *)DESDecryptedString;

@end
