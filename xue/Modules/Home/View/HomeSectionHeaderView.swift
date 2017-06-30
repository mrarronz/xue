//
//  HomeSectionHeaderView.swift
//  xue
//
//  Created by Arron Zhu on 16/11/9.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

protocol HomeSectionHeaderViewDelegate: class {
    
    func didTapMoreButtonInHeaderView(_ header: HomeSectionHeaderView)
}

let headerReuseID = "HomeSectionHeaderView"

class HomeSectionHeaderView: UITableViewHeaderFooterView {

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
        label.textColor = UIColor.sd_darkGray()
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
        button.addTarget(self, action: #selector(refreshButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    var needRefresh: Bool? {
        didSet {
            if needRefresh! {
                self.subTitleLabel.text = "换一批"
                self.subTitleLabel.sizeToFit()
                self.moreIconView.image = #imageLiteral(resourceName: "icon_home_refresh")
            } else {
                self.subTitleLabel.text = "更多"
                self.subTitleLabel.sizeToFit()
                self.moreIconView.image = #imageLiteral(resourceName: "icon_list_more")
            }
            setNeedsLayout()
        }
    }
    
    weak var delegate: HomeSectionHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(hexString: "#F9F9F9")
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        self.contentView.addSubview(moreIconView)
        self.contentView.addSubview(refreshButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func headerView(tableView: UITableView, section: Int) -> HomeSectionHeaderView {
        var header: HomeSectionHeaderView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseID) as! HomeSectionHeaderView?
        if header == nil {
            header = HomeSectionHeaderView.init(reuseIdentifier: headerReuseID)
        }
        switch section {
        case 0:
            header?.titleLabel.text = "热门推荐"
            header?.iconView.image = #imageLiteral(resourceName: "icon_header_hot")
            header?.needRefresh = true
            break
        case 1:
            header?.titleLabel.text = "最新课程"
            header?.iconView.image = #imageLiteral(resourceName: "icon_header_new")
            header?.needRefresh = false
            break
        case 2:
            header?.titleLabel.text = "精选题库"
            header?.iconView.image = #imageLiteral(resourceName: "icon_header_recommend")
            header?.needRefresh = false
            break
        default:
            break
        }
        return header!
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        self.iconView.view_left = 12
        self.iconView.view_width = 15
        self.iconView.view_height = 16
        self.iconView.view_centerY = self.contentView.view_centerY
        
        self.titleLabel.view_left = self.iconView.view_right + 6
        self.titleLabel.view_width = 150
        self.titleLabel.view_height = 20
        self.titleLabel.view_centerY = self.iconView.view_centerY
        
        self.refreshButton.view_right = self.contentView.view_width
        self.refreshButton.view_top = 0
        self.refreshButton.view_width = 100
        self.refreshButton.view_height = self.contentView.view_height
        
        if needRefresh! {
            self.subTitleLabel.view_right = self.contentView.view_width - 12
            self.subTitleLabel.view_centerY = self.contentView.view_centerY
            
            self.moreIconView.view_size = imageSize()
            self.moreIconView.view_right = self.subTitleLabel.view_left - 4
            self.moreIconView.view_centerY = self.subTitleLabel.view_centerY
            
        } else {
            self.moreIconView.view_size = CGSize.init(width: 12, height: 14)
            self.moreIconView.view_right = self.contentView.view_width - 12
            self.moreIconView.view_centerY = self.contentView.view_centerY
            
            self.subTitleLabel.view_right = self.moreIconView.view_left - 4
            self.subTitleLabel.view_centerY = self.moreIconView.view_centerY
        }
        super.layoutSubviews()
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
    
    func refreshButtonTapped(sender: UIButton) {
        self.delegate?.didTapMoreButtonInHeaderView(self)
    }

}
