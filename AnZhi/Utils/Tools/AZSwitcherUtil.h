//
//  AZSwitcherUtil.h
//  LinkCity
//
//  Created by 张宗硕 on 9/12/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZWebVC.h"

@interface AZSwitcherUtil : NSObject

#pragma mark - Web

+ (void)pushToShowWebVC:(NSString *)urlStr title:(NSString *)title;
+ (void)presentToShowWebVC:(AZWebVC *)webVC;

#pragma mark - Common

+ (void)presentToShowVC:(UIViewController *)vc;
+ (void)presentToShowCommonNavRootVC:(UIViewController *)rootVC;


@end
