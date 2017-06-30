//
//  SDUIElementUtil.swift
//  xue
//
//  Created by Arron Zhu on 16/10/14.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation
import UIKit

let UI_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let UI_SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let kUserDefaults = SDUserDefaultsPreference.sharedInstance()
let kAppPreference = SDAppPreference.sharedInstance
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let kAppKeyWindow = UIApplication.shared.keyWindow

/**
 *  当前设备是否是4寸以下屏的机型
 */
var isBelowiPhone4: Bool {
    return UI_SCREEN_WIDTH < 375
}

/**
 *  字体的缩小倍率
 */
var fontRatio: CGFloat {
    return isBelowiPhone4 ? 1.25 : 1.0
}

/**
 *  重新计算的字体
 */
func textFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize/fontRatio)
}

// MARK: - CollectionView的配置项

/**
 *  当前设备是否是iPad
 */
func isPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

/**
 *  collectionView的sectionInsets属性
 */
func sectionInsets() -> UIEdgeInsets {
    return UIEdgeInsetsMake(12, 12, 12, 12)
}

/**
 *  相邻两个item之间的水平距离
 */
func itemSpacing() -> CGFloat {
    return 6
}

/**
 * 上下item之间的距离
 */
func lineSpacing() -> CGFloat {
    return 10
}

/**
 * 单个item的宽度
 */
func itemWidth() -> CGFloat {
    return (UI_SCREEN_WIDTH - sectionInsets().left - sectionInsets().right - itemSpacing() * 2) / 2
}

/**
 * 单个item的高度
 */
func itemHeight() -> CGFloat {
    return itemWidth() * 0.95
}

/**
 * 图片与边缘之间的间隙
 */
func imagePadding() -> CGFloat {
    return 5
}

/**
 * 图片的高度
 */
func imageHeight() -> CGFloat {
    let imageWidth = itemWidth() - imagePadding() * 2
    return iPhone6() ? 92 : (imageWidth/162)*92
}

/**
 * 首页轮播图高度
 */
func flashImageHeight() -> CGFloat {
    return UI_SCREEN_WIDTH * 680 / 1080
}

/**
 * 首页方格cell的高度
 */
func cellHeight(rows: CGFloat) -> CGFloat {
    if rows == 0 {
        return 0
    }
    let cellHeight = rows * itemHeight() + lineSpacing() * (rows - 1) + sectionInsets().top + sectionInsets().bottom
    return cellHeight
}

// MARK: - 判断系统版本
func systemVersionEquals(version: Float) -> Bool {
    let currentVersion = Float(UIDevice.current.systemVersion)!
    if currentVersion == version {
        return true
    }
    return false
}

func systemVersionGreaterThan(version: Float) -> Bool {
    let currentVersion = Float(UIDevice.current.systemVersion)!
    if currentVersion > version {
        return true
    }
    return false
}

func systemVersionGreaterThanOrEquals(version: Float) -> Bool {
    let currentVersion = Float(UIDevice.current.systemVersion)!
    if currentVersion >= version {
        return true
    }
    return false
}

func systemVersionLessThan(version: Float) -> Bool {
    let currentVersion = Float(UIDevice.current.systemVersion)!
    if currentVersion < version {
        return true
    }
    return false
}

func systemVersionLessThanOrEquals(version: Float) -> Bool {
    let currentVersion = Float(UIDevice.current.systemVersion)!
    if currentVersion <= version {
        return true
    }
    return false
}

// MARK: - 判断手机型号
func iPhone4() -> Bool {
    return __CGSizeEqualToSize((UIScreen.main.currentMode?.size)!, CGSize.init(width: 640, height: 960))
}

func iPhone5() -> Bool {
    return __CGSizeEqualToSize((UIScreen.main.currentMode?.size)!, CGSize.init(width: 640, height: 1136))
}

func iPhone6() -> Bool {
    return __CGSizeEqualToSize((UIScreen.main.currentMode?.size)!, CGSize.init(width: 750, height: 1334))
}

func iPhone6Plus() -> Bool {
    return __CGSizeEqualToSize((UIScreen.main.currentMode?.size)!, CGSize.init(width: 1242, height: 2208))
}

// MARK: - 简化通知写法
func addObserver(observer: Any, selector: Selector, name: String) {
    NotificationCenter.default.addObserver(observer,
                                           selector: selector,
                                           name: NSNotification.Name(rawValue:name),
                                           object: nil)
}

func removeObserver(observer: Any) {
    NotificationCenter.default.removeObserver(observer)
}

func removeObserver(observer: Any, name: String) {
    NotificationCenter.default.removeObserver(observer,
                                              name: NSNotification.Name(rawValue:name),
                                              object: nil)
}

func postNotification(name: String) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue:name), object: nil)
}

func postNotification(name: String, object: Any?) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue:name), object: object)
}

func postNotification(name: String, info: [AnyHashable : Any]?) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue:name), object: nil, userInfo: info)
}

// MARK: - 自定义log输出
func NALog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        print("-----------------------------------------------\n")
    #endif
}

