//
//  CourseGridCell.swift
//  xue
//
//  Created by Arron Zhu on 16/11/9.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import ReactiveCocoa

let courseCellReuseID = "CourseGridCell"

class CourseGridCell: UICollectionViewCell {
    
    lazy var logoView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.layer.cornerRadius = 4.0
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.font = textFont(12)
        titleLabel.textColor = UIColor.sd_black()
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 9;
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel.init()
        label.font = textFont(10)
        label.textColor = UIColor.sd_lightGray()
        label.textAlignment = .right
        label.sizeToFit()
        return label
    }()
    
    func bottomPadding() -> CGFloat {
        return 3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(logoView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(countLabel)
        
        logoView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(imageHeight())
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoView)
            make.width.equalTo(50)
            make.height.equalTo(18)
            make.bottom.equalTo(self.contentView).offset(-bottomPadding())
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(logoView)
            make.top.equalTo(logoView.snp.bottom).offset(10)
        }
        countLabel.snp.makeConstraints { (make) in
            make.right.equalTo(logoView)
            make.height.equalTo(20)
            make.centerY.equalTo(categoryLabel)
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
    
    class func cell(indexPath: IndexPath, collectionView: UICollectionView) -> CourseGridCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: courseCellReuseID, for: indexPath)
        return cell as! CourseGridCell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        countLabel.text = nil
        titleLabel.text = nil
        super.prepareForReuse()
    }
    
    func refresh(_ model: RecommendCourseModel) {
        self.titleLabel.text = model.title
        
        self.logoView.sd_setImage(with: URL.init(string: model.cover!),
                                  placeholderImage: #imageLiteral(resourceName: "icon_course_placeholder"))
        if Int(model.type!) == 1 {
            self.categoryLabel.text = "录播课"
            self.categoryLabel.layer.backgroundColor = UIColor.sd_tagYellow().cgColor
        } else if Int(model.type!) == 2 {
            self.categoryLabel.text = "微课"
            self.categoryLabel.layer.backgroundColor = UIColor.sd_tagBlue().cgColor
        } else if Int(model.type!) == 4 {
            self.categoryLabel.text = "智慧套餐"
            self.categoryLabel.layer.backgroundColor = UIColor.sd_tagPurple().cgColor
        }
        self.countLabel.text = String.init(format: "%@人已学习", (model.buy_count?.numberString())!)
    }
}
