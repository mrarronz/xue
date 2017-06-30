//
//  SDHomeHeaderView.swift
//  xue
//
//  Created by Arron Zhu on 16/11/9.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import SDCycleScrollView

func scrollImageHeight() -> CGFloat {
    return UI_SCREEN_WIDTH * 480 / 1080
}

class SDHomeHeaderView: UIView, SDCycleScrollViewDelegate {
    
    lazy var imageScrollView: SDCycleScrollView = {
        let scrollView = SDCycleScrollView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.bounds.size.width, height: scrollImageHeight())))
        scrollView.backgroundColor = UIColor.init(hexString: "F4F4F4")
        scrollView.delegate = self
        scrollView.autoScrollTimeInterval = 4
        scrollView.bannerImageViewContentMode = .scaleAspectFill
        scrollView.placeholderImage = #imageLiteral(resourceName: "bkg_home_placeholder")
        return scrollView
    }()
    
    lazy var buttonView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.frame = CGRect.init(x: 0, y: scrollImageHeight()+10, width: UI_SCREEN_WIDTH, height: 70)
        return view
    }()
    
    
    weak var homeVC: SDHomeViewController?
    var imageModels = NSArray.init()
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UI_SCREEN_WIDTH, height: scrollImageHeight()+90))
        self.backgroundColor = UIColor.white
        self.addSubview(self.imageScrollView)
        self.addSubview(self.buttonView)
        
        setupButtonView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonView() {
        let items: NSArray = SDDictHandler.instance.homeItems()
        let width: CGFloat = self.frame.size.width/CGFloat(items.count)
        for i in 0..<items.count {
            let dict: NSDictionary = items[i] as! NSDictionary
            let itemButton: SDItemButton = SDItemButton.button(title: (dict["title"] as? String)!,
                                                               image: UIImage.init(named: dict["image"] as! String)!)
            itemButton.labelFont = UIFont.systemFont(ofSize: 12)
            itemButton.imageSize = CGSize.init(width: 36, height: 36)
            itemButton.tag = i
            itemButton.addTarget(self, action: #selector(itemButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
            self.buttonView.addSubview(itemButton)
            
            itemButton.snp.makeConstraints({ (make) in
                make.left.equalTo(Int(width) * i)
                make.width.equalTo(width)
                make.height.equalTo(65)
                make.centerY.equalTo(self.buttonView)
            })
        }
    }
    
    func refreshImages(imageModels: NSArray) {
        self.imageModels = imageModels
        var imageURLs = [String]()
        for model in imageModels {
            imageURLs.append((model as! FlashImageModel).pic!)
        }
        self.imageScrollView.imageURLStringsGroup = imageURLs
    }
    
    func itemButtonClicked(sender: SDItemButton) {
        NALog("item button tapped:\(sender.tag)")
        switch sender.tag {
        case 0:
            // 扫二维码
            SDScanHelper.beginScanning {
                
            }
            break
        case 1:
            // 录播课程
            
            break
        case 2:
            // 微课
            
            break
        case 3:
            // 智慧套餐
            
            break
        case 4:
            // 题库
            
            break
        default:
            break
        }
    }
    
    // MARK: - SDCycleScrollViewDelegate
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        NALog("flash image tapped:\(index)")
        if self.imageModels.count == 0 {
            return
        }
        let model: FlashImageModel = self.imageModels.object(at: index) as! FlashImageModel
        switch Int(model.type!)! {
        case 1:
            // 录播课
            
            break
        case 2:
            // 微课
            
            break
        case 3:
            // 试卷
            
            break
        case 4:
            // 智慧套餐
            
            break
        case 5:
            // 网页
            
            break
        default:
            break
        }
    }

}
