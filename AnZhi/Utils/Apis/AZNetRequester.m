//
//  AZNetRequester.m
//  LinkCity
//
//  Created by 张宗硕 on 8/26/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZNetRequester.h"
#import "AZApiConstant.h"
#import "AZDataManager.h"
#import "AZAppUtil.h"
#import "AZPopViewHelper.h"

@implementation AZNetRequester

+ (void)requestAppConfigInit {
    NSArray *paramsArr = @[];
    
    [[self createInstance] doGet:AZApiUriAppConfigInit params:paramsArr requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (!error) {
            AZConfigInitWrapper *wrapper = [AZConfigInitWrapper modelWithDict:dataDic];
            if (wrapper.isCIDExpired) {
                [AZDataManager sharedInstance].userModel = nil;
            }
            [AZDataManager sharedInstance].configInitWrapper = wrapper;
            if ([wrapper.userModel isValidSelfData]) {
                [AZDataManager sharedInstance].userModel = wrapper.userModel;
            }
            [[AZDataManager sharedInstance] saveData];
        }
    }];
}

+ (void)requestAppConfigSet {
    NSString *clientId = [AZStringUtil getNotNullStr:[AZDataManager sharedInstance].clientId];
    NSString *imei = [AZAppUtil getIMEI];
    NSString *macAddr = [AZAppUtil getMacAddress];
    NSString *screenRes = [AZAppUtil getScreenResolution];
    NSString *cpuType = [AZAppUtil getCPUType];
    NSString *deviceName = [AZAppUtil getDeviceName];
    NSString *deviceModel = [AZAppUtil getDeviceModel];
    NSString *appChannel = [AZAppUtil getAppChannel];
    NSString *appDeviceToken = [AZAppUtil getDeviceToken];
    
    NSDictionary *paramDic = @{@"ClientId":clientId,
                               @"Imei":imei,
                               @"MacAddr":macAddr,
                               @"ScreenRes":screenRes,
                               @"CpuType":cpuType,
                               @"DeviceName":deviceName,
                               @"DeviceModel":deviceModel,
                               @"AppChannel":appChannel,
                               @"DeviceToken":appDeviceToken,
                               };
    [[self createInstance] doPost:AZApiUriAppConfigSet params:paramDic requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (!error) {
            if (![AZDataManager sharedInstance].isAppConfigSetted) {
//                AZCityModel *cityModel = [AZCityModel modelWithDict:dataDic];
//                [AZDataManager sharedInstance].currentCityModel = cityModel;
                [[AZDataManager sharedInstance] saveData];
                [AZDataManager sharedInstance].isAppConfigSetted = YES;
            }
        }
    }];
}

+ (instancetype)createInstance {
    return [[AZNetRequester alloc] init];
}
@end
