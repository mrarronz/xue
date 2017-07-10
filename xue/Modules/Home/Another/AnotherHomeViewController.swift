//
//  AnotherHomeViewController.swift
//  xue
//
//  Created by Arron Zhu on 16/11/11.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import SVProgressHUD

class AnotherHomeViewController: SDBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    weak var collectionHeader: AnotherCollectionHeaderView?
    weak var textField: UITextField?
    weak var searchIconView: UIImageView?
    
    lazy var homeVM: HomeViewModel = {
        let homeViewModel = HomeViewModel.init()
        homeViewModel.pageForRecommend = 1
        return homeViewModel
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout.init()
        flowlayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.delaysContentTouches = false
        collectionView.register(CourseGridCell.classForCoder(), forCellWithReuseIdentifier: courseCellReuseID)
        collectionView.register(AnotherTikuCell.classForCoder(), forCellWithReuseIdentifier: tikuCellIdentifier)
        collectionView.register(AnotherSectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseID)
        collectionView.register(AnotherCollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: collectionHeaderReuseID)
        
        collectionView.mj_header = SDRefreshHeader.init(refreshingBlock: {
            self.homeVM.pageForRecommend = 1
            self.loadFlashImages()
            self.refreshCourseData()
        })
        return collectionView
    }()
    
    lazy var navBarView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.sd_navigation().withAlphaComponent(0)
        return view
    }()
    
    lazy var bkgShadowImageView: UIImageView = {
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "img_nav_shadow"))
        return imageView
    }()
    
    lazy var fpsLabel: YYFPSLabel = {
        let fpsLabel = YYFPSLabel.init(frame: CGRect.init(x: 100, y: 60, width: 100, height: 30))
        fpsLabel.sizeToFit()
        return fpsLabel
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initLeftBarButton(image:#imageLiteral(resourceName: "icon_nav_cart"))
        initRightBarButton(image: #imageLiteral(resourceName: "icon_nav_download"))
        setupNavigationBar()
        
        SVProgressHUD.show()
        self.homeVM.pageForRecommend = 1
        self.homeVM.loadCourseData { (succeed, error) in
            SVProgressHUD.dismiss()
            if succeed {
                self.setupCollectionView()
                self.collectionView.reloadData()
                self.loadFlashImages()
            } else {
                SVProgressHUD.showError(withStatus: error?.errorMsg)
            }
            self.view.addSubview(self.fpsLabel)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init views
    
    func setupNavigationBar() {
        self.fd_prefersNavigationBarHidden = true
        setupNavBackgroundView()
        setupTextField()
        setupButtonItems()
    }
    
    func setupNavBackgroundView() {
        self.view.addSubview(self.navBarView)
        self.navBarView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64)
        }
        self.navBarView.addSubview(self.bkgShadowImageView)
        self.bkgShadowImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.navBarView)
            make.height.equalTo(80)
        }
    }
    
    func setupTextField() {
        let textField = UITextField.init()
        textField.borderStyle = UITextBorderStyle.none
        textField.layer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.placeholder = "搜索课程"
        textField.delegate = self
        textField.layer.cornerRadius = 15;
        
        // 设置textField大小
        let viewWidth:CGFloat = UI_SCREEN_WIDTH - itemViewWidth()*2
        let textFieldHeight:CGFloat = 30
        textField.setValue(UIColor.sd_darkGray(), forKeyPath: "_placeholderLabel.textColor")
        
        // 创建搜索图标
        let searchImage = #imageLiteral(resourceName: "icon_nav_search").withRenderingMode(.alwaysTemplate)
        let searchImageView = UIImageView.init(image:searchImage)
        searchImageView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 20, height: 20))
        searchImageView.tintColor = UIColor.sd_darkGray()
        
        let searchView = UIView.init()
        searchView.frame = CGRect.init(x: 0, y: 0, width: 40, height: 30)
        searchView.addSubview(searchImageView)
        searchImageView.center = searchView.center
        self.searchIconView = searchImageView
        
        textField.leftView = searchView
        textField.leftViewMode = .always
        
        self.navBarView.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.navBarView)
            make.centerY.equalTo(self.navBarView.snp.centerY).offset(10)
            make.size.equalTo(CGSize.init(width: viewWidth, height: textFieldHeight))
        }
        self.textField = textField
        
        // 设置button用以点击跳转
        let button = UIButton.init(type: .custom)
        textField.addSubview(button)
        button.addTarget(self, action: #selector(textFieldDidTapped), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(textField)
        }
    }
    
    func setupButtonItems() {
        let leftButton = UIButton.init(type: .custom)
        leftButton.setImage(#imageLiteral(resourceName: "icon_nav_cart"), for: .normal)
        leftButton.contentHorizontalAlignment = .left
        leftButton.addTarget(self, action: #selector(onTapLeftBarButton), for: .touchUpInside)
        leftButton.isExclusiveTouch = true
        
        let rightButton = UIButton.init(type: .custom)
        rightButton.setImage(#imageLiteral(resourceName: "icon_nav_download"), for: .normal)
        rightButton.contentHorizontalAlignment = .right
        rightButton.addTarget(self, action: #selector(onTapRightBarButton), for: .touchUpInside)
        rightButton.isExclusiveTouch = true
        
        self.navBarView.addSubview(leftButton)
        self.navBarView.addSubview(rightButton)
        
        leftButton.snp.makeConstraints { (make) in
            make.left.equalTo(itemViewLeft())
            make.centerY.equalTo((self.textField?.snp.centerY)!)
            make.width.height.equalTo(itemViewWidth())
        }
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.navBarView).offset(-itemViewLeft())
            make.centerY.equalTo((self.textField?.snp.centerY)!)
            make.width.height.equalTo(itemViewWidth())
        }
    }
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.view.bringSubview(toFront: self.navBarView)
    }
    
    // MARK: - Load data
    
    func loadFlashImages() {
        _ = self.homeVM.loadFlashImages { (imageModels) in
            self.collectionHeader?.refreshImages(imageModels: imageModels)
        }
    }
    
    func refreshCourseData() {
        self.homeVM.loadCourseData { (succeed, error) in
            self.collectionView.mj_header.endRefreshing()
            if succeed {
                self.collectionView.reloadData()
            } else {
                SVProgressHUD.showError(withStatus: error?.errorMsg)
            }
        }
    }
    
    // MARK:- Actions
    
    @objc func textFieldDidTapped() {
        NALog("Search button tapped")
    }
    
    override func onTapLeftBarButton() {
        
    }
    
    override func onTapRightBarButton() {
        
    }
    
    func refreshButtonTapped(sender: UIButton) {
        NALog("More button tapped with index:\(sender.tag)")
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeHeight: CGFloat = flashImageHeight()
        
        if scrollView.contentOffset.y > changeHeight {
            let alpha: CGFloat = 1 - ((changeHeight + 64 - scrollView.contentOffset.y) / 64);
            self.navBarView.backgroundColor = UIColor.sd_navigation().withAlphaComponent(alpha)
            if alpha >= 1.0 {
                changeTextFieldStyle(normalStyle: true)
            } else {
                changeTextFieldStyle(normalStyle: false)
            }
            bkgShadowImageView.alpha = 0
        } else {
            changeTextFieldStyle(normalStyle: false)
            self.navBarView.backgroundColor = UIColor.sd_navigation().withAlphaComponent(0)
            bkgShadowImageView.alpha = 1.0
            if scrollView.contentOffset.y < -changeHeight {
                self.navBarView.alpha = 0
            } else {
                self.navBarView.alpha = 1.0
            }
        }
    }
    
    func changeTextFieldStyle(normalStyle: Bool) {
        if normalStyle {
            self.searchIconView?.image = #imageLiteral(resourceName: "icon_nav_search")
            self.textField?.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
            self.textField?.layer.backgroundColor = UIColor.white.withAlphaComponent(0.5).cgColor
        } else {
            self.searchIconView?.image = #imageLiteral(resourceName: "icon_nav_search").withRenderingMode(.alwaysTemplate)
            self.textField?.setValue(UIColor.sd_darkGray(), forKeyPath: "_placeholderLabel.textColor")
            self.textField?.layer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 2 {
            return CGSize.init(width: UI_SCREEN_WIDTH, height: 82)
        }
        return CGSize.init(width: itemWidth(), height: itemHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 2 {
            return 0.5
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }
        return itemSpacing()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 {
            return UIEdgeInsetsMake(10, 0, 0, 0)
        }
        return sectionInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: UI_SCREEN_WIDTH, height: totalHeaderHeight)
        }
        return CGSize.init(width: UI_SCREEN_WIDTH, height: 36)
    }
    
    // MARK: - UICollectionViewDataSource & delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.homeVM.recommendCourseList.count
        }
        else if section == 1 {
            return self.homeVM.latestCourseList.count
        }
        return self.homeVM.featuredTikuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 2 {
            let cell = AnotherTikuCell.tikuCell(collectionView: collectionView, indexPath: indexPath)
            let model: HomeTikuModel = self.homeVM.featuredTikuList[indexPath.row] as! HomeTikuModel
            cell.refresh(model: model)
            return cell
            
        } else {
            let cell = CourseGridCell.cell(indexPath: indexPath, collectionView: collectionView)
            if indexPath.section == 0 {
                let model: RecommendCourseModel = self.homeVM.recommendCourseList.object(at: indexPath.row) as! RecommendCourseModel
                cell.refresh(model)
            } else {
                let model: RecommendCourseModel = self.homeVM.latestCourseList.object(at: indexPath.row) as! RecommendCourseModel
                cell.refresh(model)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = AnotherCollectionHeaderView.collectionHeader(collectionView: collectionView, indexPath: indexPath)
            header.homeVC = self
            self.collectionHeader = header
            return header
        } else {
            let header = AnotherSectionHeaderView.sectionHeader(collectionView: collectionView, indexPath: indexPath)
            header.refreshButton.tag = indexPath.section
            header.refreshButton.addTarget(self, action: #selector(refreshButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
            header.subTitleLabel.text = "更多"
            header.moreIconView.image = #imageLiteral(resourceName: "icon_list_more")
            if indexPath.section == 1 {
                header.titleLabel.text = "最新课程"
                header.iconView.image = #imageLiteral(resourceName: "icon_header_new")
            } else {
                header.titleLabel.text = "精选题库"
                header.iconView.image = #imageLiteral(resourceName: "icon_header_recommend")
            }
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
    }

}
