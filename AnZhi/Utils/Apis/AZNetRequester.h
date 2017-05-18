//
//  AZNetRequester.h
//  LinkCity
//
//  Created by 张宗硕 on 8/26/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZHttpApi.h"
#import "AZAuthCode.h"
#import "AZUserModel.h"
#import "AZConfigInitWrapper.h"

typedef enum {
    AZNetRequesterActivOrderType_Default        = 0,
    AZNetRequesterActivOrderType_Distance       = 1,
    AZNetRequesterActivOrderType_PublishTime    = 2,
    AZNetRequesterActivOrderType_Price          = 3,
} AZNetRequesterActivOrderType;

typedef enum {
    AZNetRequesterAppSearchThemeActivType_Default   = 0,
    AZNetRequesterAppSearchThemeActivType_Home      = 1,
    AZNetRequesterAppSearchThemeActivType_Local     = 2,
} AZNetRequesterAppSearchThemeActivType;

@interface AZNetRequester : AZHttpApi

+ (instancetype)createInstance;

+ (void)requestAppConfigInit;
+ (void)requestAppConfigSet;
+ (void)requestAppSearchThemeActiv:(AZNetRequesterAppSearchThemeActivType)type
                           themeId:(NSInteger)themeId
                           dateArr:(NSArray *)dateArr
                          priceArr:(NSArray *)priceArr
                         orderType:(AZNetRequesterActivOrderType)orderType
                          orderStr:(NSString *)orderStr
                      callBack:(void(^)(NSArray *activWrapperArr, NSString *orderStr, NSError *error))callBack;
+ (void)requestPlaceBusinessArea;
+ (void)requestAppRedDot;
+ (void)requestAppRedDotWithCallBack:(void(^)(NSError *error))callBack;
+ (void)requestAppBannerActivList:(NSInteger)type content:(NSString *)content orderStr:(NSString *)orderStr callBack:(void(^)(NSArray *activWrapperArr, NSString *orderStr, NSError *error))callBack;
+ (void)sendAuthCodeToTelephoneForRegister:(NSString *)phone callBack:(void(^)(AZAuthCode *, NSError *))callBack;
+ (void)sendAuthCodeToTelephoneForResetPassword:(NSString *)phone callBack:(void(^)(AZAuthCode *authCode, NSError *error))callBack;
+ (void)verifyAuthCodeWithTelephone:(NSString *)phone authCode:(NSString *)authCode callBack:(void(^)(NSError *error))callBack;

+ (void)requestEvalateDuckrApp;

@end
