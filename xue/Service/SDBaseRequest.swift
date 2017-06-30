//
//  SDBaseRequest.swift
//  xue
//
//  Created by Arron Zhu on 16/11/1.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import Foundation
import YTKNetwork

typealias SDResponseClosure = (_ succeed:Bool, _ response:Any?, _ error:SDError?) -> Void
typealias SDBooleanResuleClosure = (_ succeed:Bool, _ error:SDError?) -> Void
typealias SDArrayResultClosure = (_ succeed:Bool, _ array:NSArray?, _ error:SDError?) -> Void

class SDBaseRequest: YTKRequest {
    
    // MARK:- override
    
    override func requestMethod() -> YTKRequestMethod {
        return .POST
    }
    
    override func requestSerializerType() -> YTKRequestSerializerType {
        return .JSON
    }
    
    override func requestTimeoutInterval() -> TimeInterval {
        return 15
    }
    
    override func requestArgument() -> Any? {
        return encryptedDict(params: requestParams())
    }
    
    // MARK:- Custom method
    
    func needToken() -> Bool {
        return false
    }
    
    func token() -> String {
        return kAppPreference.token! as String
    }
    
    func requestParams() -> NSDictionary {
        return NSDictionary.init()
    }
    
    func startRequest(completion:SDResponseClosure?) {
        NALog("Start Request: \(NSStringFromClass(self.classForCoder)), Request: \(requestArgument() as Optional)")
        
        self.startWithCompletionBlock(success: { (request) in
            NALog("Response: \(request.responseJSONObject as Optional)")
            
            // 解析数据
            let object = request.responseJSONObject as! [String : AnyObject]
            let status:Int = Int(object["status"] as! String)!
            var errorMsg:String? = object["msg"] as? String
            
            let data:AnyObject? = object["data"]
            if status == 200 {
                let error = SDError.init(domain: SDResponseSuccessDomain, code: status, msg: errorMsg)
                if completion != nil {
                    completion!(true, data, error)
                }
            } else {
                if status == 415 || status == 777 || status == 444 {
                    DispatchQueue.main.async {
                        // 弹出alert
                    }
                    errorMsg = nil
                }
                let error = SDError.init(domain: SDResponseFailureDomain, code: status, msg: errorMsg)
                if completion != nil {
                    completion!(false, data, error)
                }
            }
        })
        { (request) in
            NALog("Response(Error): \(request.error as Optional)")
            let error = SDError.init(error: request.error! as NSError)
            error.domain = SDResponseNoneDomain
            if completion != nil {
                completion!(false, nil, error)
            }
        }
    }
    
    // MARK:- Private
    
    func encryptedString(params: NSDictionary) -> String {
        let str : NSString = (SDAppSecret as NSString).appendingParams(params as! [AnyHashable : Any]) as NSString
        let encrypted = str.md5().uppercased()
        return encrypted
    }
    
    func encryptedDict(params: NSDictionary) -> NSDictionary {
        let dict = NSMutableDictionary.init(dictionary: params as! [AnyHashable : Any])
        dict.setObject(SDAppKey, forKey: "appId" as NSCopying)
        dict.setObject("json", forKey: "messageFormat" as NSCopying)
        dict.setObject("1.0", forKey: "v" as NSCopying)
        if needToken() {
            dict.setObject(token(), forKey: "token" as NSCopying)
        }
        let signStr = encryptedString(params: dict)
        dict.setObject(signStr, forKey: "sign" as NSCopying)
        return dict
    }
}
