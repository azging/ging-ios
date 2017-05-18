//
//  AZSwitcherUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 9/12/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZSwitcherUtil.h"
#import "AZStoryboardUtil.h"
#import "AZAppUtil.h"
#import "AZAlertUtil.h"
#import "AZDataManager.h"
#import "AZRegisterHelper.h"
#import "AZDateUtil.h"


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


#pragma mark - Private Func

+ (void)pushToShowInDefaultNaviVC:(UIViewController *)vc {
    UINavigationController *naviVC = [AZAppUtil getTopMostNavigationController];
    [naviVC pushViewController:vc animated:YES];
}

@end
