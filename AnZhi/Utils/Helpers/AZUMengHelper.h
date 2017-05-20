//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <UMSocialCore/UMSocialCore.h>

static NSString * const AZUMengWechatKey = @"wx18a5f802e5e464e0";

@interface AZUMengHelper : NSObject

// 获取友盟单例
+ (instancetype)sharedInstance;
// 启动友盟统计
- (void)startStatistic;
// 初始化友盟社交分享
- (void)initUMengSocialSDK;

@end
