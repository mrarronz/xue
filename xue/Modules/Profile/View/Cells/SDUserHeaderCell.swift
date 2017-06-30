//
//  SDUserHeaderCell.swift
//  xue
//
//  Created by Arron Zhu on 16/10/14.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDUserHeaderCell: UITableViewCell {
    
    lazy var photoView: UIImageView = {
        
        var photoView = UIImageView.init()
        photoView.image = #imageLiteral(resourceName: "icon_user_avatar")
        return photoView
    }()
    
    lazy var titleLabel: UILabel = {
        
        var label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.sd_darkGray()
        return label
    }()
    
    lazy var indicatorImageView: UIImageView = {
        
        var imageView = UIImageView.init()
        imageView.image = #imageLiteral(resourceName: "icon_list_enter")
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(photoView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(indicatorImageView)
        
        photoView.snp.makeConstraints { (make) in
            make.left.equalTo(12);
            make.width.height.equalTo(65);
            make.centerY.equalTo(self.contentView);
        }
        indicatorImageView.snp.makeConstraints { (make) in
            make.width.equalTo(9);
            make.height.equalTo(16);
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(photoView.snp.right).offset(18)
            make.right.equalTo(indicatorImageView.snp.left).offset(-14)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func refreshView() {
        titleLabel.text = "登录/注册"
    }

}


