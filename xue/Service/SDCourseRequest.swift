//
//  SDCourseRequest.swift
//  xue
//  选课大厅
//  Created by Arron Zhu on 16/11/4.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

/**
 * 选课大厅-录播课程列表
 */
class SDCourseListRequest: SDBaseRequest {
    
    var levelId: NSString?
    var gradeId: NSString?
    var subjectId: NSString?
    var isHot: Bool?
    var isNew: Bool?
    var isFree: Bool?
    var page: Int?
    
    init(page: Int,
         levelId: NSString?,
         gradeId: NSString?,
         subjectId: NSString?,
         isHot: Bool,
         isNew: Bool,
         isFree: Bool) {
        super.init()
        self.page = page
        self.levelId = levelId
        self.gradeId = gradeId
        self.subjectId = subjectId
        self.isHot = isHot
        self.isNew = isNew
        self.isFree = isFree
    }
    
    override func requestUrl() -> String {
        return "/api/courseList"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if levelId != nil {
            dict.setObject(levelId!, forKey: "levelId" as NSCopying)
        }
        if gradeId != nil {
            dict.setObject(gradeId!, forKey: "gradeId" as NSCopying)
        }
        if subjectId != nil {
            dict.setObject(subjectId!, forKey: "subjectId" as NSCopying)
        }
        dict.setObject(isHot!, forKey: "ishot" as NSCopying)
        dict.setObject(isNew!, forKey: "isnew" as NSCopying)
        dict.setObject(isFree!, forKey: "isfree" as NSCopying)
        dict.setObject(page!, forKey: "page" as NSCopying)
        return dict
    }
}

/**
 * 录播课详情
 */
class SDCourseDetailRequest: SDBaseRequest {
    
    var courseId: NSString?
    
    init(courseId: NSString) {
        super.init()
        self.courseId = courseId
    }
    
    // 这里需要根据是否登录来判断
    override func needToken() -> Bool {
        return kAppPreference.isAccountLogin()
    }
    
    override func requestUrl() -> String {
        return "/api/detail"
    }
    
    override func requestParams() -> NSDictionary {
        return ["id" : courseId!]
    }
}

/**
 * 选课大厅-微课列表
 */
class SDWeikeListRequest: SDBaseRequest {
    
    var levelId: NSString?
    var gradeId: NSString?
    var subjectId: NSString?
    var isHot: Bool?
    var isNew: Bool?
    var isFree: Bool?
    var page: Int?
    
    init(page: Int,
         levelId: NSString?,
         gradeId: NSString?,
         subjectId: NSString?,
         isHot: Bool,
         isNew: Bool,
         isFree: Bool) {
        super.init()
        self.page = page
        self.levelId = levelId
        self.gradeId = gradeId
        self.subjectId = subjectId
        self.isHot = isHot
        self.isNew = isNew
        self.isFree = isFree
    }
    
    override func requestUrl() -> String {
        return "/api/microList"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if levelId != nil {
            dict.setObject(levelId!, forKey: "levelId" as NSCopying)
        }
        if gradeId != nil {
            dict.setObject(gradeId!, forKey: "gradeId" as NSCopying)
        }
        if subjectId != nil {
            dict.setObject(subjectId!, forKey: "subjectId" as NSCopying)
        }
        dict.setObject(isHot!, forKey: "ishot" as NSCopying)
        dict.setObject(isNew!, forKey: "isnew" as NSCopying)
        dict.setObject(isFree!, forKey: "isfree" as NSCopying)
        dict.setObject(page!, forKey: "page" as NSCopying)
        return dict
    }
}

/**
 * 微课详情
 */
class SDWeikeDetailRequest: SDBaseRequest {
    
    var courseId: NSString?
    
    init(courseId: NSString) {
        super.init()
        self.courseId = courseId
    }
    
    // 这里需要根据是否登录来判断
    override func needToken() -> Bool {
        return kAppPreference.isAccountLogin()
    }
    
    override func requestUrl() -> String {
        return "/api/mdetail"
    }
    
    override func requestParams() -> NSDictionary {
        return ["id" : courseId!]
    }
}

enum SDCollectType {
    case Collect, Cancel
}

/**
 * 课程收藏和取消收藏
 */
class SDCollectCourseRequest: SDBaseRequest {
    
    var courseId: NSString?
    var courseType: NSString?
    var operationType: SDCollectType?
    
    init(courseId: NSString, courseType: NSString, operationType: SDCollectType) {
        super.init()
        self.courseId = courseId
        self.courseType = courseType
        self.operationType = operationType
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        if self.operationType == .Collect {
            return "/api/collect"
        }
        return "/api/delCollect"
    }
    
    override func requestParams() -> NSDictionary {
        return ["id": courseId!, "type" : courseType!]
    }
}

/**
 * 选课大厅-题库列表
 */
class SDTikuListRequest: SDBaseRequest {
    
    var levelId: NSString?
    var type: NSString?
    var year: NSString?
    var proId: NSString?
    var cityId: NSString?
    var subjectId: NSString?
    var gradeId: NSString?
    var isNew: Bool?
    var isHot: Bool?
    var isFree: Bool?
    
    init(levelId: NSString?,
         type: NSString?,
         year: NSString?,
         proId: NSString?,
         cityId: NSString?,
         subjectId: NSString?,
         gradeId: NSString?,
         isNew: Bool,
         isHot: Bool,
         isFree: Bool) {
        super.init()
        self.levelId = levelId
        self.type = type
        self.year = year
        self.proId = proId
        self.cityId = cityId
        self.subjectId = subjectId
        self.gradeId = gradeId
        self.isNew = isNew
        self.isHot = isHot
        self.isFree = isFree
    }
    
    override func requestUrl() -> String {
        return "/api/paperList"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if levelId != nil {
            dict.setObject(levelId!, forKey: "levelId" as NSCopying)
        }
        if type != nil {
            dict.setObject(type!, forKey: "type" as NSCopying)
        }
        if year != nil {
            dict.setObject(year!, forKey: "year" as NSCopying)
        }
        if proId != nil {
            dict.setObject(proId!, forKey: "proId" as NSCopying)
        }
        if cityId != nil {
            dict.setObject(cityId!, forKey: "cityId" as NSCopying)
        }
        if subjectId != nil {
            dict.setObject(subjectId!, forKey: "subjectId" as NSCopying)
        }
        if gradeId != nil {
            dict.setObject(gradeId!, forKey: "gradeId" as NSCopying)
        }
        dict.setObject(isNew!, forKey: "isnew" as NSCopying)
        dict.setObject(isHot!, forKey: "ishot" as NSCopying)
        dict.setObject(isFree!, forKey: "isfree" as NSCopying)
        return dict
    }
}

/**
 * 试卷详情
 */
class SDPaperDetailRequest: SDBaseRequest {
    
    var paperId: NSString?
    
    init(paperId: NSString) {
        super.init()
        self.paperId = paperId
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/paperOne"
    }
    
    override func requestParams() -> NSDictionary {
        return ["id" : paperId!]
    }
}


