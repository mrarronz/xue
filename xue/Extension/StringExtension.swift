//
//  StringExtension.swift
//  xue
//
//  Created by Arron Zhu on 16/10/23.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func stringFromDate(date:Date) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func stringFromDate(date:Date, format:String) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func dateString(numDate:String, formatter:DateFormatter) -> String {
        let timeInterval = TimeInterval(self)
        let date = Date.init(timeIntervalSince1970: timeInterval!)
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter.init()
        return dateFormatter
    }
    
    func numberString() -> String {
        let number: NSNumber = NSNumber.init(value: Float(self)!)
        return number.stringValue
    }
    
//    static func attributed(_ fullString: String, _ highlighted: String, _ attributes: NSDictionary) -> NSAttributedString {
//        let wholeStr = NSMutableAttributedString.init(string: fullString)
//        let range: NSRange = (fullString as NSString).range(of: highlighted)
//        wholeStr.setAttributes((attributes as! [String : Any]), range: range)
//        return wholeStr
//    }
//    
//    static func attributed(_ fullString: String, _ highlighted: String, _ font: UIFont) -> NSAttributedString {
//        let wholeStr = NSMutableAttributedString.init(string: fullString)
//        let range: NSRange = (fullString as NSString).range(of: highlighted)
//        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.sd_price()]
//        wholeStr.setAttributes(attributes, range: range)
//        return wholeStr
//    }
}
