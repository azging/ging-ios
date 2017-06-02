//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AZWebVC;
@class AZQuestionWrapper;
@class AZCommonPhotoShowVC;

@interface AZSwitcherUtil : NSObject

#pragma mark - Web

+ (void)pushToShowWebVC:(NSString *)urlStr title:(NSString *)title;
+ (void)presentToShowWebVC:(AZWebVC *)webVC;

#pragma mark - Common

+ (void)presentToShowVC:(UIViewController *)vc;
+ (void)presentToShowCommonNavRootVC:(UIViewController *)rootVC;


#pragma mark - Question

+ (void)pushToShowQuestionDetailVC:(AZQuestionWrapper *)questionWrapper;

+ (void)pushToShowQuestionPublishVC;
+ (void)pushToShowQuestionPublishFinishVC:(AZQuestionWrapper *)questionWrapper;


#pragma mark - User

+ (void)pushToShowUserVC;
+ (void)pushToShowUserQuestionVC;

#pragma mark - Register

+ (void)presentToShowRegisterVC;


#pragma mark - AZCommonPhotoShowVC

+ (void)pushToShowCommonPhotoShowVC:(AZCommonPhotoShowVC *)photoShowVC;
+ (void)presentToShowCommonPhotoShowVC:(NSInteger)index imageModelArr:(NSArray *)imageModelArr;
+ (void)presentToShowCommonPhotoShowVC:(NSInteger)index imageArr:(NSArray *)imageArr;
+ (void)presentToShowCommonPhotoShowVC:(NSInteger)index imageUrlArr:(NSArray *)imageUrlArr imageThumbUrlArr:(NSArray *)imageThumbUrlArr;
+ (NSArray *)getImageModelArrFromImageUrlArr:(NSArray *)imageUrlArr imageThumbUrlArr:(NSArray *)imageThumbUrlArr;


@end
