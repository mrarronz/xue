//
//  HUDExtension.swift
//  xue
//
//  Created by Arron Zhu on 16/10/18.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation
import UIKit

let kLoadingImageTag : Int = 12345678

extension UIView {
    
    func inputResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        for subView in self.subviews {
            let firstResponder : UIView? = subView.inputResponder()
            if firstResponder != nil {
                return firstResponder
            }
        }
        return nil
    }
    
    func showGifHUD() {
        let imageView = UIImageView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 148, height: 139)))
        imageView.tag = kLoadingImageTag
        self.addSubview(imageView)
        imageView.center = self.center
        
        var animationImages = [UIImage]()
        for i in 1...8 {
            let imageName = String.init(format: "icon_loading%d", i)
            let image = UIImage.init(named: imageName)
            animationImages.append(image!)
        }
        imageView.animationImages = animationImages
        imageView.animationDuration = 0.8
        imageView.animationRepeatCount = Int.max
        imageView.startAnimating()
    }
    
    func hideGifHUD() {
        var imageView: UIImageView? = self.viewWithTag(kLoadingImageTag) as! UIImageView?
        if imageView != nil {
            imageView?.removeFromSuperview()
            imageView = nil
        }
    }
}
