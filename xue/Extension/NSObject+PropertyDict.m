//
//  NSObject+PropertyDict.m
//  ROMOOM
//
//  Created by Arron Zhu on 16/3/1.
//  Copyright © 2016年 Daboo. All rights reserved.
//

#import "NSObject+PropertyDict.h"
#import "objc/runtime.h"

@implementation NSObject (PropertyDict)

- (NSDictionary *)propertyValuesDictionary {
    Class selfClass = [self class];
    u_int count;
    
    objc_property_t *properties = class_copyPropertyList(selfClass, &count);
    NSMutableDictionary *propertyDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        
        NSString *key = [NSString stringWithCString:propertyName encoding:NSASCIIStringEncoding];
        @try {
            id value = [self valueForKey:key];
            if (value)
                [propertyDictionary setObject:value forKey:key];
        } @catch (NSException *exception) {
            NSLog(@"exception: %@", exception);
        }
    }
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:propertyDictionary];
}

- (NSArray *)propertyKeys {
    NSMutableArray *keyArray = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if (propName) {
            NSString *propertyName = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            [keyArray addObject:propertyName];
        }
    }
    free(properties);
    return keyArray;
}

@end
