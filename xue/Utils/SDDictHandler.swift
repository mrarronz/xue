//
//  SDDictHandler.swift
//  xue
//
//  Created by Arron Zhu on 16/10/13.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDDictHandler: NSObject {
    
    var globalDict:NSDictionary?
    
    static let instance = SDDictHandler()
    
    override init() {
        let filePath = Bundle.main.path(forResource: "SDGlobalConfig", ofType: "plist")
        self.globalDict = NSDictionary.init(contentsOfFile: filePath!)
    }
    
    func tabbarItems() -> NSArray {
        return self.globalDict?.object(forKey: "TabbarItems") as! NSArray
    }
    
    func userOptions() -> NSArray {
        return self.globalDict?.object(forKey: "UserCenterItems") as! NSArray
    }
    
    func homeItems() -> NSArray {
        return self.globalDict?.object(forKey: "HomeItems") as! NSArray
    }
}
