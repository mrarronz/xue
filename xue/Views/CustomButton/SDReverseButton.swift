//
//  SDReverseButton.swift
//  xue
//
//  Created by Arron Zhu on 16/10/17.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDReverseButton: CommonButton {
    
    convenience init() {
        self.init()
        labelFont = UIFont.systemFont(ofSize: 13)
        normalTextColor = UIColor.sd_darkGray()
    }

    var xMargin: CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var rightPadding: CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var isAlignInCenter: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let imageSize = self.normalImage?.size
        let labelSize = self.btnTextSize()
        
        let totalWidth = (imageSize?.width)! + labelSize.width + xMargin! + rightPadding!
        var originX = self.view_width - totalWidth
        
        if isAlignInCenter {
            originX = (self.view_width - (imageSize?.width)! - labelSize.width - xMargin!)/2
        }
        self.titleLabel?.view_left = originX
        self.titleLabel?.view_width = labelSize.width
        self.titleLabel?.view_height = 20
        self.titleLabel?.view_centerY = self.sd_height / 2
        
        self.imageView?.view_left = (self.titleLabel?.view_right)! + xMargin!
        self.imageView?.view_size = imageSize!;
        self.imageView?.view_centerY = (self.titleLabel?.view_centerY)!
        
        super.layoutSubviews()
    }

}
