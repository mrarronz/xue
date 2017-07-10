//
//  SDHomeViewController.swift
//  xue
//
//  Created by Arron Zhu on 16/10/12.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import SVProgressHUD

class SDHomeViewController: SDBaseViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, HomeGridCellDelegate, HomeSectionHeaderViewDelegate {

    var tableView: UITableView?
    
    lazy var headerView: SDHomeHeaderView = {
        let headerView = SDHomeHeaderView.init()
        headerView.homeVC = self
        return headerView
    }()
    
    lazy var homeVM: HomeViewModel = {
        let homeViewModel = HomeViewModel.init()
        homeViewModel.pageForRecommend = 1
        return homeViewModel
    }()
    
    lazy var fpsLabel: YYFPSLabel = {
        let fpsLabel = YYFPSLabel.init(frame: CGRect.init(x: 100, y: 60, width: 100, height: 30))
        fpsLabel.sizeToFit()
        return fpsLabel
    }()
    
    override func loadView() {
        self.view = UIView.init(frame: UIScreen.main.applicationFrame)
        initLeftBarButton(image:#imageLiteral(resourceName: "icon_nav_cart"))
        initRightBarButton(image: #imageLiteral(resourceName: "icon_nav_download"))
        setupTitleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.showGifHUD()
        self.homeVM.pageForRecommend = 1
        self.homeVM.loadCourseData { (succeed, error) in
            self.view.hideGifHUD()
            if succeed {
                self.setupTableView()
                self.tableView?.reloadData()
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
    
    func setupTableView() {
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView?.backgroundColor = UIColor.white
        tableView?.separatorStyle = .none
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.tableHeaderView = headerView
        tableView?.delaysContentTouches = false
        tableView?.register(SDTikuListCell.classForCoder(), forCellReuseIdentifier: tikuCellReuseID)
        tableView?.register(HomeGridCell.classForCoder(), forCellReuseIdentifier: homeGridCellReuseID)
        tableView?.register(HomeSectionHeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: headerReuseID)
        self.view.addSubview(tableView!)
        
        tableView?.mj_header = SDRefreshHeader.init(refreshingBlock: {
            self.homeVM.pageForRecommend = 1
            self.refreshCourseData()
            self.loadFlashImages()
        })
        
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
    }
    
    func setupTitleView() {
        let textField = UITextField.init()
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.backgroundColor = UIColor.sd_searchView()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.placeholder = "同学，今天想学点啥"
        textField.delegate = self
        
        // 设置textField大小
        let viewWidth:CGFloat = UI_SCREEN_WIDTH - itemViewWidth()*2
        let textFieldHeight:CGFloat = 30
        textField.view_size = CGSize.init(width: viewWidth, height: textFieldHeight)
        textField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        
        // 创建搜索图标
        let searchImageView = UIImageView.init()
        let image = #imageLiteral(resourceName: "icon_nav_search")
        searchImageView.image = image
        textField.addSubview(searchImageView)
        searchImageView.view_size = image.size
        searchImageView.view_right = textField.view_width - 8
        searchImageView.view_centerY = textFieldHeight/2
        searchImageView.autoresizingMask = .flexibleLeftMargin
        
        // 设置button用以点击跳转
        let button = UIButton.init(type: .custom)
        button.frame = textField.bounds
        textField.addSubview(button)
        button.addTarget(self, action: #selector(textFieldDidTapped), for: .touchUpInside)
        
        self.navigationItem.titleView = textField
    }
    
    // MARK: - Load data 
    
    func loadFlashImages() {
        _ = self.homeVM.loadFlashImages { (imageModels) in
            self.headerView.refreshImages(imageModels: imageModels)
        }
    }
    
    func refreshCourseData() {
        self.homeVM.loadCourseData { (succeed, error) in
            self.tableView?.mj_header.endRefreshing()
            if succeed {
                self.tableView?.reloadData()
            } else {
                SVProgressHUD.showError(withStatus: error?.errorMsg)
            }
        }
    }
    
    // MARK:- Actions
    
    @objc func textFieldDidTapped() {
        
    }
    
    override func onTapLeftBarButton() {
        
    }
    
    override func onTapRightBarButton() {
        
    }
    
    func headerViewMoreTapp(sender: UIButton) {
        
    }
    
    func joinButtonTapped(sender: UIButton) {
        
    }
    
    //MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return self.homeVM.featuredTikuList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 {
            let cell = SDTikuListCell.tikuCell(tableView: tableView)
            cell.joinButton.tag = indexPath.row
            cell.joinButton.addTarget(self, action: #selector(joinButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
            let model: HomeTikuModel = self.homeVM.featuredTikuList[indexPath.row] as! HomeTikuModel
            cell.refresh(model: model)
            return cell
        } else {
            let cell = HomeGridCell.homeGridCell(tableView: tableView)
            cell.delegate = self
            if indexPath.section == 0 {
                cell.refresh(items: self.homeVM.recommendCourseList)
            } else {
                cell.refresh(items: self.homeVM.latestCourseList)
            }
            return cell
        }
    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.homeVM.heightForRow(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeSectionHeaderView.headerView(tableView: tableView, section: section)
        headerView.tag = section
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: - HomeGridCellDelegate
    func gridCell(_ cell: HomeGridCell, didSelectItemWith model: RecommendCourseModel) {
        NALog("grid cell tapped with title: \(model.title as Optional)")
    }
    
    func didTapMoreButtonInHeaderView(_ header: HomeSectionHeaderView) {
        NALog("heade tapped with index: \(header.tag), title: \(header.titleLabel.text as Optional)")
        if header.tag == 0 {
            header.startAnimating()
            _ = self.homeVM.getRecommendCourse(completion: { (succeed, error) in
                header.stopAnimating()
                if succeed {
                    let indexPath = IndexPath.init(row: 0, section: 0)
                    self.tableView?.reloadRows(at: [indexPath], with: .none)
                } else {
                    SVProgressHUD.showError(withStatus: error?.errorMsg)
                }
            })
        }
    }
}
