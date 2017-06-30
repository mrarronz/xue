//
//  SDTabBarController.swift
//  xue
//
//  Created by Arron Zhu on 16/10/12.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import ionicons

class SDTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupViewControllers()
        setupChildViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewControllers() {
        var tabbarControllers : [NavigationController] = []
        let tabbarItems = SDDictHandler.instance.tabbarItems()
        
        for index in 0..<tabbarItems.count {
            let dict:NSDictionary = tabbarItems.object(at: index) as! NSDictionary
            let className : String = dict.object(forKey: "class") as! String
            
            var controller : SDBaseViewController?
            if !className.isEmpty {
                let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                let classObj = NSClassFromString(namespace + "." + className) as! SDBaseViewController.Type
                controller = classObj.init()
            } else {
                controller = SDBaseViewController()
            }
            controller?.navigationItem.title = dict.object(forKey: "title") as! String?
            controller?.tabBarItem.title = dict.object(forKey: "title") as! String?
            controller?.tabBarItem.image = UIImage.init(named: dict.object(forKey: "image_normal") as! String)
            controller?.tabBarItem.selectedImage = UIImage.init(named: dict.object(forKey: "image_pressed") as! String)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            
            let navController : NavigationController = NavigationController.init(rootViewController: controller!)
            tabbarControllers.append(navController)
        }
        self.viewControllers = tabbarControllers
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.sd_black()], for:UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.sd_darkGreen()], for:UIControlState.selected)
    }
    
    // MARK:- Orientation
    
    override var shouldAutorotate: Bool {
        get {
            return true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return UIInterfaceOrientationMask.portrait
        }
    }

}


extension SDTabBarController {
    
    func setupChildViewControllers() {
        
        let homeVC = NavigationController.init(rootViewController: AnotherHomeViewController.init())
        homeVC.tabBarItem.title = "首页"
        homeVC.tabBarItem.image = IonIcons.image(withIcon: ion_ios_home_outline, size: 25, color: UIColor.sd_black())
        homeVC.tabBarItem.selectedImage = IonIcons.image(withIcon: ion_ios_home, size: 25, color: UIColor.black)
        
        let courseVC = NavigationController.init(rootViewController: SDXuankeViewController.init())
        courseVC.tabBarItem.title = "发现课程"
        courseVC.tabBarItem.image = IonIcons.image(withIcon: ion_ios_paperplane_outline, size: 30, color: UIColor.sd_black())
        courseVC.tabBarItem.selectedImage = IonIcons.image(withIcon: ion_ios_paperplane, size: 30, color: UIColor.black)
        
        let schoolVC = NavigationController.init(rootViewController: SDMySchoolViewController.init())
        schoolVC.tabBarItem.title = "我的学堂"
        schoolVC.tabBarItem.image = IonIcons.image(withIcon: ion_ios_book_outline, size: 24, color: UIColor.sd_black())
        schoolVC.tabBarItem.selectedImage = IonIcons.image(withIcon: ion_ios_book, size: 24, color: UIColor.black)
        
        let myVC = NavigationController.init(rootViewController: SDProfileViewController.init())
        myVC.tabBarItem.title = "个人中心"
        myVC.tabBarItem.image = IonIcons.image(withIcon: ion_ios_person_outline, size: 28, color: UIColor.sd_black())
        myVC.tabBarItem.selectedImage = IonIcons.image(withIcon: ion_ios_person, size: 28, color: UIColor.black)
        
        self.viewControllers = [homeVC, courseVC, schoolVC, myVC]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.sd_black()], for:UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black], for:UIControlState.selected)
    }
}
