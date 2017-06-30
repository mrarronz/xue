//
//  HomeModel.swift
//  xue
//
//  Created by Arron Zhu on 16/11/7.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class FlashImageModel: NSObject {
    
    var pic: String?
    var type: String?
    var picId: String?
    var url: String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["picId" : "id"]
    }
}

class RecommendCourseModel: NSObject {
    
    var courseId: String?
    var title: String?
    var cover: String?
    var type: String?
    var buy_count: String?
    var price: String?
    var original_price: String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["courseId" : "id"]
    }
}

class HomeTikuModel: NSObject {
    
    var courseId: String?
    var level_id: String?
    var paper_title: String?
    var type: String?
    var buy_count: String?
    var price: String?
    var original_price: String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["courseId" : "id"]
    }
}
