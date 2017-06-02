//
//  AppDelegate.m
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
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
#import "AZHomeVC.h"

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
    [self initRootVC];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)initRootVC {
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[AZHomeVC createInstance]];
    self.window.backgroundColor = [UIColor whiteColor];
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
    [[UINavigationBar appearance] setBackgroundImage:[AZImageUtil getImageFromColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
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
    
    if ([[url scheme] isEqualToString:AZWechatKey]) {
        [WXApi handleOpenURL:url delegate:self];
    }
}

#pragma mark - WxPay Delegate

- (void)onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
    }
    if ([resp isKindOfClass:[PayResp class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWxPay object:nil userInfo:@{NotificationWxPayResultKey:resp}];
    }
}

@end

