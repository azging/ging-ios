//
//  AppDelegate.m
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//


#import "AppDelegate.h"
#import "AZUMengHelper.h"
#import "WXApi.h"
#import "AZDataManager.h"
#import "AZAMapManager.h"
#import "AZNetRequester.h"
#import "IQKeyboardManager.h"
#import "AZUtil.h"

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AZDataManager sharedInstance] readData];
    [self allHelperSetUp];
    [self allRequest];
    [self allInit];
    return YES;
}

- (void)allHelperSetUp {
    [[AZUMengHelper sharedInstance] startStatistic];
    [[AZUMengHelper sharedInstance] initUMengSocialSDK];
    [[AZAMapManager sharedInstance] startAMap];
    [AZ3DTouchUtil setUp3DTouchItem];
}

- (void)allRequest {
    [self requestAppConfigInit];
    [self requestAppConfigSet];
}

- (void)allInit {
    [self initCommonUI];
    [self initIQKeyboardManager];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [self handleApplicationOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [self handleApplicationOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [self handleApplicationOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler {
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
}

- (void)dealloc {
    [[AZDataManager sharedInstance] saveData];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[AZDataManager sharedInstance] saveData];
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillResignActiveNotification object:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[AZDataManager sharedInstance] saveData];
    [AZAlertUtil hideAlert];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    [[AZAMapManager sharedInstance] startUpdateUserLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[AZDataManager sharedInstance] saveData];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken {
    NSString *token = [[pToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [AZDataManager sharedInstance].deviceToken = deviceToken;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}

- (void)initIQKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enableAutoToolbar = NO;
}


#pragma mark - Private Func

- (void)initCommonUI {
    [self initNavAppearance];
    [self initTabBarAppearance];
    [self initRootVC];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)initRootVC {

}

- (void)initNavAppearance {
    UIColor *tintColor = [AZColorUtil getColor:AZColorNaviFontDefault];
    UIFont *font = [UIFont fontWithName:AZFontNameDefault size:AZFontSizeDefault];
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setTintColor:tintColor];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:tintColor, NSForegroundColorAttributeName, font, NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:AZImageNameNaviBarBackIcon]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:AZImageNameNaviBarBackIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[AZImageUtil getImageFromColor:[AZColorUtil getColor:AZColorAppDuckr]] forBarMetrics:UIBarMetricsDefault];
}

- (void)initTabBarAppearance {
    UIColor *tintColor = [AZColorUtil getColor:AZColorTabBarTint];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:tintColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[AZColorUtil getColor:AZColorTabBarDefault]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[AZColorUtil getColor:AZColorTabBarTint]} forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundImage:[[[UIImage imageNamed:AZImageNameNaviBarOpaque] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)]];
}

- (void)requestAppConfigInit {
    [AZNetRequester requestAppConfigInit];
}

- (void)requestAppConfigSet {
    [AZNetRequester requestAppConfigSet];
}

- (void)handleApplicationOpenURL:(NSURL *)url {
    //2017.3.31测试通过，不再崩溃
    [[UMSocialManager defaultManager] handleOpenURL:url];
    
    if ([[url scheme] isEqualToString:AZUMengWechatKey]) {
        [WXApi handleOpenURL:url delegate:self];
    }
}

#pragma mark - WxPay Delegate

-(void)onResp:(BaseResp*)resp {
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if ([resp isKindOfClass:[PayResp class]]) {
        // 支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                //                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode, resp.errStr];
                //                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode, resp.errStr);
                break;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWxPay object:nil userInfo:@{NotificationWxPayResultKey:resp}];
    }
}

@end

