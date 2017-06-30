//
//  AnotherCollectionHeaderView.swift
//  xue
//
//  Created by Arron Zhu on 16/11/11.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import SDCycleScrollView

let collectionHeaderReuseID = "AnotherCollectionHeaderView"
let headerViewHeight = flashImageHeight() + 100
let totalHeaderHeight = headerViewHeight + 36

class AnotherCollectionHeaderView: UICollectionReusableView, SDCycleScrollViewDelegate {
    
    lazy var imageScrollView: SDCycleScrollView = {
        let scrollView = SDCycleScrollView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.bounds.size.width, height: flashImageHeight())))
        scrollView.backgroundColor = UIColor.init(hexString: "F4F4F4")
        scrollView.delegate = self
        scrollView.autoScrollTimeInterval = 4
//        scrollView.bannerImageViewContentMode = .scaleAspectFill
        scrollView.placeholderImage = #imageLiteral(resourceName: "bkg_home_placeholder")
        return scrollView
    }()
    
    lazy var buttonView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.frame = CGRect.init(x: 0, y: flashImageHeight()+10, width: UI_SCREEN_WIDTH, height: 80)
        return view
    }()
    
    lazy var headerView: AnotherSectionHeaderView = {
        let header = AnotherSectionHeaderView.init(frame: CGRect.init(x: 0, y: headerViewHeight, width: UI_SCREEN_WIDTH, height: 36), needRefresh: true)
        header.backgroundColor = UIColor.init(hexString: "#f9f9f9")
        header.titleLabel.text = "热门推荐"
        header.iconView.image = #imageLiteral(resourceName: "icon_header_hot")
        header.subTitleLabel.text = "换一批"
        header.moreIconView.image = #imageLiteral(resourceName: "icon_home_refresh")
        header.refreshButton.addTarget(self, action: #selector(refreshButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
        return header
    }()
    
    weak var homeVC: AnotherHomeViewController?
    var imageModels = NSArray.init()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.imageScrollView)
        self.addSubview(self.buttonView)
        self.addSubview(self.headerView)
        
        setupButtonView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func collectionHeader(collectionView: UICollectionView, indexPath: IndexPath) -> AnotherCollectionHeaderView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: collectionHeaderReuseID, for: indexPath)
        return header as! AnotherCollectionHeaderView
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
    
    // MARK: - Actions
    
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
    
    func refreshButtonTapped(sender: UIButton) {
        self.headerView.startAnimating()
        _ = self.homeVC?.homeVM.getRecommendCourse(completion: { (succeed, error) in
            self.headerView.stopAnimating()
            if succeed {
                self.homeVC?.collectionView.reloadData()
            } else {
                self.homeVC?.view.toast(error?.errorMsg)
            }
        })
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
