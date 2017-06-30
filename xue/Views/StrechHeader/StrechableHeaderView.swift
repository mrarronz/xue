//
//  StrechableHeaderView.swift
//  xue
//
//  Created by Arron Zhu on 17/3/8.
//  Copyright © 2017年 sundataonline. All rights reserved.
//

import UIKit

class StrechableHeaderView: NSObject {
    
    var tableView: UITableView?
    var view: UIView?
    
    fileprivate var initialFrame: CGRect?
    fileprivate var defaultViewHeight: CGFloat?
    
    func strechHeader(tableView: UITableView, strechView: UIView) {
        self.tableView = tableView
        self.view = strechView
        
        self.initialFrame = strechView.frame
        self.defaultViewHeight = strechView.frame.size.height
        
        let emptyHeaderView: UIView? = UIView.init(frame: self.initialFrame!)
        self.tableView?.tableHeaderView = emptyHeaderView
        
        self.tableView?.addSubview(self.view!)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var tempFrame = self.view?.frame
        tempFrame?.size.width = (self.tableView?.frame.size.width)!
        self.view?.frame = tempFrame!
        
        if scrollView.contentOffset.y < 0 {
            let offsetY: CGFloat = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1
            self.initialFrame?.origin.y = -offsetY
            self.initialFrame?.size.height = self.defaultViewHeight! + offsetY
            self.view?.frame = self.initialFrame!
        }
    }
    
    func resizeView() {
        self.initialFrame?.size.width = (self.tableView?.frame.size.width)!
        self.view?.frame = self.initialFrame!
    }
}
