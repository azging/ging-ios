//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAppUtil.h"
#import <AdSupport/ASIdentifierManager.h> 
#import "AZUserModel.h"
#import "AZConstant.h"
#import "sys/sysctl.h"
#import "AZDataManager.h"
#import "AZNetRequester.h"

@implementation AZAppUtil


#pragma mark - Public Func

// 获取App的发布版本
+ (NSString *)getAppLocalShortVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

// 获取AppDelegate对象
+ (AppDelegate *)getAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

// 获取屏幕的高度
+ (CGFloat)getDeviceHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

// 获取屏幕的宽度
+ (CGFloat)getDeviceWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

// 获取最顶端导航控制器
+ (UINavigationController *)getTopMostNavigationController {
    UIViewController *vc = [AZAppUtil getTopMostViewController];
    if (nil != vc) {
        return vc.navigationController;
    }
    return nil;
}

// 获取最顶端的视图控制器
+ (UIViewController *)getTopMostViewController {
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [AZAppUtil topViewControllerWithRootViewController:rootViewController];
}

// 获取广告的唯一标示
+ (NSString *)getIdfa {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getDevicePlatform {
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return platform;
}

+ (NSString *)getIMEI {
    return @"";
}

+ (NSString *)getMacAddress {
    return @"";
}

+ (NSString *)getCPUType {
    return @"";
}

+ (NSString *)getDeviceName {
    UIDevice *device = [UIDevice currentDevice];
    return device.name;
}

+ (NSString *)getScreenResolution {
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSString *str = [NSString stringWithFormat:@"%fx%f", [AZAppUtil getDeviceWidth] * scale_screen, [AZAppUtil getDeviceHeight] * scale_screen];
    return str;
}

+ (NSString *)getDeviceModel {
    UIDevice *device = [UIDevice currentDevice];
    return device.model;
}

+ (NSString *)getAppChannel {
    return @"App Store";
}

+ (NSString *)getDeviceToken {
    return [AZStringUtil getNotNullStr:[AZDataManager sharedInstance].deviceToken];
}

+ (CGFloat)getDeviceSystemVersion {
    return [[UIDevice currentDevice].systemVersion floatValue];
}

#pragma mark - Private Func

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (void)jumpAppDownloadPage {
    NSURL *appStoreUrl = [NSURL URLWithString:AZConstantAppDownloadUrl];
    if ([[UIApplication sharedApplication] canOpenURL:appStoreUrl]) {
        [[UIApplication sharedApplication] openURL:appStoreUrl];
    }
}

+ (CGFloat)getLabelHeight:(NSString *)str labelWidth:(float)width font:(UIFont *)font {
    if ([AZStringUtil isNullString:str]) {
        return 0.0f;
    }
    CGSize size = [AZAppUtil getLabelSize:str labelWidth:width height:1000.0f font:font];
    return size.height;
}

+ (CGFloat)getLabelWidth:(NSString *)str labelHeight:(float)height font:(UIFont *)font {
    CGSize size = [AZAppUtil getLabelSize:str labelWidth:375.0f height:height font:font];
    return size.width;
}

+ (CGSize)getLabelSize:(NSString *)str labelWidth:(float)width height:(float)height font:(UIFont *)font {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil];
    return rect.size;
}

+ (BOOL)isIPhone4Or4S {
    if (AZDeviceHeight4Or4S == [self getDeviceHeight]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone5Or5S {
    if (AZDeviceHeight5Or5S == [self getDeviceHeight]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone6Or6SOr7 {
    if (AZDeviceHeight6Or6SOr7 == [self getDeviceHeight]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone6POr6PSOr7P {
    if (AZDeviceHeight6POr6PSOr7P == [self getDeviceHeight]) {
        return YES;
    }
    return NO;
}

@end
