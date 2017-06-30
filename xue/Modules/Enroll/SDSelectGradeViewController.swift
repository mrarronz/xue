//
//  SDSelectGradeViewController.swift
//  xue
//
//  Created by Arron Zhu on 16/11/7.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import VTMagic

class SDSelectGradeViewController: SDBaseViewController, VTMagicViewDataSource, VTMagicViewDelegate {
    
    lazy var magicVC: VTMagicController = {
        let magicViewController = VTMagicController.init()
        magicViewController.view.translatesAutoresizingMaskIntoConstraints = false
        magicViewController.magicView.navigationColor = UIColor.white
        magicViewController.magicView.sliderColor = UIColor.sd_navigation()
        magicViewController.magicView.switchStyle = .default
        magicViewController.magicView.layoutStyle = .divide
        magicViewController.magicView.sliderExtension = 15
        magicViewController.magicView.dataSource = self
        magicViewController.magicView.delegate = self
        return magicViewController
    }()
    
    lazy var loginVM: LoginViewModel = {
        let loginVM = LoginViewModel.init()
        return loginVM
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.sd_black()
        label.textAlignment = .center
        label.text = "选择你的年级"
        return label
    }()
    
    var levels: NSArray = NSArray.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = loginVM.allLevels(completion: { (succeed, array, error) in
            if succeed {
                self.levels = array!
                let levelModel:LevelModel = self.levels.object(at: 1) as! LevelModel
                kUserDefaults?.levelId = levelModel.levelId
                self.setupViews()
                self.magicVC.magicView.reloadData(toPage: 1)
            } else {
                self.view.toast(error?.errorMsg)
                // TODO:显示重新加载的view
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(60)
            make.height.equalTo(30)
        }
        self.addChildViewController(self.magicVC)
        self.view.addSubview(self.magicVC.view)
        if isBelowiPhone4 {
            self.magicVC.view.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self.view)
                make.height.equalTo(234)
                make.centerY.equalTo(self.view)
            })
        } else {
            self.magicVC.view.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self.view)
                make.height.equalTo(234)
                make.top.equalTo(164)
            })
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .default
        }
    }
    
    // MARK: - VTMagicViewDataSource
    
    func menuTitles(for magicView: VTMagicView) -> [String] {
        return self.loginVM.titles
    }
    
    func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {
        
        let itemReuseId = "itemIdentifier"
        var menuItem: CommonButton? = magicView.dequeueReusableItem(withIdentifier: itemReuseId) as! CommonButton?
        if menuItem == nil {
            menuItem = CommonButton.init()
            menuItem?.normalTextColor = UIColor.sd_darkGray()
            menuItem?.selectedTextColor = UIColor.sd_darkGreen()
            menuItem?.labelFont = UIFont.systemFont(ofSize: 20)
        }
        return menuItem!
    }
    
    func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
        
        let controllerReuseId = "controllerIdentifier"
        
        var controller: GradeViewController? = magicView.dequeueReusablePage(withIdentifier: controllerReuseId) as! GradeViewController?
        if controller == nil {
            controller = GradeViewController.init()
            controller?.parentVC = self
            controller?.loginVM = self.loginVM
        }
        return controller!
    }
    
    // MARK: - VTMagicViewDelegate
    
    func magicView(_ magicView: VTMagicView, didSelectItemAt itemIndex: UInt) {
        let levelModel: LevelModel = self.levels.object(at: Int(itemIndex)) as! LevelModel
        kUserDefaults?.levelId = levelModel.levelId
    }
    
    func magicView(_ magicView: VTMagicView, viewDidAppear viewController: UIViewController, atPage pageIndex: UInt) {
        let levelModel: LevelModel = self.levels.object(at: Int(pageIndex)) as! LevelModel
        kUserDefaults?.levelId = levelModel.levelId
        let gradeVC = viewController as! GradeViewController
        gradeVC.loadGradeData(index: Int(pageIndex))
    }
}
