//
//  HomeViewModel.swift
//  xue
//
//  Created by Arron Zhu on 16/11/7.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

import UIKit
import NetworkService

let homePageSize: Int = 4
let commonPageSize: Int = 10

class HomeViewModel: NSObject {

    var pageForRecommend: Int?
    let pageForTiku: Int = 1
    var recommendCourseList = NSMutableArray.init()
    var latestCourseList = NSMutableArray.init()
    var featuredTikuList = NSMutableArray.init()
    
    /**
     *  首页tableViewcell的高度
     */
    func heightForRow(indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            var rowCount = self.recommendCourseList.count/2
            if self.recommendCourseList.count % 2 != 0 {
                rowCount += 1
            }
            return cellHeight(rows: CGFloat(rowCount))
        }
        else if (indexPath.section == 1) {
            var rowCount = self.latestCourseList.count/2
            if self.latestCourseList.count % 2 != 0 {
                rowCount += 1
            }
            return cellHeight(rows: CGFloat(rowCount))
        }
        return 82
    }
    
    /**
     *  获取轮播图
     */
    func loadFlashImages(_ completion: @escaping ((_ imageModels: NSArray) -> Void)) -> SDBaseRequest {
        let request = SDFlashPictureRequest.init()
        request.start { (succeed, response, error) in
            if succeed {
                var array: NSArray? = FlashImageModel.mj_objectArray(withKeyValuesArray: response)
                if array == nil {
                    array = NSArray.init()
                }
                completion(array!)
            } else {
                NALog("load flash image failed: \(error as Optional)")
            }
        }
        return request
    }
    
    /**
     *  获取推荐课程
     */
    func getRecommendCourse(completion: SDBooleanResultBlock?) -> SDBaseRequest {
        
        let request = SDRecommendRequest.init(page: pageForRecommend!,
                                              levelId: kUserDefaults?.levelId,
                                              gradeId: kUserDefaults?.gradeId,
                                              subjectId: kUserDefaults?.subjectId)
        request.start { (succeed, response, error) in
            if succeed {
                if response == nil {
                    self.pageForRecommend = 1
                    if completion != nil {
                        completion!(true, error)
                    }
                    return
                }
                let dict: NSDictionary? = (response as! NSArray).firstObject as? NSDictionary
                let recommendList: AnyObject? = dict?.object(forKey: "courseList") as AnyObject?
                if recommendList != nil && !(recommendList?.isKind(of: NSNull.classForCoder()))! {
                    
                    if (recommendList?.count)! > 0 {
                        if (recommendList?.isKind(of: NSArray.classForCoder()))! {
                            self.recommendCourseList = RecommendCourseModel.mj_objectArray(withKeyValuesArray: recommendList)
                        }
                        else if (recommendList?.isKind(of: NSDictionary.classForCoder()))! {
                            let tempArray = NSMutableArray.init()
                            let convertDict: NSDictionary = recommendList as! NSDictionary
                            for key in convertDict.allKeys {
                                let finalDict = convertDict.object(forKey: key)
                                let model: RecommendCourseModel = RecommendCourseModel.mj_object(withKeyValues: finalDict)
                                tempArray.add(model)
                            }
                            self.recommendCourseList = tempArray
                        }
                        let page: Int? = dict?.object(forKey: "page") as? Int
                        if (recommendList?.count)! < homePageSize {
                            self.pageForRecommend = 1
                        } else {
                            self.pageForRecommend = page
                        }
                    } else {
                        self.pageForRecommend = 1
                        self.recommendCourseList.removeAllObjects()
                    }
                } else {
                    self.pageForRecommend = 1
                    self.recommendCourseList.removeAllObjects()
                }
                
                if completion != nil {
                    completion!(true, error)
                }
            } else {
                if completion != nil {
                    completion!(false, error)
                }
            }
        }
        return request
    }
    
    /**
     *  获取课程和试题
     */
    func loadCourseData(completion: SDBooleanResultBlock?) {
        
        // 推荐课程
        let request1 = SDRecommendRequest.init(page: pageForRecommend!,
                                               levelId: kUserDefaults?.levelId,
                                               gradeId: kUserDefaults?.gradeId,
                                               subjectId: kUserDefaults?.subjectId)
        // 最新课程
        let request2 = SDLatestCourseRequest.init(levelId: kUserDefaults?.levelId,
                                                  gradeId: kUserDefaults?.gradeId,
                                                  subjectId: kUserDefaults?.subjectId)
        
        // 精选题库
        let request3 = SDFeaturedTikuRequest.init(page: pageForTiku, levelId: kUserDefaults?.levelId)
        
        let batchRequest = YTKBatchRequest.init(request: [request1, request2, request3])
        
        NALog("Sending batch request to load course data...")
        
        batchRequest.startWithCompletionBlock(success: { (batchRequest) in
            
            let request1: SDRecommendRequest = batchRequest.requestArray[0] as! SDRecommendRequest
            let request2: SDLatestCourseRequest = batchRequest.requestArray[1] as! SDLatestCourseRequest
            let request3: SDFeaturedTikuRequest = batchRequest.requestArray[2] as! SDFeaturedTikuRequest
            
            // 解析推荐课程数据
            let object1 =  request1.responseJSONObject as! [String : AnyObject]
            let status1: Int = Int(object1["status"] as! String)!
            if status1 == 200 {
                let dict: NSDictionary? = object1["data"]?.firstObject as? NSDictionary
                let recommendList: AnyObject? = dict?.object(forKey: "courseList") as AnyObject?
                if recommendList != nil && !(recommendList?.isKind(of: NSNull.classForCoder()))! {
                    
                    if (recommendList?.count)! > 0 {
                        
                        if (recommendList?.isKind(of: NSArray.classForCoder()))! {
                            self.recommendCourseList = RecommendCourseModel.mj_objectArray(withKeyValuesArray: recommendList)
                        }
                        else if (recommendList?.isKind(of: NSDictionary.classForCoder()))! {
                            let tempArray = NSMutableArray.init()
                            let convertDict: NSDictionary = recommendList as! NSDictionary
                            for key in convertDict.allKeys {
                                let finalDict = convertDict.object(forKey: key)
                                let model: RecommendCourseModel = RecommendCourseModel.mj_object(withKeyValues: finalDict)
                                tempArray.add(model)
                            }
                            self.recommendCourseList = tempArray
                        }
                        let page: Int? = dict?.object(forKey: "page") as? Int
                        self.pageForRecommend = page
                    } else {
                        self.pageForRecommend = 1
                        self.recommendCourseList.removeAllObjects()
                    }
                    
                } else {
                    self.pageForRecommend = 1
                    self.recommendCourseList.removeAllObjects()
                }
            }
            
            // 解析最新课程数据
            let object2 = request2.responseJSONObject as! [String : AnyObject]
            let status2: Int = Int(object2["status"] as! String)!
            if status2 == 200 {
                let latestList: NSArray? = object2["data"] as! NSArray?
                if latestList != nil && !(latestList?.isKind(of: NSNull.classForCoder()))! {
                    self.latestCourseList = RecommendCourseModel.mj_objectArray(withKeyValuesArray: latestList)
                } else {
                    self.latestCourseList.removeAllObjects()
                }
            }
            
            // 解析精选题库数据
            let object3 = request3.responseJSONObject as! [String : AnyObject]
            let status3: Int = Int(object3["status"] as! String)!
            if status3 == 200 {
                let dict: NSDictionary = object3["data"]?.firstObject as! NSDictionary
                let tikuList: NSArray? = dict.object(forKey: "list") as! NSArray?
                if tikuList != nil && !(tikuList?.isKind(of: NSNull.classForCoder()))! {
                    if (tikuList?.count)! > 0 {
                        self.featuredTikuList = HomeTikuModel.mj_objectArray(withKeyValuesArray: tikuList)
                    } else {
                        self.featuredTikuList.removeAllObjects()
                    }
                } else {
                    self.featuredTikuList.removeAllObjects()
                }
            }
            
            if completion != nil {
                completion!(true, nil)
            }
            
        }, failure: { (batchRequest) in
            
            let error = SDError.init(domain: SDResponseNoneDomain, code: 10000, msg: SDCommonRequestError)
            if completion != nil {
                completion!(false, error)
            }
        })
    }
    
}
