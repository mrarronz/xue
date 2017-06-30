//
//  SDScanHelper.swift
//  xue
//
//  Created by Arron Zhu on 16/10/17.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class SDScanHelper: NSObject {
    
    open class func systemVibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    open class func playSound() {
        var soundId : SystemSoundID?
        let path = Bundle.main.path(forResource: "beep", ofType: "wav")
        if path != nil {
            AudioServicesCreateSystemSoundID(NSURL.fileURL(withPath: path!) as CFURL, &soundId!)
        }
    }
    
    open class func beginScanning(completion:@escaping ((Void)->Void)) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alert = UIAlertView.init(title: "相机不可用",
                                         message: "当前设备相机不可用，无法进行扫描",
                                         delegate: nil,
                                         cancelButtonTitle: "确定")
            alert.show()
            return
        }
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if status == .denied || status == .restricted {
            let alert = UIAlertView.init(title: "相机不可用",
                                         message: "请在\"设置 - 相机\"中打开相机权限以便当前设备能够正常扫描",
                                         delegate: nil,
                                         cancelButtonTitle: "确定")
            alert.show()
            return
        }
        else if status == .authorized {
            DispatchQueue.main.async {
                completion()
            }
        }
        else if status == .notDetermined {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        completion()
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertView.init(title: "相机不可用",
                                                     message: "请在\"设置 - 相机\"中打开相机权限以便当前设备能够正常扫描",
                                                     delegate: nil,
                                                     cancelButtonTitle: "确定")
                        alert.show()
                        return
                    }
                }
            })
        }
    }
}
