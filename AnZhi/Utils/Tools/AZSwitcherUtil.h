//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
