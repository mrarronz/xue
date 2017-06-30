//
//  SDRefreshHeader.swift
//  xue
//
//  Created by Arron Zhu on 16/11/10.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import MJRefresh

class SDRefreshHeader: MJRefreshHeader {
    
    private var iconView: UIImageView?
    private var refreshLabel: UILabel?
    private var indicatorView: UIActivityIndicatorView?

    override func prepare() {
        super.prepare()
        
        self.mj_h = 50
        iconView = UIImageView.init(image: #imageLiteral(resourceName: "icon_refresh_logo"))
        iconView?.sizeToFit()
        self.addSubview(iconView!)
        
        refreshLabel = UILabel.init()
        refreshLabel?.font = UIFont.systemFont(ofSize: 13)
        refreshLabel?.textColor = UIColor.sd_darkGray()
        refreshLabel?.textAlignment = .left
        self.addSubview(refreshLabel!)
        
        indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicatorView?.hidesWhenStopped = true
        self.addSubview(indicatorView!)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.refreshLabel?.mj_size = CGSize.init(width: 100, height: 20)
        let totalWidth: CGFloat = (self.refreshLabel?.mj_w)! + (self.iconView?.mj_w)! + 6
        let originx = (self.mj_w - totalWidth)/2
        
        self.iconView?.mj_x = originx
        self.iconView?.mj_y = (self.mj_h - (self.iconView?.mj_h)!)/2
        self.indicatorView?.center = (self.iconView?.center)!
        self.refreshLabel?.mj_x = (self.iconView?.view_right)! + 6
        self.refreshLabel?.mj_y = (self.mj_h - 20)/2
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
                self.refreshLabel?.text = "下拉刷新数据"
                break
            case .pulling:
                indicatorView?.stopAnimating()
                iconView?.isHidden = false
                self.refreshLabel?.text = "松开后刷新"
                break
            case .refreshing:
                indicatorView?.isHidden = false
                indicatorView?.startAnimating()
                iconView?.isHidden = true
                self.refreshLabel?.text = "正在加载中..."
                break
            default:
                break
            }
        }
    }

}
