//
//  SDItemButton.swift
//  xue
//
//  Created by Arron Zhu on 16/10/17.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDItemButton: CommonButton {
    
    var labelMargin: CGFloat = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var imageSize: CGSize = CGSize.zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelFont = UIFont.systemFont(ofSize: 13)
        normalTextColor = UIColor.sd_black()
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var imageSize = self.normalImage?.size
        if self.imageSize != CGSize.zero {
            imageSize = self.imageSize
        }
        let totalHeight = (imageSize?.height)! + self.labelMargin + 20
        let originY = (self.view_height - totalHeight)/2
        self.imageView?.view_top = originY
        self.imageView?.view_size = imageSize!
        self.imageView?.view_left = (self.view_width - (self.imageView?.view_width)!)/2
        
        self.titleLabel?.view_top = (self.imageView?.view_bottom)! + self.labelMargin
        self.titleLabel?.view_left = 0
        self.titleLabel?.view_width = self.view_width
        self.titleLabel?.view_height = 20
    }
    
    class func button(title: String, image: UIImage) -> SDItemButton {
        let button = SDItemButton.init()
        button.normalTitle = title
        button.normalImage = image
        return button
    }
}
