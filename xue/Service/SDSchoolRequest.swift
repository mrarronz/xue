//
//  SDSchoolRequest.swift
//  xue
//
//  我的学堂
//
//  Created by Arron Zhu on 16/11/4.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

/**
 * 我的课程
 */
class SDMyCourseRequest: SDBaseRequest {
    
    var page: Int?
    
    init(page: Int) {
        super.init()
        self.page = page
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/myCourse"
    }
    
    override func requestParams() -> NSDictionary {
        return ["page" : page!]
    }
}

/**
 *  我的收藏
 */
class SDMyCollectionRequest: SDBaseRequest {
    
    var page: Int?
    
    init(page: Int) {
        super.init()
        self.page = page
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/attentList"
    }
    
    override func requestParams() -> NSDictionary {
        return ["page" : page!]
    }
}

/**
 *  我的题库
 */
class SDMyTikuRequest: SDBaseRequest {
    
    var page: Int?
    
    init(page: Int) {
        super.init()
        self.page = page
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/myPaper"
    }
    
    override func requestParams() -> NSDictionary {
        return ["page" : page!]
    }
}

/**
 *  错题本
 */
class SDErrorBookRequest: SDBaseRequest {
    
    var page: Int?
    var subjectId: NSString?
    var days: NSString?
    
    init(page: Int, subjectId: NSString?, days: NSString?) {
        super.init()
        self.page = page
        self.subjectId = subjectId
        self.days = days
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/errorBook"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if subjectId != nil {
            dict.setObject(subjectId!, forKey: "subjectId" as NSCopying)
        }
        if days != nil {
            dict.setObject(days!, forKey: "days" as NSCopying)
        }
        dict.setObject(page!, forKey: "page" as NSCopying)
        return dict
    }
}

/**
 *  模考分析
 */
class SDExamAnalysisRequest: SDBaseRequest {
    
    var phone: NSString?
    
    init(phone: NSString) {
        super.init()
        self.phone = phone
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/mkAnalysis"
    }
    
    override func requestParams() -> NSDictionary {
        return ["phone" : phone!]
    }
}

/**
 *  智慧套餐列表
 */
class SDPackageListRequest: SDBaseRequest {
    
    var page: Int?
    var levelId: NSString?
    var isNew: Bool?
    var isHot: Bool?
    var isFree: Bool?
    
    init(page: Int?, levelId: NSString?, isNew: Bool, isHot: Bool, isFree: Bool) {
        super.init()
        self.page = page
        self.levelId = levelId
        self.isNew = isNew
        self.isHot = isHot
        self.isFree = isFree
    }
    
    override func requestUrl() -> String {
        return "/api/packageList"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if levelId != nil {
            dict.setObject(levelId!, forKey: "levelId" as NSCopying)
        }
        if page != nil {
            dict.setObject(page!, forKey: "page" as NSCopying)
        }
        dict.setObject(isNew!, forKey: "isnew" as NSCopying)
        dict.setObject(isHot!, forKey: "ishot" as NSCopying)
        dict.setObject(isFree!, forKey: "isfree" as NSCopying)
        return dict
    }
}

/**
 *  智慧套餐详情
 */
class SDPackageDetailRequest: SDBaseRequest {
    
    var packageId: NSString?
    
    init(packageId: NSString) {
        super.init()
        self.packageId = packageId
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/packageDetail"
    }
    
    override func requestParams() -> NSDictionary {
        return ["id" : packageId!]
    }
}

/**
 *  录播课题目开始学习
 */
class SDStartPracticeRequset: SDBaseRequest {
    
    var courseId: NSString?
    
    init(courseId: NSString?) {
        super.init()
        self.courseId = courseId
    }
    
    override func requestUrl() -> String {
        return "/api/startPractice"
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if courseId != nil {
            dict.setObject(courseId!, forKey: "id" as NSCopying)
        }
        return dict
    }
}

/**
 *  录播课提交答题
 */
class SDSavePracticeRequest: SDBaseRequest {
    
    var courseId: NSString?
    var answer: NSString?
    
    init(courseId: NSString?, answer: NSString?) {
        super.init()
        self.courseId = courseId
        self.answer = answer
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/savePractice"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if courseId != nil {
            dict.setObject(courseId!, forKey: "cid" as NSCopying)
        }
        if answer != nil {
            dict.setObject(answer!, forKey: "ids" as NSCopying)
        }
        return dict
    }
}

/**
 *  练习题
 */
class SDPracticeListRequest: SDBaseRequest {
    
    var courseId: NSString?
    
    init(courseId: NSString?) {
        super.init()
        self.courseId = courseId
    }
    
    override func requestUrl() -> String {
        return "/api/practiceList"
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if courseId != nil {
            dict.setObject(courseId!, forKey: "id" as NSCopying)
        }
        return dict
    }
}

/**
 *  变形题
 */
class SDTransformRequest: SDBaseRequest {
    var courseId: NSString?
    
    init(courseId: NSString?) {
        super.init()
        self.courseId = courseId
    }
    
    override func requestUrl() -> String {
        return "/api/transform"
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if courseId != nil {
            dict.setObject(courseId!, forKey: "id" as NSCopying)
        }
        return dict
    }
}

