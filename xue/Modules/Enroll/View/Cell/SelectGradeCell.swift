//
//  SelectGradeCell.swift
//  xue
//
//  Created by Arron Zhu on 16/11/8.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

let selectGradeCellReuseID = "SelectGradeCell"

class SelectGradeCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.titleLabel.textColor = UIColor.white
                self.contentView.backgroundColor = UIColor.sd_navigation()
            } else {
                self.titleLabel.textColor = UIColor.sd_navigation()
                self.contentView.backgroundColor = UIColor.white
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.titleLabel.textColor = UIColor.white
                self.contentView.backgroundColor = UIColor.sd_navigation()
            } else {
                self.titleLabel.textColor = UIColor.sd_navigation()
                self.contentView.backgroundColor = UIColor.white
            }
        }
    }
    
    var isEnable: Bool = false {
        didSet {
            if isEnable {
                self.titleLabel.textColor = UIColor.sd_navigation()
                self.contentView.backgroundColor = UIColor.white
                self.layer.borderWidth = 1
            } else {
                self.titleLabel.textColor = UIColor.white
                self.contentView.backgroundColor = UIColor.sd_lightGray().withAlphaComponent(0.5)
                self.layer.borderWidth = 0
            }
        }
    }
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIColor.sd_navigation()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = frame.size.height/2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.sd_navigation().cgColor
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func gradeCell(collectionView: UICollectionView, indexPath: IndexPath) -> SelectGradeCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectGradeCellReuseID, for: indexPath)
        return cell as! SelectGradeCell
    }
}
