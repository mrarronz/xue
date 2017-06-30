//
//  SDRefreshFooter.swift
//  xue
//
//  Created by Arron Zhu on 16/11/10.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import MJRefresh

class SDRefreshFooter: MJRefreshAutoFooter {

    var noMoreText: String = "木有数据了"
    private var iconView: UIImageView?
    private var refreshLabel: UILabel?
    private var indicatorView: UIActivityIndicatorView?
    
    override func prepare() {
        super.prepare()
        
        self.mj_h = 44
        iconView = UIImageView.init(image: #imageLiteral(resourceName: "icon_refresh_pullup"))
        iconView?.sizeToFit()
        self.addSubview(iconView!)
        
        refreshLabel = UILabel.init()
        refreshLabel?.font = UIFont.systemFont(ofSize: 13)
        refreshLabel?.textColor = UIColor.sd_darkGray()
        refreshLabel?.textAlignment = .center
        self.addSubview(refreshLabel!)
        
        indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicatorView?.hidesWhenStopped = true
        self.addSubview(indicatorView!)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        self.refreshLabel?.frame = self.bounds
        self.iconView?.center = CGPoint.init(x: self.mj_w * 0.5 - 60, y: self.mj_h * 0.5)
        self.indicatorView?.center = (self.iconView?.center)!
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                indicatorView?.stopAnimating()
                iconView?.isHidden = false
                refreshLabel?.text = "上拉加载更多"
                break
            case .refreshing:
                indicatorView?.isHidden = false
                indicatorView?.startAnimating()
                iconView?.isHidden = true
                refreshLabel?.text = "正在加载中..."
                break
            case .noMoreData:
                indicatorView?.stopAnimating()
                iconView?.isHidden = false
                refreshLabel?.text = self.noMoreText
                break
            default:
                break
            }
        }
    }

}
