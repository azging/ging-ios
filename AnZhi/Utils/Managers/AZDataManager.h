//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import "AZUserModel.h"
#import "AZConfigInitWrapper.h"


@interface AZDataManager : NSObject

// 获取数据管理器实例
+ (instancetype)sharedInstance;
// 读取所有缓存数据
- (void)readData;
// 存储所有需要缓存的数据
- (void)saveData;
// 判断用户是否登录
- (BOOL)isUserLogin;
- (void)clearUserDefaultForLogout;


- (void)addUnreadNumForBareJidStr:(NSString *)bareJidStr;
- (void)clearUnreadNumForBareJidStr:(NSString *)bareJidStr;
- (NSInteger)getUnreadNumForBareJidStr:(NSString *)bareJidStr;
- (NSInteger)getUnreadNumSum;
- (void)clearUnreadNumForAll;

#pragma mark - User Related Info

// App初始化数据
// 网络状态，不负责保存
@property (assign, nonatomic) NSInteger netWorkingStatus;
// 当前登录用户信息，未登录时为空
@property (strong, nonatomic) AZUserModel *userModel;
    
@property (strong, nonatomic) AZConfigInitWrapper *configInitWrapper;

// 每次打开APP，requestAppConfigSet只更新一次数据，不负责保存
@property (assign, nonatomic) BOOL isAppConfigSetted;


// 当前自动定位的位置
@property (strong, nonatomic) CLLocation *userLocation;
// 是否提示过当前定位地点
@property (assign, nonatomic) BOOL isAlertLocationCity;
// 是否第一次打开App，用于判断是否显示注册登录页面
@property (assign, nonatomic) BOOL isFirstTimeOpenApp;


// 是否使用线上服务器
@property (assign, nonatomic) BOOL isReleaseServer;

#pragma mark Device Related Info
// 用于个推客户端推送的ID
@property (strong, nonatomic) NSString *clientId;
// 设备唯一标志  在这里不负责保存，而是在app初始化时，通过keychain存取
@property (strong, nonatomic) NSString *deviceUuid;
// 设备推送devicetoken
@property (strong, nonatomic) NSString *deviceToken;


@end
