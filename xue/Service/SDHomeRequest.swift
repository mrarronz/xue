//
//  SDHomeRequest.swift
//  xue
//
//  Created by Arron Zhu on 16/11/4.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

/**
 *  获取首页轮播图
 */
class SDFlashImageRequest: SDBaseRequest {
    
    override func requestUrl() -> String {
        return "/api/flash"
    }
}

/**
 *  获取首页推荐课程
 */
class SDRecommendRequest: SDBaseRequest {
    
    var pageIndex: Int?
    var levelId: String?
    var gradeId: String?
    var subjectId: String?
    
    init(page: Int, levelId: String?, gradeId: String?, subjectId: String?) {
        super.init()
        self.pageIndex = page
        self.levelId = levelId
        self.gradeId = gradeId
        self.subjectId = subjectId
    }
    
    override func requestUrl() -> String {
        return "/api/recommend"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if self.levelId != nil {
            dict.setObject(self.levelId!, forKey: "levelId" as NSCopying)
        }
        if self.gradeId != nil {
            dict.setObject(self.gradeId!, forKey: "gradeId" as NSCopying)
        }
        if self.subjectId != nil {
            dict.setObject(self.subjectId!, forKey: "subjectId" as NSCopying)
        }
        dict.setObject(self.pageIndex!, forKey: "page" as NSCopying)
        return dict
    }
}

/**
 *  获取首页最新课程
 */
class SDLatestCourseRequest: SDBaseRequest {
    
    var levelId: String?
    var gradeId: String?
    var subjectId: String?
    
    init(levelId: String?, gradeId: String?, subjectId: String?) {
        super.init()
        self.levelId = levelId
        self.gradeId = gradeId
        self.subjectId = subjectId
    }
    
    override func requestUrl() -> String {
        return "/api/newCourse"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if self.levelId != nil {
            dict.setObject(self.levelId!, forKey: "levelId" as NSCopying)
        }
        if self.gradeId != nil {
            dict.setObject(self.gradeId!, forKey: "gradeId" as NSCopying)
        }
        if self.subjectId != nil {
            dict.setObject(self.subjectId!, forKey: "subjectId" as NSCopying)
        }
        return dict
    }
}

/**
 *  获取首页精选题库
 */
class SDFeaturedTikuRequest: SDBaseRequest {
    
    var pageIndex: Int?
    var levelId: String?
    
    init(page: Int, levelId: String?) {
        super.init()
        self.pageIndex = page
        self.levelId = levelId
    }
    
    override func requestUrl() -> String {
        return "/api/tikuSelect"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if self.levelId != nil {
            dict.setObject(self.levelId!, forKey: "levelId" as NSCopying)
        }
        dict.setObject(self.pageIndex!, forKey: "page" as NSCopying)
        return dict
    }
}

/**
 * 搜索接口
 */
class SDSearchRequest: SDBaseRequest {
    
    var keywords: String?
    
    init(keywords: String?) {
        super.init()
        self.keywords = keywords
    }
    
    override func requestUrl() -> String {
        return "/api/getSearch"
    }
    
    override func requestParams() -> NSDictionary {
        if keywords == nil {
            keywords = ""
        }
        return ["keywords" : keywords!]
    }
}
