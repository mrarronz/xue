//
//  SDUserDefaultsPreference.h
//  xue
//
//  Created by Arron Zhu on 16/7/22.
//  Copyright © 2016年 sundataonline. All rights reserved.
//

#import <PAPreferences/PAPreferences.h>

#pragma clang diagnostic push
#pragma clang diagnostic error "-Wobjc-missing-property-synthesis"

@interface SDUserDefaultsPreference : PAPreferences

/// 选择学段的参数
@property (nonatomic, copy, nullable) NSString *levelId;
@property (nonatomic, copy, nullable) NSString *gradeId;
@property (nonatomic, copy, nullable) NSString *subjectId;

/// app版本号
@property (nonatomic, copy, nullable) NSString *appVersion;
@property (nonatomic, copy, nullable) NSString *appBuild;

/**
 *  首页跳转到选课大厅传入的index, 0不做切换，1微课，2录播课，3题库
 */
@property (nonatomic, assign) NSInteger switchIndex;

/**
 *  用户是否登录
 */
@property (nonatomic, assign) BOOL isUserLogin;
/**
 *  当前是否是游客登录
 */
@property (nonatomic, assign) BOOL isGuestLogin;
/**
 *  是否已经选择过学段
 */
@property (nonatomic, assign) BOOL isGradeSelected;
/**
 *  是否需要显示引导页
 */
@property (nonatomic, assign) BOOL shouldDisplayGuidePage;

/**
 *  是否需要在题库显示划题指导
 */
@property (nonatomic, assign) BOOL shouldDisplayTikuGuideView;

/**
 *  是否需要在易学贴显示下载
 */
@property (nonatomic, assign) BOOL shouldDisplayDownloadView;


/**
 *  是否需要在易学贴做题显示划题指导
 */
@property (nonatomic, assign) BOOL shouldDisplayQuestGuideView;

/**
 *  是否需要练习题做题显示划题指导
 */
@property (nonatomic, assign) BOOL shouldDisplayPracticeGuideView;

/**
 *  是否在播放或下载视频时显示过移动网络弹窗提示
 */
@property (nonatomic, assign) BOOL isAskedForPlayDownload;

/**
 *  是否允许非WiFi网络播放视频或下载，默认为NO
 */
@property (nonatomic, assign) BOOL allowPlayDownloadViaWWAN;

/**
 *  是否接收推送消息
 */
@property (nonatomic, assign) BOOL receivePushNotification;


@end


#pragma clang diagnostic pop
