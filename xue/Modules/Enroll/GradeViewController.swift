//
//  GradeViewController.swift
//  xue
//
//  Created by Arron Zhu on 16/11/8.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import SVProgressHUD

class GradeViewController: SDBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var items: NSArray = NSArray.init()
    var isDataLoaded: Bool = false
    var pageIndex:Int?
    
    weak var parentVC: SDSelectGradeViewController?
    weak var loginVM: LoginViewModel?
    
    var collectionView: UICollectionView?
    var indicatorView: UIActivityIndicatorView?

    // MARK: - Init views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupIndicatorView()
        self.view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: 87, height: 44)
        let hPadding = (UI_SCREEN_WIDTH - flowLayout.itemSize.width*3)/4
        flowLayout.minimumLineSpacing = 30
        flowLayout.minimumInteritemSpacing = hPadding/2
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsetsMake(36, hPadding, 36, hPadding)
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.delaysContentTouches = false
        collectionView?.register(SelectGradeCell.classForCoder(), forCellWithReuseIdentifier: selectGradeCellReuseID)
        self.view.addSubview(collectionView!)
    }
    
    func setupIndicatorView() {
        indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        self.view.addSubview(indicatorView!)
        indicatorView?.isHidden = true
        indicatorView?.hidesWhenStopped = true
    }
    
    override func updateViewConstraints() {
        
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        indicatorView?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.view)
            make.size.equalTo((indicatorView?.bounds.size)!)
        })
        super.updateViewConstraints()
    }
    
    // MARK: - Load data
    func loadGradeData(index: Int) {
        
        pageIndex = index
        
        if !isDataLoaded {
            startAnimating()
            _ = self.loginVM?.allGrades(completion: { (succeed, array, error) in
                self.stopAnimating()
                if succeed {
                    self.isDataLoaded = true
                    self.items = array! as NSArray
                    self.collectionView?.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: error?.errorMsg)
                }
            })
        } else {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - show & hide IndicatorView
    
    func startAnimating() {
        indicatorView?.isHidden = false
        indicatorView?.startAnimating()
    }
    
    func stopAnimating() {
        indicatorView?.stopAnimating()
    }
    
    // MARK: - UICollectionViewDataSource & Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SelectGradeCell.gradeCell(collectionView: collectionView, indexPath: indexPath)
        let dict: NSDictionary = items.object(at: indexPath.row) as! NSDictionary
        cell.titleLabel.text = dict.object(forKey: "name") as! String?
        let gradeId: String = dict.object(forKey: "id") as! String
        cell.isSelected = (gradeId == kUserDefaults?.gradeId)
        cell.isEnable = (pageIndex != 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return (pageIndex != 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        if pageIndex == 0 {
            return
        }
        let dict: NSDictionary = items.object(at: indexPath.row) as! NSDictionary
        let gradeId: String = dict.object(forKey: "id") as! String
        kUserDefaults?.gradeId = gradeId
        kUserDefaults?.isGradeSelected = true
        // 跳转到首页
        kAppDelegate.launchTabBarController()
    }
}
