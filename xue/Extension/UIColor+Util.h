//
//  UIColor+Util.h
//  xue
//
//  Created by Arron Zhu on 16/6/28.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

/**
 *  将颜色转换为图片，这种情况是按照宽高都为1px来拉伸的，图片可能会失真
 */
- (UIImage *)colorToImage;

/**
 *  在指定的rect范围内将颜色转换为图片
 */
- (UIImage *)imageWithColorInRect:(CGRect)rect;

/**
 *  将给定的十六进制色值(#FFFF00或FFFF00)字符串转为相应的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  导航栏颜色#00c06d
 */
+ (UIColor *)sd_navigationColor;

/**
 *  字体颜色#333333
 */
+ (UIColor *)sd_blackColor;

/**
 *  字体颜色#666666
 */
+ (UIColor *)sd_darkGrayColor;

/**
 *  字体颜色#999999
 */
+ (UIColor *)sd_lightGrayColor;

/**
 *  字体颜色#009933
 */
+ (UIColor *)sd_darkGreenColor;

/**
 *  ViewController默认背景颜色#F0F0F0
 */
+ (UIColor *)sd_backgroundColor;

/**
 *  价格颜色#ff7500
 */
+ (UIColor *)sd_priceColor;

/**
 *  输入框背景色#009A57
 */
+ (UIColor *)sd_searchViewColor;

/**
 *  边框、边线或背景的颜色#d9d5d4
 */
+ (UIColor *)sd_borderColor;

/**
 *  边线颜色#e7e7e7
 */
+ (UIColor *)sd_separatorColor;

/**
 *  图片背景颜色 #EDEDED
 */
+ (UIColor *)sd_placeholderColor;

/**
 *  题库、练习的蓝色 #2585de
 */
+ (UIColor *)sd_blueColor;

+ (UIColor *)sd_tagYellowColor;
+ (UIColor *)sd_tagBlueColor;
+ (UIColor *)sd_tagPinkColor;
+ (UIColor *)sd_tagPurpleColor;

@end
