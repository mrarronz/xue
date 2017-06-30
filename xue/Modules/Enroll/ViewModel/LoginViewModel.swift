//
//  LoginViewModel.swift
//  xue
//
//  Created by Arron Zhu on 16/11/7.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    var titles: [String] = []
    
    func allLevels(completion: SDArrayResultClosure?) -> SDBaseRequest {
        
        let request = SDGetLevelRequest.init()
        request.startRequest { (succeed, response, error) in
            if succeed {
                let array = LevelModel.mj_objectArray(withKeyValuesArray: response)
                for model in array! {
                    self.titles.append((model as! LevelModel).name! as String)
                }
                if completion != nil {
                    completion!(true, array, nil)
                }
            } else {
                if completion != nil {
                    completion!(false, nil, error)
                }
            }
        }
        return request
    }
    
    func allGrades(completion: SDArrayResultClosure?) -> SDBaseRequest {
        
        let levelId: NSString? = kUserDefaults?.levelId as NSString?
        
        let request = SDGetGradeRequest.init(levelId: levelId!)
        request.startRequest { (succeed, response, error) in
            if succeed {
                
                if completion != nil {
                    completion!(true, response as! NSArray?, nil)
                }
            } else {
                if completion != nil {
                    completion!(false, nil, error)
                }
            }
        }
        return request
    }
}
