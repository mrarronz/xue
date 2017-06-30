//
//  AppDelegate.swift
//  xue
//
//  Created by Arron Zhu on 16/10/12.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import SDWebImage
import YTKNetwork
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController: SDTabBarController?
    lazy var loginNavController: SDNavigationController = {
        let loginVC = SDLoginViewController.init()
        let loginNavVC = SDNavigationController.init(rootViewController: loginVC)
        return loginNavVC
    }()

    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.isExclusiveTouch = true
        
        if application.statusBarOrientation != .portrait {
            application.statusBarOrientation = .portrait
        }
        
        setupRequestParams()
        
        if (kUserDefaults?.isGradeSelected)! {
            launchTabBarController()
        } else {
            let selectGradeVC = SDSelectGradeViewController.init()
            setupRootVC(selectGradeVC)
        }
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Launch options
    
    func setupRequestParams() {
        YTKNetworkConfig.shared().baseUrl = SDOnlineReleaseURL
        let securityPolicy = AFSecurityPolicy.init(pinningMode: .none)
        securityPolicy.allowInvalidCertificates = true
        securityPolicy.validatesDomainName = false
        YTKNetworkConfig.shared().securityPolicy = securityPolicy
    }

    
    // MARK: - Launch ViewControllers
    
    func launchViewControllerDependsOnLogin() {
        if (kUserDefaults?.isUserLogin)! {
            tabBarController = SDTabBarController.init()
            self.window?.rootViewController = tabBarController
        } else {
            if (kUserDefaults?.isGuestLogin)! {
                tabBarController = SDTabBarController.init()
                self.window?.rootViewController = tabBarController
            } else {
                self.window?.rootViewController = self.loginNavController
            }
        }
    }
    
    func launchTabBarController() {
        if tabBarController == nil {
            tabBarController = SDTabBarController.init()
        }
        if tabBarController?.selectedIndex != 0 {
            tabBarController?.selectedIndex = 0
        }
        setupRootVC(tabBarController!)
    }
    
    func applyAnimation(layer: CALayer) {
        let transition = CATransition.init()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        layer.add(transition, forKey: nil)
    }
    
    func setupRootVC(_ rootVC: UIViewController) {
        window?.rootViewController = rootVC
        applyAnimation(layer: (window?.layer)!)
    }
    
}

