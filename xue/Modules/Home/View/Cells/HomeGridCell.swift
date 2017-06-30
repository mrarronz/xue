//
//  HomeGridCell.swift
//  xue
//
//  Created by Arron Zhu on 16/11/9.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

let homeGridCellReuseID = "HomeGridCell"

protocol HomeGridCellDelegate: class {
    
    func gridCell(_ cell: HomeGridCell, didSelectItemWith model: RecommendCourseModel)
}

class HomeGridCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var courseList = NSArray.init()
    weak var delegate: HomeGridCellDelegate?
    
    lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = sectionInsets()
        flowLayout.minimumLineSpacing = lineSpacing()
        flowLayout.minimumInteritemSpacing = itemSpacing()
        flowLayout.itemSize = CGSize.init(width: itemWidth(), height: itemHeight())
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(CourseGridCell.classForCoder(), forCellWithReuseIdentifier: courseCellReuseID)
        return collectionView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func homeGridCell(tableView: UITableView) -> HomeGridCell {
        let cell: HomeGridCell? = tableView.dequeueReusableCell(withIdentifier: homeGridCellReuseID) as! HomeGridCell?
        return cell!
    }
    
    func refresh(items: NSArray) {
        courseList = items
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource & Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CourseGridCell.cell(indexPath: indexPath, collectionView: collectionView)
        let model: RecommendCourseModel = courseList.object(at: indexPath.row) as! RecommendCourseModel
        cell.refresh(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let model: RecommendCourseModel = courseList.object(at: indexPath.item) as! RecommendCourseModel
        self.delegate?.gridCell(self, didSelectItemWith: model)
    }

}
