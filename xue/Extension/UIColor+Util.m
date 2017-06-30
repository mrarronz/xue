//
//  UIColor+Util.m
//  xue
//
//  Created by Arron Zhu on 16/6/28.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

- (UIImage *)colorToImage {
    return [self imageWithColorInRect:CGRectMake(0, 0, 1, 1)];
}

- (UIImage *)imageWithColorInRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)sd_navigationColor {
    return [self colorWithHexString:@"#00c06d"]; //F83022
}

+ (UIColor *)sd_blackColor {
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)sd_darkGrayColor {
    return [self colorWithHexString:@"#666666"];
}

+ (UIColor *)sd_darkGreenColor {
    return [self colorWithHexString:@"#009933"];
}

+ (UIColor *)sd_backgroundColor {
    return [self colorWithHexString:@"#F0F0F0"];
}

+ (UIColor *)sd_priceColor {
    return [self colorWithHexString:@"ff7500"];
}

+ (UIColor *)sd_lightGrayColor {
    return [self colorWithHexString:@"#999999"];
}

+ (UIColor *)sd_searchViewColor {
    return [self colorWithHexString:@"#009A57"];
}

+ (UIColor *)sd_borderColor {
    return [self colorWithHexString:@"#d9d5d4"];
}

+ (UIColor *)sd_separatorColor {
    return [self colorWithHexString:@"#e7e7e7"];
}

+ (UIColor *)sd_placeholderColor {
    return [self colorWithHexString:@"#EDEDED"];
}

+ (UIColor *)sd_blueColor {
    return [self colorWithHexString:@"#2585DE"];
}

+ (UIColor *)sd_tagYellowColor {
    return [self colorWithHexString:@"F9CF34"];
}

+ (UIColor *)sd_tagBlueColor {
    return [self colorWithHexString:@"3D95F9"];
}

+ (UIColor *)sd_tagPinkColor {
    return [UIColor colorWithHexString:@"F99482"];
}

+ (UIColor *)sd_tagPurpleColor {
    return [UIColor colorWithHexString:@"B3A1F9"];
}

@end
