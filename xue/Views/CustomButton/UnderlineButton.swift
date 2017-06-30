//
//  UnderlineButton.swift
//  xue
//
//  Created by Arron Zhu on 17/3/8.
//  Copyright © 2017年 sundataonline. All rights reserved.
//

import UIKit

@IBDesignable
class UnderlineButton: CommonButton {
    
    @IBInspectable var isUnderline: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    //MARK:- drawRect
    
    override func draw(_ rect: CGRect) {
        
        if isUnderline {
            let textFrame = self.titleLabel?.frame
            let descender = self.titleLabel?.font.descender
            let shadowHeight = self.titleLabel?.shadowOffset.height
            var offset = descender! + shadowHeight!
            offset = (fabs(offset) > 0) ? fabs(offset) : offset + 3;
            
            let context : CGContext = UIGraphicsGetCurrentContext()!
            context.beginPath()
            context.move(to: CGPoint.init(x: (textFrame?.origin.x)!, y: (textFrame?.origin.y)! + (textFrame?.size.height)! + offset))
            context.addLine(to: CGPoint.init(x: (textFrame?.origin.x)! + (textFrame?.size.width)!, y: (textFrame?.origin.y)! + (textFrame?.size.height)! + offset))
            context.setStrokeColor((normalTextColor?.cgColor)!)
            context.setLineWidth(1.0)
            context.strokePath()
            self.backgroundColor = UIColor.clear
        }
    }

}
