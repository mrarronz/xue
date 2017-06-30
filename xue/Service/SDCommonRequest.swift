//
//  SDCommonRequest.swift
//  xue
//
//  Created by Arron Zhu on 16/11/3.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

/**
 *  获取学段
 */
class SDGetLevelRequest: SDBaseRequest {
    
    override func requestUrl() -> String {
        return "/api/level"
    }
    
    override func cacheTimeInSeconds() -> Int {
        return 60*60*24
    }
}

/**
 *  获取年级
 */
class SDGetGradeRequest: SDBaseRequest {
    
    var levelId: NSString?
    
    init(levelId: NSString) {
        super.init();
        self.levelId = levelId
    }
    
    override func requestUrl() -> String {
        return "/api/grade"
    }
    
    override func requestParams() -> NSDictionary {
        return NSDictionary.init(object: self.levelId!, forKey: "levelId" as NSCopying)
    }
    
    override func cacheTimeInSeconds() -> Int {
        return 60*60*24
    }
}

/**
 *  获取科目
 */
class SDGetSubjectRequest: SDBaseRequest {
    
    var gradeId: NSString?
    
    init(gradeId: NSString) {
        super.init()
        self.gradeId = gradeId
    }
    
    override func requestUrl() -> String {
        return "/api/subject"
    }
    
    override func requestParams() -> NSDictionary {
        return NSDictionary.init(object: self.gradeId!, forKey: "gradeId" as NSCopying)
    }
    
    override func cacheTimeInSeconds() -> Int {
        return 60*60*24
    }
}

/**
 *  获取省份
 */
class SDGetProvinceRequest: SDBaseRequest {
    
    override func requestUrl() -> String {
        return "/api/getProvince"
    }
    
    override func cacheTimeInSeconds() -> Int {
        return 60*60*24
    }
}

/**
 *  根据省份获取城市
 */
class SDGetCityRequest: SDBaseRequest {
    
    var provinceId: NSString?
    
    init(provinceId: NSString) {
        super.init()
        self.provinceId = provinceId
    }
    
    override func requestUrl() -> String {
        return "/api/getCity"
    }
    
    override func requestParams() -> NSDictionary {
        return NSDictionary.init(object: self.provinceId!, forKey: "proId" as NSCopying)
    }
    
    override func cacheTimeInSeconds() -> Int {
        return 60*60*24
    }
}

/**
 *  获取年份
 */
class SDGetYearRequest: SDBaseRequest {
    
    override func requestUrl() -> String {
        return "/api/getYear"
    }
    
    override func cacheTimeInSeconds() -> Int {
        return 60*60*24
    }
}

/**
 *  获取学校
 */
class SDGetSchoolRequest: SDBaseRequest {
    
    var regionId: NSString?
    
    init(regionId: NSString) {
        super.init()
        self.regionId = regionId
    }
    
    override func requestUrl() -> String {
        return "/api/getSchool"
    }
    
    override func requestParams() -> NSDictionary {
        return NSDictionary.init(object: self.regionId!, forKey: "regionId" as NSCopying)
    }
    
    override func cacheTimeInSeconds() -> Int {
        return 60*60*24
    }
}

/**
 *  检查app的版本更新
 */
class SDCheckUpdateRequest: SDBaseRequest {
    
    var version: NSString?
    
    init(version: NSString) {
        super.init()
        self.version = version
    }
    
    override func requestUrl() -> String {
        return "/api/Appupdate"
    }
    
    override func requestParams() -> NSDictionary {
        return NSDictionary.init(object: self.version!, forKey: "version" as NSCopying)
    }
}

