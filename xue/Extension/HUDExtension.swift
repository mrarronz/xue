//
//  HUDExtension.swift
//  xue
//
//  Created by Arron Zhu on 16/10/18.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension MBProgressHUD {
    
    class func show(text:String, iconName:String, view:UIView?) {
        var theView = view
        if theView == nil {
            theView = UIApplication.shared.keyWindow!
        }
        let hud = MBProgressHUD.showAdded(to: theView!, animated: true)
        hud.label.text = text
        hud.customView = UIImageView.init(image: UIImage.init(named: NSString.init(format: "MBProgressHUD.bundle/%@", iconName) as String))
        hud.mode = .customView
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.0)
    }
    
    class func show(text:String, detail:String, iconName:String, view:UIView?) {
        var theView = view
        if theView == nil {
            theView = UIApplication.shared.keyWindow!
        }
        let hud = MBProgressHUD.showAdded(to: theView!, animated: true)
        hud.label.text = text
        hud.detailsLabel.text = detail
        hud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        hud.customView = UIImageView.init(image: UIImage.init(named: NSString.init(format: "MBProgressHUD.bundle/%@", iconName) as String))
        hud.mode = .customView
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    class func showToast(msg:String, view:UIView?) {
        var theView = view
        if theView == nil {
            theView = UIApplication.shared.keyWindow!
        }
        let hud = MBProgressHUD.showAdded(to: theView!, animated: true)
        hud.mode = .text
        hud.label.text = msg
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    class func showError(msg:String, view:UIView) {
        show(text: msg, iconName: "error.png", view: view)
    }
    
    class func showSuccess(msg:String, view:UIView) {
        show(text: msg, iconName: "success.png", view: view)
    }
    
    class func showSuccess(msg:String, description:String, view:UIView) {
        show(text: msg, detail: description, iconName: "success.png", view: view)
    }
}

let kLoadingImageTag : Int = 12345678

extension UIView {
    
    func showHUD() {
        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func showHUD(_ text: String) {
        MBProgressHUD.showAdded(to: self, animated: true).label.text = text
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func toast(_ text: String?) {
        if (text?.isEmpty)! {
            return
        }
        MBProgressHUD.showToast(msg: text!, view: self)
    }
    
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
