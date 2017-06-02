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
#import "AZUserVC.h"
#import "AZUserQuestionVC.h"
#import "AZRegisterVC.h"
#import "AZCommonPhotoShowVC.h"
#import "AZImageModel.h"

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


#pragma mark - User

+ (void)pushToShowUserVC {
    AZUserVC *vc = [AZUserVC createInstance];
    [AZSwitcherUtil pushToShowInDefaultNaviVC:vc];
}

+ (void)pushToShowUserQuestionVC {
    AZUserQuestionVC *vc = [AZUserQuestionVC createInstance];
    [AZSwitcherUtil pushToShowInDefaultNaviVC:vc];
}


#pragma mark - Register

+ (void)presentToShowRegisterVC {
    AZRegisterVC *vc = [AZRegisterVC createInstance];
    [AZSwitcherUtil presentToShowCommonNavRootVC:vc];
}

#pragma mark - AZCommonPhotoShowVC

+ (void)pushToShowCommonPhotoShowVC:(AZCommonPhotoShowVC *)photoShowVC {
    [AZSwitcherUtil pushToShowInDefaultNaviVC:photoShowVC];
}

+ (void)presentToShowCommonPhotoShowVC:(NSInteger)index imageModelArr:(NSArray *)imageModelArr {
    AZCommonPhotoShowVC *vc = [AZCommonPhotoShowVC createInstance];
    [vc showImageModelArr:imageModelArr index:index];
    [AZSwitcherUtil presentToShowCommonNavRootVC:vc];
}

+ (void)presentToShowCommonPhotoShowVC:(NSInteger)index imageArr:(NSArray *)imageArr {
    AZCommonPhotoShowVC *vc = [AZCommonPhotoShowVC createInstance];
    [vc showImageArr:imageArr index:index];
    [AZSwitcherUtil presentToShowCommonNavRootVC:vc];
}

+ (void)presentToShowCommonPhotoShowVC:(NSInteger)index imageUrlArr:(NSArray *)imageUrlArr imageThumbUrlArr:(NSArray *)imageThumbUrlArr {
    [AZSwitcherUtil presentToShowCommonPhotoShowVC:index imageModelArr:[self getImageModelArrFromImageUrlArr:imageUrlArr imageThumbUrlArr:imageThumbUrlArr]];
}

+ (NSArray *)getImageModelArrFromImageUrlArr:(NSArray *)imageUrlArr imageThumbUrlArr:(NSArray *)imageThumbUrlArr {
    NSMutableArray *imageModelArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < imageThumbUrlArr.count; ++i) {
        if (i < imageUrlArr.count) {
            AZImageModel *imageModel = [[AZImageModel alloc] init];
            imageModel.imageUrl = imageUrlArr[i];
            imageModel.imageUrlThumb = imageThumbUrlArr[i];
            [imageModelArr addObject:imageModel];
        }
    }
    return imageModelArr;
}


#pragma mark - Private Func

+ (void)pushToShowInDefaultNaviVC:(UIViewController *)vc {
    UINavigationController *naviVC = [AZAppUtil getTopMostNavigationController];
    [naviVC pushViewController:vc animated:YES];
}

@end
