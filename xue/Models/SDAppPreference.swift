//
//  SDAppPreference.swift
//  xue
//
//  Created by Arron Zhu on 16/11/1.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import Foundation

class SDAppPreference: NSObject {
    
    @objc var phone: NSString?
    @objc var token: NSString?
    @objc var pid: NSString?
    @objc var refreshToken: NSString?
    @objc var transactions: NSMutableArray?
    @objc var saveStudys: NSMutableArray?
    
    static let sharedInstance = SDAppPreference()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearData),
                                               name: NSNotification.Name(rawValue: SDUserLogoutNotification),
                                               object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func clearData() {
        cleanPersistance()
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        NALog("Undefined key = \(key), value = \(value as Any?)")
    }
    
    // MARK: - Private methods
    
    func persistPath() -> String {
        let fileName = String.init(format: "%@.plist", NSStringFromClass(self.classForCoder))
        let documentPath = NSHomeDirectory() as NSString
        let plistPath = documentPath.appendingPathComponent(fileName)
        return plistPath
    }
    
    func loadData() {
        let archivedDict: NSDictionary? = NSDictionary.init(contentsOfFile: persistPath())
        if archivedDict != nil {
            let data = archivedDict?.object(forKey: NSStringFromClass(self.classForCoder))
            let dict = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            self.setValuesForKeys(dict as! [String : Any])
        }
    }
    
    func commitData() {
        let dict : NSDictionary = propertyValuesDictionary() as NSDictionary
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        let archivedDict : NSDictionary = [NSStringFromClass(self.classForCoder) : data]
        let filePath = persistPath()
        archivedDict.write(toFile: filePath, atomically: true)
        
        let attributes = NSDictionary.init(object: FileProtectionType.complete, forKey: FileAttributeKey.protectionKey as NSCopying)
        do {
            try FileManager.default.setAttributes(attributes as! [FileAttributeKey : Any], ofItemAtPath: filePath)
        } catch {
            NALog("error occurred: \(error)")
        }
    }
    
    func setPersistanceOn() {
        loadData()
        let keys = propertyKeys()
        for key in keys! {
            addObserver(self, forKeyPath: key as! String, options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    
    func setPersistanceOff() {
        let keys = propertyKeys()
        for key in keys! {
            removeObserver(self, forKeyPath: key as! String)
        }
    }
    
    func cleanPersistance() {
        setPersistanceOff()
        let persistKeys = ["transactions", "pid", "saveStudys"]
        let keys = propertyKeys()
        for key in keys! {
            if persistKeys.contains(key as! String) {
                continue
            }
            let valueObj = value(forKey: key as! String)
            if valueObj != nil {
                setValue(nil, forKey: key as! String)
            }
        }
        commitData()
        setPersistanceOn()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        commitData()
    }
    
    // Util method
    func isAccountLogin() -> Bool {
        return ((kUserDefaults?.isUserLogin)! || (kUserDefaults?.isGuestLogin)!)
    }
}
