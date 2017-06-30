//
//  SDBaseViewController.swift
//  xue
//
//  Created by Arron Zhu on 16/10/12.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        self.view.backgroundColor = UIColor.sd_background()
        self.edgesForExtendedLayout = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NALog("Received memory warning in class: \(self)")
        if self.isViewLoaded && self.view.window == nil {
            self.view = nil
        }
    }
    
    // MARK:- Configurations
    
    func setupBackButton() {
        if self != self.navigationController?.viewControllers[0] {
            initBackButton()
        }
    }
    
    func imageItemSize() -> CGSize {
        return CGSize.init(width: 44, height: 44)
    }
    
    func itemViewWidth() -> CGFloat {
        let leftItemBounds = self.navigationItem.leftBarButtonItem?.customView?.bounds
        let rightItemBounds = self.navigationItem.rightBarButtonItem?.customView?.bounds
        
        let convertFrame = self.navigationItem.leftBarButtonItem?.customView?.convert(leftItemBounds!, to: self.navigationController?.navigationBar)
        let padding = convertFrame?.origin.x
        
        let width = max((leftItemBounds?.size.width)!, (rightItemBounds?.size.width)!) + padding!
        return width
    }
    
    func itemViewLeft() -> CGFloat {
        let leftItemBounds = self.navigationItem.leftBarButtonItem?.customView?.bounds
        let convertFrame = self.navigationItem.leftBarButtonItem?.customView?.convert(leftItemBounds!, to: self.navigationController?.navigationBar)
        let padding = convertFrame?.origin.x
        return padding!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    // MARK:- Init Views
    
    func initBackButton() {
        initLeftBarButton(image: #imageLiteral(resourceName: "icon_nav_back"))
    }
    
    func initLeftBarButton(image:UIImage) {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(origin: CGPoint.zero, size: imageItemSize())
        button.setImage(image, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(onTapLeftBarButton), for: .touchUpInside)
        button.isExclusiveTouch = true
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func initRightBarButton(image:UIImage) {
        let button = UIButton.init(type: .custom)
        button.tintColor = UIColor.white
        button.frame = CGRect.init(origin: CGPoint.zero, size: imageItemSize())
        button.setImage(image, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(onTapRightBarButton), for: .touchUpInside)
        button.isExclusiveTouch = true
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func initLeftBarButton(title:String) {
        let barButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(onTapLeftBarButton))
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func initRightBarButton(title:String) {
        let barButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(onTapRightBarButton))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func segmentControl(items:Array<String>) -> UISegmentedControl {
        let segmentControl = UISegmentedControl.init(items: items)
        segmentControl.backgroundColor = UIColor.sd_navigation()
        segmentControl.tintColor = UIColor.white
        
        // 设置title属性
        segmentControl.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.white.withAlphaComponent(0.8)], for: .normal)
        segmentControl.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.sd_searchView()], for: .selected)
        segmentControl.selectedSegmentIndex = 0
        
        // 设置标题和宽度
        let newItems = items.sorted { (str1, str2) -> Bool in
            return str1.characters.count > str2.characters.count
        }
        let maxTitle = newItems.first
        let textSize = maxTitle?.size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)])
        let itemWidth = (textSize?.width)! + 16
        for index in 0..<items.count {
            segmentControl.setWidth(itemWidth, forSegmentAt: index)
        }

        // 添加点击事件
        segmentControl.addTarget(self, action: #selector(segmentControlClicked), for: .valueChanged)
        
        return segmentControl
    }
    
    // MARK:- Event
    @objc func onTapLeftBarButton() {
        self.navigationController!.popViewController(animated: true)
    }
    
    @objc func onTapRightBarButton() {
        
    }
    
    @objc func segmentControlClicked(segment: UISegmentedControl) {
        
    }

}
