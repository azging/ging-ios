//
//  AZAppUtil.h
//  LinkCity
//
//  Created by 张宗硕 on 8/27/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface AZAppUtil : NSObject

// 获取App的发布版本
+ (NSString *)getAppLocalShortVersion;
// 获取AppDelegate对象
+ (AppDelegate *)getAppDelegate;
// 获取屏幕的高度
+ (CGFloat)getDeviceHeight;
// 获取屏幕的宽度
+ (CGFloat)getDeviceWidth;
// 获取最顶端导航控制器
+ (UINavigationController *)getTopMostNavigationController;
// 获取最顶端的视图控制器
+ (UIViewController *)getTopMostViewController;
// 获取广告的唯一标示
+ (NSString *)getIdfa;
// 跳转到App下载页面
+ (void)jumpAppDownloadPage;

+ (NSString *)getDevicePlatform;
+ (NSString *)getIMEI;
+ (NSString *)getMacAddress;
+ (NSString *)getCPUType;
+ (NSString *)getScreenResolution;
+ (NSString *)getDeviceName;
+ (NSString *)getDeviceModel;
+ (NSString *)getAppChannel;
+ (NSString *)getDeviceToken;
+ (CGFloat)getDeviceSystemVersion;

+ (CGFloat)getLabelHeight:(NSString *)str labelWidth:(float)width font:(UIFont *)font;
+ (CGFloat)getLabelWidth:(NSString *)str labelHeight:(float)height font:(UIFont *)font;

+ (BOOL)isIPhone4Or4S;
+ (BOOL)isIPhone5Or5S;
+ (BOOL)isIPhone6Or6SOr7;
+ (BOOL)isIPhone6POr6PSOr7P;


@end
