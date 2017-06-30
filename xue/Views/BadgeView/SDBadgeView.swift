//
//  SDBadgeView.swift
//  xue
//
//  Created by Arron Zhu on 16/10/17.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDBadgeView: UIView {
    
    let badgeLabel = UILabel.init()
    
    var badgeBkgColor:UIColor?
    var badgeTextFont:UIFont?
    var badgeTextColor:UIColor?
    var badgeTopPadding:CGFloat?
    var badgeLeftPadding:CGFloat?
    

    var badgeValue:String? {
        didSet {
            if Int(badgeValue!)! > 9 {
                badgeLeftPadding = 4
            } else {
                badgeLeftPadding = 2
            }
            badgeTopPadding = 2
            self.frame = badgeFrame(badgeValue: badgeValue!)
            self.layer.cornerRadius = self.sd_height/2
            self.layer.masksToBounds = true
            if self.badgeBkgColor != nil {
                self.backgroundColor = self.badgeBkgColor
            }
            self.badgeLabel.font = self.badgeTextFont
            self.badgeLabel.text = badgeValue
            self.badgeLabel.sizeToFit()
            self.badgeLabel.center = CGPoint.init(x: self.sd_width/2, y: self.sd_height/2)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = UIColor.red
        self.badgeTextColor = UIColor.white
        self.badgeTextFont = UIFont.boldSystemFont(ofSize: 12)
        
        badgeLabel.backgroundColor = UIColor.clear
        badgeLabel.textColor = self.badgeTextColor
        badgeLabel.font = self.badgeTextFont
        badgeLabel.textAlignment = .center
        self.addSubview(badgeLabel)
    }
    
    func badgeSize(badgeValue:String) -> CGSize {
        if badgeValue.isEmpty {
            return CGSize.zero
        }
        var size = badgeValue.size(attributes: [NSFontAttributeName: self.badgeTextFont!])
        if size.width < size.height {
            size = CGSize.init(width: size.height, height: size.height)
        }
        return size
    }
    
    func badgeFrame(badgeValue:String) -> CGRect {
        let badgeSize = self.badgeSize(badgeValue: badgeValue)
        let badgeFrame = CGRect.init(x: self.frame.origin.x,
                                     y: self.frame.origin.y,
                                     width: badgeSize.width + self.badgeLeftPadding! * 2,
                                     height: badgeSize.height + self.badgeTopPadding! * 2)
        return badgeFrame
    }
    
    open class func viewWithBadge(badgeValue:String) -> SDBadgeView {
        
        var badge = badgeValue
        if badge.isEmpty {
            badge = ""
        }
        let badgeView = SDBadgeView.init()
        badgeView.frame = badgeView.badgeFrame(badgeValue: badge)
        badgeView.badgeValue = badgeValue
        return badgeView
    }

}
