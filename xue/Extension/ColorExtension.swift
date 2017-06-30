//
//  ColorExtension.swift
//  xue
//
//  Created by Arron Zhu on 16/10/18.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    func imageWithColor(rect:CGRect) -> UIImage {
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func colorToImage() -> UIImage {
        return imageWithColor(rect: CGRect.init(x: 0, y: 0, width: 1, height: 1))
    }
    
    open class func color(hexString:String) -> UIColor {
        var cString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cString.characters.count < 6 {
            return UIColor.clear
        }
        
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        if cString.characters.count != 6 {
            return UIColor.clear
        }
        
        var range = NSRange.init(location: 0, length: 2)
        
        //r
        let rString = (cString as NSString).substring(with: range)
        
        //g
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        //b
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        // Scan values
        var r:UInt64?, g:UInt64?, b:UInt64?
        Scanner.init(string: rString).scanHexInt64(&r!)
        Scanner.init(string: gString).scanHexInt64(&g!)
        Scanner.init(string: bString).scanHexInt64(&b!)
        
        return UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }
}
