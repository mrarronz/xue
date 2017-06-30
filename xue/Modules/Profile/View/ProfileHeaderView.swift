//
//  ProfileHeaderView.swift
//  xue
//
//  Created by Arron Zhu on 17/3/8.
//  Copyright © 2017年 sundataonline. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    lazy var photoButton: CommonButton = {
        let button = CommonButton.init();
        button.btnRadius = 40
        button.normalBkgImage = #imageLiteral(resourceName: "icon_user_avatar")
        return button
    }()
    
    lazy var nickNameLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Hello111"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        let effectView = UIVisualEffectView.init(effect: effect)
        return effectView
    }()
    
    lazy var bkgImageView: UIImageView = {
        let bkgImageView = UIImageView.init()
        bkgImageView.image = #imageLiteral(resourceName: "icon_user_avatar")
        return bkgImageView
    }()
    
    lazy var alphaView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bkgImageView)
        self.addSubview(effectView)
        self.addSubview(alphaView)
        
        self.addSubview(photoButton)
        self.addSubview(nickNameLabel)
        
        self.bkgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        self.effectView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        self.alphaView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.nickNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(20)
            make.bottom.equalTo(self).offset(-20)
        }
        self.photoButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.nickNameLabel.snp.top).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
