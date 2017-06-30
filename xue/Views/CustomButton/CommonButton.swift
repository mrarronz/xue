//
//  CommonButton.swift
//  xue
//
//  Created by Arron Zhu on 16/10/17.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit


@IBDesignable
class CommonButton: UIButton {

    // MARK:- button title color
    @IBInspectable var normalTextColor: UIColor? {
        didSet {
            self.setTitleColor(normalTextColor, for: .normal)
        }
    }
    
    @IBInspectable var highlightedTextColor: UIColor? {
        didSet {
            self.setTitleColor(highlightedTextColor, for: .highlighted)
        }
    }
    
    @IBInspectable var disabledTextColor: UIColor? {
        didSet {
            self.setTitleColor(disabledTextColor, for: .disabled)
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor? {
        didSet {
            self.setTitleColor(selectedTextColor, for: .selected)
        }
    }
    
    // MARK:- border style
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    // MARK:- button title
    @IBInspectable var normalTitle: String? {
        didSet {
            self.setTitle(normalTitle, for: .normal)
        }
    }
    
    @IBInspectable var highlightedTitle: String? {
        didSet {
            self.setTitle(highlightedTitle, for: .highlighted)
        }
    }
    
    @IBInspectable var disabledTitle: String? {
        didSet {
            self.setTitle(disabledTitle, for: .disabled)
        }
    }
    
    @IBInspectable var selectedTitle: String? {
        didSet {
            self.setTitle(selectedTitle, for: .selected)
        }
    }
    
    var labelFont: UIFont {
        get {
            return (self.titleLabel?.font)!
        }
        set {
            self.titleLabel?.font = newValue
        }
    }
    
    @IBInspectable var btnRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = btnRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var hightlightWithBkgColor : Bool = false {
        didSet {
            if hightlightWithBkgColor {
                let touchColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
                self.normalBkgImage = self.backgroundColor?.colorToImage()
                self.highlightedBkgImage = touchColor.colorToImage()
            }
        }
    }
    
    // MARK:- button image
    @IBInspectable var normalImage: UIImage? {
        didSet {
            self.setImage(normalImage, for: .normal)
        }
    }
    
    @IBInspectable var highlightedImage: UIImage? {
        didSet {
            self.setImage(highlightedImage, for: .highlighted)
        }
    }
    
    @IBInspectable var disabledImage: UIImage? {
        didSet {
            self.setImage(disabledImage, for: .disabled)
        }
    }
    
    @IBInspectable var selectedImage: UIImage? {
        didSet {
            self.setImage(selectedImage, for: .selected)
        }
    }
    
    // MARK:- button background image
    @IBInspectable var normalBkgImage: UIImage? {
        didSet {
            self.setBackgroundImage(normalBkgImage, for: .normal)
        }
    }
    
    @IBInspectable var highlightedBkgImage: UIImage? {
        didSet {
            self.setBackgroundImage(highlightedBkgImage, for: .highlighted)
        }
    }
    
    @IBInspectable var disabledBkgImage: UIImage? {
        didSet {
            self.setBackgroundImage(disabledBkgImage, for: .disabled)
        }
    }
    
    @IBInspectable var selectedBkgImage: UIImage? {
        didSet {
            self.setBackgroundImage(selectedBkgImage, for: .selected)
        }
    }
}

extension UIButton {
    
    func countDown(_ timeInterval:TimeInterval) {
        
        var timeout = timeInterval
        
        let queue = DispatchQueue.global()
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.scheduleRepeating(deadline: .now(), interval: .seconds(1), leeway: .microseconds(0))
        timer.setEventHandler { 
            if timeout <= 0 {
                timer.cancel()
                DispatchQueue.main.async {
                    self.isEnabled = true
                }
            } else {
                timeout -= 1
                DispatchQueue.main.async {
                    self.isEnabled = false
                    self.setTitle(String.init(format: "%dS后重新获取", Int(timeout)), for: .disabled)
                }
            }
        }
        timer.resume()
    }
    
    func btnTextSize() -> CGSize {
        return (self.titleLabel?.text?.size(attributes: [NSFontAttributeName : self.titleLabel?.font! as Any]))!
    }
}
