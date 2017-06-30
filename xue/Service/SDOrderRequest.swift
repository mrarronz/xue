//
//  SDOrderRequest.swift
//  xue
//
//  订单购买
//
//  Created by Arron Zhu on 16/11/4.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation

/**
 *  生成订单
 */
class SDGenerateOrderRequest: SDBaseRequest {
    
    var goodsId: NSString?
    var mmId: NSString?
    var payment: NSString?
    
    init(goodsId: NSString?, mmId: NSString?, payment: NSString?) {
        super.init()
        self.goodsId = goodsId
        self.mmId = mmId
        self.payment = payment
    }
    
    override func requestUrl() -> String {
        return "/api/setOrder"
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if goodsId != nil {
            dict.setObject(goodsId!, forKey: "ids" as NSCopying)
        }
        if payment != nil {
            dict.setObject(payment!, forKey: "payMent" as NSCopying)
        }
        if mmId != nil {
            dict.setObject(mmId!, forKey: "mmid" as NSCopying)
        }
        return dict
    }
}

/**
 * 订单列表
 */
class SDOrderListRequest: SDBaseRequest {
    
    var page: Int?
    
    init(page: Int) {
        super.init()
        self.page = page
    }
    
    override func requestUrl() -> String {
        return "/api/myOrder"
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestParams() -> NSDictionary {
        return ["page" : page!]
    }
}

/**
 * 订单详情
 */
class SDOrderDetailRequest: SDBaseRequest {
    
    var orderId: NSString?
    
    init(orderId: NSString) {
        super.init()
        self.orderId = orderId
    }
    
    override func requestUrl() -> String {
        return "/api/orderDetail"
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestParams() -> NSDictionary {
        return ["id" : orderId!]
    }
}

/**
 * 校验购物车商品是否已购买
 */
class SDValidateOrderRequest: SDBaseRequest {
    
    var ids: NSString?
    
    init(ids: NSString) {
        super.init()
        self.ids = ids
    }
    
    override func requestUrl() -> String {
        return "/api/isGoodsBuy"
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestParams() -> NSDictionary {
        return ["ids" : ids!]
    }
}


/**
 * 课币充值接口
 */
class SDRechargeRequest: SDBaseRequest {
    
    var amount: NSString?
    var payment: NSString?
    
    init(amount: NSString, payment: NSString) {
        super.init()
        self.amount = amount
        self.payment = payment
    }
    
    override func requestUrl() -> String {
        return "/api/reCharge"
    }
    
    override func requestParams() -> NSDictionary {
        return ["amount" : amount!, "payment" : payment!]
    }
}

/**
 * 充值历史记录
 */
class SDRechargeHistoryRequest: SDBaseRequest {
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/reChargeLog"
    }
}

/**
 *  支付完成处理接口
 */
class SDPaymentCompleteRequest: SDBaseRequest {
    
    var amount: NSString?
    var payment: NSString?
    var orderId: NSString?
    var qrcode: NSString?
    
    init(amount: NSString?, payment: NSString?, orderId: NSString?) {
        super.init()
        self.amount = amount
        self.payment = payment
        self.orderId = orderId
    }
    
    init(amount: NSString?, payment: NSString?, orderId: NSString?, qrcode: NSString?) {
        super.init()
        self.amount = amount
        self.payment = payment
        self.orderId = orderId
        self.qrcode = qrcode
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/changeProcess"
    }
    
    override func requestParams() -> NSDictionary {
        let dict = NSMutableDictionary.init()
        if amount != nil {
            dict.setObject(amount!, forKey: "amount" as NSCopying)
        }
        if payment != nil {
            dict.setObject(payment!, forKey: "payment" as NSCopying)
        }
        if orderId != nil {
            dict.setObject(orderId!, forKey: "orderId" as NSCopying)
        }
        if qrcode != nil {
            dict.setObject(qrcode!, forKey: "qrcode" as NSCopying)
        }
        return dict
    }
}


/**
 *  下单时获取可用的优惠券
 */
class SDAvailableCouponRequest: SDBaseRequest {
    
    var ids: NSString?
    
    init(ids: NSString) {
        super.init()
        self.ids = ids
    }
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/ableCoupon"
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
 *  个人中心-我的优惠券
 */
class SDMyCouponRequest: SDBaseRequest {
    
    override func needToken() -> Bool {
        return true
    }
    
    override func requestUrl() -> String {
        return "/api/discount"
    }
}

