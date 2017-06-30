//
//  SDNavigationController.swift
//  xue
//
//  Created by Arron Zhu on 16/10/12.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit

class SDNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.barTintColor = UIColor.sd_navigation()
        self.navigationBar.barStyle = .black
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        if self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = weakSelf as UIGestureRecognizerDelegate?
            self.delegate = weakSelf
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count > 1 && shouldSupportPopGestureRecognizer() {
            return true
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count == 1 {
            return true
        }
        return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.classForCoder())
    }
    
    // MARK: - Super methods of UINavigationController
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    
    // MARK: - Util methods
    
    func shouldSupportPopGestureRecognizer() -> Bool {
        let viewControllers = unsupportedViewControllers()
        var support = true
        for index in 0..<viewControllers.count {
            let classObj : AnyClass = viewControllers.object(at: index) as! AnyClass
            if (self.topViewController?.isKind(of: classObj))! {
                support = false
                break
            }
        }
        return support
    }
    
    func unsupportedViewControllers() -> NSArray {
        return [SDLoginViewController.classForCoder()]
    }
    
    // MARK: - Orientation
    
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
