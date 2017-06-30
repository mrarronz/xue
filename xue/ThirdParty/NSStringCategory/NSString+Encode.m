//
//  NSString+Encode.m
//  NSStringCategoryKit
//
//  Created by Arron Zhu on 16/4/19.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "NSString+Encode.h"
#import "NSString+Convert.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Encode)

/**
 *  Encode string with MD5 encryption.
 */
- (NSString *)md5String {
    if (self == nil || self.length == 0) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

#pragma mark - DES
/**
 *  Encode string with DES encryption.
 */
- (NSString *)DESEncryptedString {
    return [[self class] textEncrypt:self];
}

/**
 *  Decode string with DES decryption.
 */
- (NSString *)DESDecryptedString {
    return [[self class] textDecrypt:self];
}

+ (NSString *)textEncrypt:(NSString *)text {
    if (text && ![text isEqualToString:@""]) {
        // Get bundleIdentifier of program as KEY
        NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        // DES Encrypt of iOS
        data = [self DESEncrypt:data WithKey:key];
        return [NSString base64EncodedStringFromData:data];
    } else {
        return @"";
    }
}

+ (NSString *)textDecrypt:(NSString *)base64 {
    if (base64 && ![base64 isEqualToString:@""]) {
        // Get bundleIdentifier of program as KEY
        NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [base64 base64EncodedStringToData];
        // DES Decrypt of iOS
        data = [self DESDecrypt:data WithKey:key];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return @"";
    }
}


+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeDES, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}


+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeDES, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}


@end
