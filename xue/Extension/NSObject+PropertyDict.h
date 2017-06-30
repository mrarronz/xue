//
//  NSObject+PropertyDict.h
//  ROMOOM
//
//  Created by Arron Zhu on 16/3/1.
//  Copyright © 2016年 Daboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyDict)

- (NSDictionary *)propertyValuesDictionary;

- (NSArray *)propertyKeys;

@end
