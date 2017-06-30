//
//  SDFrameExtension.swift
//  xue
//
//  Created by Arron Zhu on 16/10/14.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var view_left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    var view_right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue - self.frame.size.width
            self.frame = rect
        }
    }
    
    var view_top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    var view_bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue - self.frame.size.height
            self.frame = rect
        }
    }
    
    var view_width : CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    var view_height : CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    var view_centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center;
            center.x = newValue
            self.center = center
        }
    }
    
    var view_centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    var view_origin : CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }
    }
    
    var view_size : CGSize {
        get {
            return self.frame.size
        }
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
}
