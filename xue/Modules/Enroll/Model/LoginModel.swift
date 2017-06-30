//
//  LoginModel.swift
//  xue
//
//  Created by Arron Zhu on 16/11/7.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import MJExtension

class LoginModel: NSObject {
    
    var phone: NSString?
    var nickname: NSString?
    var avatar: NSString?
    var token: NSString?
    var refresh_token: NSString?
    var levelId: NSString?
    var pid: NSString?
    var balance: NSString?
    var wechatname: NSString?
    var ikneiname: NSString?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["levelId" : "level_id"]
    }
}

class LevelModel: NSObject {
    
    var levelId: String?
    var name: String?
    var isshow: String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["levelId" : "id"]
    }
}
