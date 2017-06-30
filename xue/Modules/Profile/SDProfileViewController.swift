//
//  SDProfileViewController.swift
//  xue
//
//  Created by Arron Zhu on 16/10/12.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import SnapKit

class SDProfileViewController: SDBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView?
    private var options: NSArray?
    private var headerView: ProfileHeaderView?
    private var strechHeader: StrechableHeaderView?
    
    private let headerCellReuseID = "SDUserHeaderCell"
    private let itemCellReuseID = "SDUserOptionCell"
    
    override func loadView() {
        self.view = UIView.init(frame: UIScreen.main.applicationFrame)
        initRightBarButton(image:#imageLiteral(resourceName: "icon_user_setting").withRenderingMode(UIImageRenderingMode.alwaysTemplate))
        initLeftBarButton(image: #imageLiteral(resourceName: "icon_nav_share"))
        options = SDDictHandler.instance.userOptions()
        
        // init tableview
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView?.backgroundColor = UIColor.sd_background()
        tableView?.separatorColor = UIColor.sd_background()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        tableView?.sectionFooterHeight = 6
        tableView?.register(SDUserHeaderCell.classForCoder(), forCellReuseIdentifier: headerCellReuseID)
        tableView?.register(SDUserOptionCell.classForCoder(), forCellReuseIdentifier: itemCellReuseID)
        self.view.addSubview(tableView!)
        
        tableView!.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        headerView = ProfileHeaderView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.view.bounds.size.width, height: 200)))
        strechHeader = StrechableHeaderView.init()
        strechHeader?.strechHeader(tableView: tableView!, strechView: headerView!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: UIColor.clear)
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = UIRectEdge.top
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        strechHeader?.resizeView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        strechHeader?.scrollViewDidScroll(scrollView: scrollView)
        
        let changeHeight: CGFloat = 60
        if scrollView.contentOffset.y > changeHeight {
            let alpha: CGFloat = 1 - ((changeHeight + 64 - scrollView.contentOffset.y) / 64);
            self.navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: UIColor.sd_navigation().withAlphaComponent(alpha))
        } else {
            self.navigationController?.navigationBar.lt_setBackgroundColor(backgroundColor: UIColor.clear)
        }
    }
    
    // MARK:- UITableViewDataSource 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.options?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items: NSArray = self.options?.object(at: section) as! NSArray
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : SDUserOptionCell = tableView.dequeueReusableCell(withIdentifier: itemCellReuseID) as? SDUserOptionCell {
            let items : NSArray = self.options?.object(at: indexPath.section) as! NSArray
            let dict:NSDictionary = items.object(at: indexPath.row) as! NSDictionary
            cell.setTitle(title: dict.object(forKey: "title") as! String)
            cell.setIcon(icon: UIImage.init(named: dict.object(forKey: "image") as! String)!)
            cell.showNotificationDot(show: false)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func onTapRightBarButton() {
        
    }

}
