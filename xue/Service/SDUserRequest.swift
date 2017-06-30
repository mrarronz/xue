//
//  SDUserRequest.swift
//  xue
//
//  Created by Arron Zhu on 16/11/4.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

enum SDLoginRequestType {
    case Phone, iKnei
}

/**
 * 手机号或课内网账号登录
 */
class SDLoginRequest: SDBaseRequest {
    
    var userName: NSString?
    var pwd: NSString?
    var loginType: SDLoginRequestType?
    
    init(userName: NSString, password: NSString, loginType: SDLoginRequestType) {
        super.init()
        self.userName = userName
        self.pwd = password
        self.loginType = loginType
    }
    
    override func requestUrl() -> String {
        if self.loginType == .iKnei {
            return "/api/iknLogin"
        }
        return "/api/login"
    }
    
    override func requestParams() -> NSDictionary {
        if self.loginType == .iKnei {
            return ["username": userName!, "password": pwd!]
        }
        else if self.loginType == .Phone {
            return ["phone": userName!, "password": pwd!]
        }
        else {
            return NSDictionary.init()
        }
    }
}

/**
 *  微信登录
 */
class SDWechatLoginRequest: SDBaseRequest {
    
    var openId: NSString?
    var accessToken: NSString?
    
    init(openId: NSString, accessToken: NSString) {
        super.init()
        self.openId = openId
        self.accessToken = accessToken
    }
    
    override func requestUrl() -> String {
        return "/api/wxChat"
    }
    
    override func requestParams() -> NSDictionary {
        return ["openId" : openId!, "access_token" : accessToken!]
    }
}

/**
 * 游客登录
 */
class SDGuestLoginRequest: SDBaseRequest {
    
    var deviceId: NSString?
    
    init(deviceId: NSString) {
        super.init()
        self.deviceId = deviceId
    }
    
    override func requestUrl() -> String {
        return "/api/iosLogin"
    }
    
    override func requestParams() -> NSDictionary {
        return ["uuid" : deviceId!]
    }
}

/**
 * 注册接口
 */
class SDRegisterRequest: SDBaseRequest {
    
    var uname: NSString?
    var phone: NSString?
    var pwd: NSString?
    var code: NSString?
    var levelId: NSString?
    
    init(uname: NSString?, phone: NSString?, password: NSString?, smsCode: NSString?, levelId:NSString?) {
        super.init()
        self.uname = uname
        self.phone = phone
        self.pwd = password
        self.code = smsCode
        self.levelId = levelId
    }
    
    override func requestUrl() -> String {
        return "/api/register"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if self.uname != nil {
            dict.setObject(self.uname!, forKey: "nickname" as NSCopying)
        }
        if self.phone != nil {
            dict.setObject(self.phone!, forKey: "phone" as NSCopying)
        }
        if self.pwd != nil {
            dict.setObject(self.pwd!, forKey: "password" as NSCopying)
        }
        if self.code != nil {
            dict.setObject(self.code!, forKey: "code" as NSCopying)
        }
        if self.levelId != nil {
            dict.setObject(self.levelId!, forKey: "levelId" as NSCopying)
        }
        return dict
    }
}

/**
 * 发送验证码
 */
class SDSendSmsCodeRequest: SDBaseRequest {
    
    var phone: NSString?
    var type: NSString?
    
    init(phone: NSString?, type: NSString?) {
        super.init()
        self.phone = phone
        self.type = type
    }
    
    override func requestUrl() -> String {
        return "/api/sendCode"
    }
    
    override func requestParams() -> NSDictionary {
        return ["phone" : phone!, "type" : type!]
    }
}

/**
 * 找回密码
 */
class SDFindPwdRequest: SDBaseRequest {
    
    var phone: NSString?
    var code: NSString?
    var password: NSString?
    var repassword: NSString?
    
    init(phone: NSString, code: NSString, password: NSString, repassword: NSString) {
        super.init()
        self.phone = phone
        self.code = code
        self.password = password
        self.repassword = repassword
    }
    
    override func requestUrl() -> String {
        return "/api/findPwd"
    }
    
    override func requestParams() -> NSDictionary {
        return ["phone":phone!,
                "code" : code!,
                "password": password!,
                "repassword" : repassword!]
    }
}

/**
 *  修改密码
 */
class SDChangePwdRequest: SDBaseRequest {
    
    var oldPwd: NSString?
    var newPwd: NSString?
    
    init(oldPwd: NSString, newPwd: NSString) {
        super.init()
        self.oldPwd = oldPwd
        self.newPwd = newPwd
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/changePwd"
    }
    
    override func requestParams() -> NSDictionary {
        return ["password" : oldPwd!, "newPass" : newPwd!]
    }
}

/**
 * 修改昵称
 */
class SDUpdateNicknameRequest: SDBaseRequest {
    
    var nickName: NSString?
    
    init(nickName: NSString) {
        super.init()
        self.nickName = nickName
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/saveNickname"
    }
    
    override func requestParams() -> NSDictionary {
        return ["nickname" : nickName!]
    }
}

/**
 *  修改头像
 */
class SDUpdateAvatarRequest: SDBaseRequest {
    
    var avatar: NSString?
    
    init(avatar: NSString) {
        super.init()
        self.avatar = avatar
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/upAvatar"
    }
    
    override func requestParams() -> NSDictionary {
        return ["img" : avatar!]
    }
}

/**
 * 绑定手机号
 */
class SDBindPhoneRequest: SDBaseRequest {
    
    var phone: NSString?
    var code: NSString?
    
    init(phone: NSString, smsCode: NSString) {
        super.init()
        self.phone = phone
        self.code = smsCode
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/bindPhone"
    }
    
    override func requestParams() -> NSDictionary {
        return ["phone" : phone!, "code": code!]
    }
}

/**
 *  绑定账号
 */
class SDBindAccountRequest: SDBaseRequest {
    
    var type: NSString?
    var loginType: NSString?
    var openId: NSString?
    var accessToken: NSString?
    var username: NSString?
    var password: NSString?
    
    init(type: NSString?, loginType: NSString?, openId: NSString?, accessToken: NSString?, username: NSString?, password: NSString?) {
        super.init()
        self.type = type
        self.loginType = loginType
        self.openId = openId
        self.accessToken = accessToken
        self.username = username
        self.password = password
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/bindAccount"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if type != nil {
            dict.setObject(type!, forKey: "type" as NSCopying)
        }
        if loginType != nil {
            dict.setObject(loginType!, forKey: "loginType" as NSCopying)
        }
        if openId != nil {
            dict.setObject(openId!, forKey: "openId" as NSCopying)
        }
        if accessToken != nil {
            dict.setObject(accessToken!, forKey: "access_token" as NSCopying)
        }
        if username != nil {
            dict.setObject(username!, forKey: "username" as NSCopying)
        }
        if password != nil {
            dict.setObject(password!, forKey: "password" as NSCopying)
        }
        return dict
    }
}


