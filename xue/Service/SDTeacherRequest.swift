//
//  SDTeacherRequest.swift
//  xue
//
//  Created by Arron Zhu on 16/11/4.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

class SDTeacherListRequest: SDBaseRequest {
    
    override func requestUrl() -> String {
        return "/api/teacherList"
    }
}

class SDTeacherDetailRequest: SDBaseRequest {
    
    var teacherId: NSString?
    
    init(teacherId: NSString) {
        super.init()
        self.teacherId = teacherId
    }
    
    override func requestUrl() -> String {
        return "/api/teacherData"
    }
    
    override func requestParams() -> NSDictionary {
        return ["id" : teacherId!]
    }
}
