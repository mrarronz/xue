//
//  SDUserOptionCell.swift
//  xue
//
//  Created by Arron Zhu on 16/10/14.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDUserOptionCell: UITableViewCell {
    
    lazy var iconView: UIImageView = {
        
        var iconView = UIImageView.init()
        iconView.contentMode = .scaleAspectFill
        return iconView
    }()
    
    lazy var indicatorImageView: UIImageView = {
        
        var imageView = UIImageView.init()
        imageView.image = #imageLiteral(resourceName: "icon_list_enter")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        
        var label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.sd_darkGray()
        return label
    }()
    
    lazy var dotView: UIView = {
        
        var dotView = UIView.init()
        dotView.backgroundColor = UIColor.init(hexString: "#ef0303")
        return dotView
    }()
    
    lazy var detailLabel: UILabel = {
        
        var detailLabel = UILabel.init()
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = UIColor.sd_lightGray()
        return detailLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(indicatorImageView)
        self.contentView.addSubview(dotView)
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(20);
            make.width.height.equalTo(18);
            make.centerY.equalTo(self.contentView);
        }
        indicatorImageView.snp.makeConstraints { (make) in
            make.width.equalTo(9);
            make.height.equalTo(16);
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(49);
            make.height.equalTo(20);
            make.width.equalTo(120);
            make.centerY.equalTo(self.contentView);
        }
        dotView.snp.makeConstraints { (make) in
            make.width.height.equalTo(8);
            make.left.equalTo(iconView.snp.right).offset(-3);
            make.top.equalTo(iconView.snp.top).offset(-4);
        }
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- set values
    func setTitle(title:String) {
        titleLabel.text = title
    }
    
    func setIcon(icon:UIImage) {
        iconView.image = icon
    }
    
    func showNotificationDot(show:Bool) {
        dotView.isHidden = !show
    }
    
    func showDetailInfo(show:Bool) {
        detailLabel.isHidden = !show
    }
}
