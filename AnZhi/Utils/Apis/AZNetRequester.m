//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZNetRequester.h"
#import "AZDataManager.h"
#import "AZAppUtil.h"
#import "AZConfigInitWrapper.h"

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


// 获取七牛Token
+ (void)getQiniuUploadTokenOfFileType:(NSString *)fileType callBack:(void(^)(NSString *uploadToken, NSString *picKey, NSError *error))callBack {
    fileType = [AZStringUtil getNotNullStr:fileType];
    NSDictionary *paramDic = @{@"Type" : fileType};
    [[self createInstance] doPost:AZApiUriGetQINIUUploadToken params:paramDic requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic && !error) {
                NSString *uploadToken = [dataDic objectForKey:@"UpToken"];
                NSString *picKey = [dataDic objectForKey:@"PhotoKey"];
                callBack(uploadToken, picKey, error);
            } else {
                callBack(nil,nil,error);
            }
        }
    }];
}

// 意见反馈
+ (void)requestAppFeedBackAdd:(NSString *)content callBack:(void(^)(NSError *error))callBack {
    content = [AZStringUtil getNotNullStr:content];
    
    NSDictionary *paramDic = @{@"Content":content,
                               };
    [[self createInstance] doPost:AZApiUriAppFeedbackAdd params:paramDic requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            callBack(error);
        }
    }];
}

+ (instancetype)createInstance {
    return [[AZNetRequester alloc] init];
}
@end
