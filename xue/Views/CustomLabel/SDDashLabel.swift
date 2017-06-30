//
//  SDDashLabel.swift
//  xue
//
//  Created by Arron Zhu on 16/10/17.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDDashLabel: UIView {
    
    lazy var textLabel: UILabel = {
        
        let label = UILabel.init()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    var font : UIFont? {
        didSet {
            self.textLabel.font = font
        }
    }
    
    var xPadding : CGFloat? {
        didSet {
            self.resizeView()
        }
    }
    
    var textColor: UIColor? {
        didSet {
            self.textLabel.textColor = textColor
            setNeedsDisplay()
        }
    }
    
    var labelText: String? {
        didSet {
            self.textLabel.text = labelText
            setNeedsDisplay()
        }
    }
    
    var alignment: NSTextAlignment? {
        didSet {
            self.textLabel.textAlignment = alignment!
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
        self.backgroundColor = UIColor.clear
        self.addSubview(self.textLabel)
        self.xPadding = 5
        self.font = UIFont.systemFont(ofSize: 13)
        self.textColor = UIColor.lightGray
        self.textLabel.textColor = self.textColor
    }
    
    func resizeView() {
        self.sd_width = textSize().width + xPadding!*2
        self.sd_height = textSize().height
    }
    
    override func layoutSubviews() {
        self.textLabel.frame = self.bounds
        super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        if self.labelText != nil {
            let context = UIGraphicsGetCurrentContext()
            context?.beginPath()
            context?.move(to: CGPoint.init(x: 0, y: rect.size.height/2))
            context?.addLine(to: CGPoint.init(x: rect.size.width, y: rect.size.height/2))
            context?.setStrokeColor((self.textColor?.cgColor)!)
            context?.setLineWidth(1.0)
            context?.strokePath()
        }
    }
    
    func textSize() -> CGSize {
        if self.textLabel.text == nil {
            return CGSize.zero
        }
        return self.textLabel.text!.size(attributes: [NSFontAttributeName : self.font!])
    }
}
