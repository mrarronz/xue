//
//  SDTikuListCell.swift
//  xue
//
//  Created by Arron Zhu on 16/10/15.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

let tikuCellReuseID = "SDTikuListCell"

class SDTikuListCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.sd_black()
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.sd_darkGray()
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.sd_price()
        return label
    }()
    
    lazy var originalPriceLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.sd_darkGray()
        return label
    }()
    
    lazy var categoryButton:CommonButton = {
        let button = CommonButton.init()
        button.backgroundColor = UIColor.init(hexString: "FFB400")
        button.labelFont = UIFont.systemFont(ofSize: 12)
        button.normalTextColor = UIColor.white
        button.btnRadius = 2.0
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var joinButton:CommonButton = {
        let button = CommonButton.init()
        button.normalTitle = "加入学习"
        button.normalTextColor = UIColor.white
        button.labelFont = UIFont.systemFont(ofSize: 13)
        button.normalBkgImage = #imageLiteral(resourceName: "btn_get_code")
        button.btnRadius = 2.0
        return button
    }()
    
    lazy var personImageView:UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = #imageLiteral(resourceName: "icon_home_people")
        return imageView
    }()
    
    lazy var separatorView: UIView = {
        let separator = UIView.init()
        separator.backgroundColor = UIColor.sd_background()
        return separator
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(categoryButton)
        self.contentView.addSubview(personImageView)
        self.contentView.addSubview(countLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(originalPriceLabel)
        self.contentView.addSubview(joinButton)
        self.contentView.addSubview(separatorView)
        
        joinButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-8);
            make.height.equalTo(32);
            make.width.equalTo(84);
            make.centerY.equalTo(self.contentView);
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12);
            make.height.equalTo(20);
            make.right.equalTo(self.joinButton.snp.left).offset(-10);
            make.top.equalTo(10);
        }
        categoryButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel);
            make.height.equalTo(15);
            make.width.equalTo(40);
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5);
        }
        personImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.categoryButton.snp.right).offset(20);
            make.centerY.equalTo(self.categoryButton);
            make.width.equalTo(12);
            make.height.equalTo(11);
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.personImageView.snp.right).offset(2);
            make.height.equalTo(20);
            make.centerY.equalTo(self.personImageView);
            make.right.equalTo(self.titleLabel);
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel);
            make.height.equalTo(20);
            make.width.equalTo(100);
            make.top.equalTo(self.categoryButton.snp.bottom).offset(5);
        }
        originalPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.priceLabel.snp.right).offset(20);
            make.height.equalTo(20);
            make.width.equalTo(60);
            make.centerY.equalTo(self.priceLabel.snp.centerY).offset(2);
        }
        separatorView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func tikuCell(tableView: UITableView) -> SDTikuListCell {
        var tikuCell: SDTikuListCell? = tableView.dequeueReusableCell(withIdentifier: tikuCellReuseID) as! SDTikuListCell?
        if tikuCell == nil {
            tikuCell = SDTikuListCell.init(style: .default, reuseIdentifier: tikuCellReuseID)
        }
        return tikuCell!
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        countLabel.text = nil
        originalPriceLabel.attributedText = nil
        super.prepareForReuse()
    }
    
    func refresh(model: HomeTikuModel) {
        self.titleLabel.text = model.paper_title
        self.categoryButton.normalTitle = Int(model.type!)! == 1 ? "试卷" : "真题"
        
        self.countLabel.text = String.init(format: "%@人已学习", (model.buy_count?.numberString())!)
     
        self.priceLabel.text = String.init(format: "优惠价%@课币", (model.price?.numberString())!)
   
        let priceText = String.init(format: "原价%@课币", (model.original_price?.numberString())!)
        
        let dict:Dictionary<String, Int> = [NSStrikethroughStyleAttributeName : NSUnderlineStyle.styleThick.rawValue]
        
        self.originalPriceLabel.attributedText = NSMutableAttributedString.init(string: priceText, attributes: dict)
    }
    
}
