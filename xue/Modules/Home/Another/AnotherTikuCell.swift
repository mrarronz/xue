//
//  AnotherTikuCell.swift
//  xue
//
//  Created by Arron Zhu on 16/11/11.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

let tikuCellIdentifier = "AnotherTikuCell"

class AnotherTikuCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.sd_black()
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel.init()
        label.font = textFont(10)
        label.textColor = UIColor.sd_lightGray()
        return label
    }()
    
    lazy var originalPriceLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.sd_lightGray()
        return label
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 9;
        label.layer.backgroundColor = UIColor.sd_tagPink().cgColor
        return label
    }()
    
    lazy var joinButton:CommonButton = {
        let button = CommonButton.init()
        button.normalTextColor = UIColor.sd_price()
        button.highlightedTextColor = UIColor.white
        button.highlightedBkgImage = UIColor.sd_price().colorToImage()
        button.labelFont = UIFont.systemFont(ofSize: 13)
        button.btnRadius = 4.0
        button.borderColor = UIColor.sd_price()
        button.borderWidth = 1.0;
        return button
    }()

    lazy var separatorView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.sd_background()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(countLabel)
        self.contentView.addSubview(originalPriceLabel)
        self.contentView.addSubview(joinButton)
        self.contentView.addSubview(separatorView)
        
        joinButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(70)
            make.centerY.equalTo(self.contentView)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.height.equalTo(20)
            make.right.equalTo(self.joinButton.snp.left).offset(-10)
            make.top.equalTo(10)
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.height.equalTo(18)
            make.width.equalTo(50)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.height.equalTo(20)
            make.right.equalTo(self.titleLabel)
            make.top.equalTo(self.categoryLabel.snp.bottom).offset(5)
        }
        originalPriceLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.joinButton)
            make.height.equalTo(20)
            make.centerY.equalTo(self.countLabel)
        }
        separatorView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(0.5)
        }
        categoryLabel.reactive.values(forKeyPath: "text").startWithValues { (text) in
            let tempValue: String? = text as? String
            if tempValue?.isEmpty == false {
                let tmpSize = tempValue?.size(attributes: [NSFontAttributeName: self.categoryLabel.font])
                self.categoryLabel.snp.updateConstraints({ (make) in
                    make.width.equalTo((tmpSize?.width)! + 20)
                })
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        countLabel.text = nil
        originalPriceLabel.attributedText = nil
        super.prepareForReuse()
    }
    
    class func tikuCell(collectionView: UICollectionView, indexPath: IndexPath) -> AnotherTikuCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tikuCellIdentifier, for: indexPath)
        return cell as! AnotherTikuCell
    }
    
    func refresh(model: HomeTikuModel) {
        self.titleLabel.text = model.paper_title
        self.joinButton.normalTitle = String.init(format: "%@课币", (model.price?.numberString())!)
        self.categoryLabel.text = Int(model.type!)! == 1 ? "试卷" : "真题"
        
        self.countLabel.text = String.init(format: "%@人已学习", (model.buy_count?.numberString())!)
        
        let priceText = String.init(format: "%@课币", (model.original_price?.numberString())!)
        let dict: Dictionary<String, Int> = [NSStrikethroughStyleAttributeName : NSUnderlineStyle.styleThick.rawValue]
        self.originalPriceLabel.attributedText = NSMutableAttributedString.init(string: priceText, attributes: dict)
    }
    
}
