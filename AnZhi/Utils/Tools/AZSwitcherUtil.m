//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZSwitcherUtil.h"
#import "AZStoryboardUtil.h"
#import "AZAppUtil.h"
#import "AZAlertUtil.h"
#import "AZDataManager.h"
#import "AZRegisterHelper.h"
#import "AZDateUtil.h"
#import "AZWebVC.h"
#import "AZQuestionPublishVC.h"
#import "AZQuestionPublishFinishVC.h"
#import "AZQuestionWrapper.h"
#import "AZQuestionDetailVC.h"

@implementation AZSwitcherUtil

#pragma mark - Web

+ (void)pushToShowWebVC:(NSString *)urlStr title:(NSString *)title {
    AZWebVC *vc = [AZWebVC createInstance];
    vc.webUrlStr = urlStr;
    vc.title = title;
    [AZSwitcherUtil pushToShowInDefaultNaviVC:vc];
}

+ (void)presentToShowWebVC:(AZWebVC *)webVC {
    [AZSwitcherUtil presentToShowVC:webVC];
}

#pragma mark - Common

+ (void)presentToShowVC:(UIViewController *)vc {
    [[AZAppUtil getTopMostViewController] presentViewController:vc animated:YES completion:nil];
}

+ (void)presentToShowCommonNavRootVC:(UIViewController *)rootVC {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [AZSwitcherUtil presentToShowVC:nav];
}


#pragma mark - Question


+ (void)pushToShowQuestionDetailVC:(AZQuestionWrapper *)questionWrapper {
    AZQuestionDetailVC *vc = [AZQuestionDetailVC createInstance];
    vc.questionWrapper = questionWrapper;
    [AZSwitcherUtil pushToShowInDefaultNaviVC:vc];
}

+ (void)pushToShowQuestionPublishVC {
    AZQuestionPublishVC *vc = [AZQuestionPublishVC createInstance];
    [AZSwitcherUtil pushToShowInDefaultNaviVC:vc];
}

+ (void)pushToShowQuestionPublishFinishVC:(AZQuestionWrapper *)questionWrapper {
    AZQuestionPublishFinishVC *vc = [AZQuestionPublishFinishVC createInstance];
    vc.questionWrapper = questionWrapper;
    [AZSwitcherUtil pushToShowInDefaultNaviVC:vc];
}


#pragma mark - Private Func

+ (void)pushToShowInDefaultNaviVC:(UIViewController *)vc {
    UINavigationController *naviVC = [AZAppUtil getTopMostNavigationController];
    [naviVC pushViewController:vc animated:YES];
}

@end
