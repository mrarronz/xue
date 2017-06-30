//
//  SDError.swift
//  xue
//
//  Created by Arron Zhu on 16/11/1.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import Foundation

/// 服务器无返回数据，接口请求失败
let SDResponseNoneDomain = "SDServerResponseNoneError"

/// 服务器有返回数据，请求成功且数据正常status==200
let SDResponseSuccessDomain = "SDServerResponseSuccess"

/// 服务器有返回数据，请求成功但数据有误，这里对应于一切status!=200的情况
let SDResponseFailureDomain = "SDServerResponseFailure"


let SDCommonRequestError = "请求失败，请稍后再试"

let SDNetworkUnavailableError = "网络不可用，请检查网络设置"

let SDServerConnectionError = "未能连接到服务器，请检查网络后再试"

let SDRequestTimeoutError = "请求超时，请稍后再试"

let SDServerNotFoundError = "未能连接到服务器，请稍后再试"

let SDServerInternalError = "服务器出错，请稍后再试"

let SDServerNoResponseError = "服务器无响应，请稍后再试"

class SDError: NSObject {
    var domain : String?
    var errorMsg: String?
    var errorCode: Int?
    
    init(domain: String?, code: Int, msg: String?) {
        super.init()
        self.domain = domain
        self.errorCode = code
        self.errorMsg = msg
        
        convertMsg(code: code)
    }
    
    init(error: NSError) {
        super.init()
        self.domain = error.domain
        self.errorMsg = error.localizedDescription
        self.errorCode = error.code
        convertMsg(code: error.code)
    }
    
    func convertMsg(code: Int) {
        
        if code == -1000 || code == -1003 || code == -1005 || code == -1009 {
            self.errorMsg = SDNetworkUnavailableError
        }
        else if code == -1001 {
            self.errorMsg = SDRequestTimeoutError
        }
        else if code == -1004 || code == -1011 {
            self.errorMsg = SDServerConnectionError
        }
        if self.errorMsg == nil {
            return
        }
        // 去掉句号
        if (self.errorMsg?.contains("。"))! {
            self.errorMsg = self.errorMsg?.replacingOccurrences(of: "。", with: "")
        }
    }
}
