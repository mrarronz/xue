//
//  AnotherSectionHeaderView.swift
//  xue
//
//  Created by Arron Zhu on 16/11/11.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

let sectionHeaderReuseID = "AnotherSectionHeaderView"

class AnotherSectionHeaderView: UICollectionReusableView {
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.sd_black()
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.sd_lightGray()
        label.text = "更多"
        label.sizeToFit()
        return label
    }()
    
    lazy var moreIconView: UIImageView = {
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "icon_list_more"))
        return imageView
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: "#F9F9F9")
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(moreIconView)
        self.addSubview(refreshButton)
        
        setupConstraints(needRefresh: false)
    }
    
    init(frame: CGRect, needRefresh: Bool) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(moreIconView)
        self.addSubview(refreshButton)
        
        setupConstraints(needRefresh: true)
    }
    
    func setupConstraints(needRefresh: Bool) {
        self.iconView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.width.equalTo(15)
            make.height.equalTo(16)
            make.centerY.equalTo(self)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconView.snp.right).offset(6)
            make.width.equalTo(150)
            make.height.equalTo(20)
            make.centerY.equalTo(self)
        }
        self.refreshButton.snp.makeConstraints { (make) in
            make.top.right.height.equalTo(self)
            make.width.equalTo(100)
        }
//        if needRefresh {
//            self.subTitleLabel.textAlignment = .left
//            self.subTitleLabel.snp.makeConstraints({ (make) in
//                make.right.equalTo(self).offset(-12)
//                make.height.equalTo(20)
//                make.centerY.equalTo(self)
//            })
//            self.moreIconView.snp.makeConstraints({ (make) in
//                make.width.height.equalTo(13)
//                make.centerY.equalTo(self)
//                make.right.equalTo(self.subTitleLabel.snp.left).offset(-4)
//            })
//        } else {
            self.subTitleLabel.textAlignment = .right
            self.moreIconView.snp.makeConstraints({ (make) in
                make.width.height.equalTo(13)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(-12)
            })
            self.subTitleLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(self.moreIconView.snp.left).offset(-4)
                make.height.equalTo(20)
                make.centerY.equalTo(self)
            })
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
        super.prepareForReuse()
    }
    
    class func sectionHeader(collectionView: UICollectionView, indexPath: IndexPath) -> AnotherSectionHeaderView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseID, for: indexPath)
        return cell as! AnotherSectionHeaderView
    }
    
    func imageSize() -> CGSize {
        let image = #imageLiteral(resourceName: "icon_home_refresh")
        return image.size
    }
    
    func startAnimating() {
        let anim = CABasicAnimation.init(keyPath: "transform.rotation.z")
        anim.toValue = NSNumber.init(value: Double.pi * 2.0)
        anim.duration = 1.0
        anim.isCumulative = true
        anim.repeatCount = Float(Int.max)
        self.moreIconView.layer.add(anim, forKey: "rotationAnimation")
    }
    
    func stopAnimating() {
        let anim = self.moreIconView.layer.animation(forKey: "rotationAnimation")
        if anim != nil {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self.moreIconView.layer.removeAnimation(forKey: "rotationAnimation")
            })
        }
    }
}
