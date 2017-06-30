//
//  SDYXTRequest.swift
//  xue
//
//  Created by Arron Zhu on 16/11/4.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

/**
 *  扫描二维码
 */
class SDScanQRCodeRequest: SDBaseRequest {
    
    var studyCode: NSString?
    var activateCode: NSString?
    var qrcodeId: NSString?
    
    init(qrcodeId: NSString?, activateCode: NSString?, studyCode: NSString?) {
        super.init()
        self.qrcodeId = qrcodeId
        self.activateCode = activateCode
        self.studyCode = studyCode
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/getQRcode"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if self.qrcodeId != nil {
            dict.setObject(self.qrcodeId!, forKey: "id" as NSCopying)
        }
        if self.activateCode != nil {
            dict.setObject(self.activateCode!, forKey: "a" as NSCopying)
        }
        if self.studyCode != nil {
            dict.setObject(self.studyCode!, forKey: "s" as NSCopying)
        }
        return dict
    }
}

/**
 * 激活码激活易学贴
 */
class SDActivateRequest: SDBaseRequest {
    
    var activateCode: NSString?
    
    init(activateCode: NSString?) {
        super.init()
        self.activateCode = activateCode
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/setQRcode"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if activateCode != nil {
            dict.setObject(activateCode!, forKey: "a" as NSCopying)
        }
        return dict
    }
}

/**
 * 易学贴缓存下载
 */
class SDYxtCachedInfoRequest: SDBaseRequest {
    
    var ids : NSString?
    
    init(ids: NSString?) {
        super.init()
        self.ids = ids
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/showAllInfo"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        
        if ids != nil {
            dict.setObject(ids!, forKey: "ids" as NSCopying)
        }
        return dict
    }
}

/**
 * 根据学习码获取书本中的所有学习码标题
 */
class SDYxtGetCacheListRequest: SDBaseRequest {
    
    var bookId: NSString?
    
    init(id: NSString?) {
        super.init()
        bookId = id
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/saveBook"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if bookId != nil {
            dict.setObject(bookId!, forKey: "id" as NSCopying)
        }
        return dict
    }
}

/**
 *  上传学习记录
 */
class SDYxtUploadStudyRequest: SDBaseRequest {
    
    var ids: NSString?
    var type: NSString?
    
    init(ids: NSString?, type: NSString?) {
        super.init()
        self.ids = ids
        self.type = type
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/saveStudy"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if ids != nil {
            dict.setObject(ids!, forKey: "ids" as NSCopying)
        }
        if type != nil {
            dict.setObject(type!, forKey: "type" as NSCopying)
        }
        return dict
    }
}

/**
 *  我的学堂-易学贴详情
 */
class SDYxtDetailRequest: SDBaseRequest {
    
    var bookId: NSString?
    
    init(bookId: NSString) {
        super.init()
        self.bookId = bookId
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/easyLearnDetail"
    }
    
    override func requestParams() -> NSDictionary {
        return ["id" : self.bookId!]
    }
}


/**
 *  易学贴在线激活
 */
class SDOnlineActivateRequest: SDBaseRequest {
    
    var qrcode: NSString?
    
    init(qrcode: NSString) {
        super.init()
        self.qrcode = qrcode
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/activeOnline"
    }
    
    override func requestParams() -> NSDictionary {
        return ["s" : qrcode!]
    }
}

/**
 *  易学贴在线激活生成订单
 */
class SDYxtPurchaseRequest: SDBaseRequest {
    
    var bookId: NSString?
    var title: NSString?
    var payment: NSString?
    
    init(bookId: NSString, title: NSString, payment: NSString) {
        super.init()
        self.bookId = bookId
        self.title = title
        self.payment = payment
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/buyQrcode"
    }
    
    override func requestParams() -> NSDictionary {
        return ["bookId" : bookId!, "title" : title!, "payMent" : payment!]
    }
}

/**
 *  易学贴在线激活验证手机号
 */
class SDYxtCheckPhoneRequest: SDBaseRequest {
    
    var phone: NSString?
    var code: NSString?
    
    init(phone: NSString, code: NSString) {
        super.init()
        self.phone = phone
        self.code = code
    }
    
    override func requestUrl() -> String {
        return "/api/checkPhoneCode"
    }
    
    override func requestParams() -> NSDictionary {
        return ["phone" : phone!, "code" : code!]
    }
}

/**
 *  完善学校信息接口
 */
class SDCompleteSchoolRequest: SDBaseRequest {
    
    var proId: NSString?
    var cityId: NSString?
    var regionId: NSString?
    var schoolId: NSString?
    var className: NSString?
    
    init(proId: NSString, cityId: NSString, regionId: NSString, schoolId: NSString, className: NSString) {
        super.init()
        self.proId = proId
        self.cityId = cityId
        self.regionId = regionId
        self.schoolId = schoolId
        self.className = className
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/saveSchool"
    }
    
    override func requestParams() -> NSDictionary {
        return ["proId" : proId!,
                "cityId" : cityId!,
                "regionId" : regionId!,
                "schoolId" : schoolId!,
                "classname" : className!]
    }
}
