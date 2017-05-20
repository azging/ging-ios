//
//  AZNetRequester+User.m
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/19.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZNetRequester+User.h"
#import "AZStringUtil.h"
#import "AZApiConstant.h"
#import "AZDataManager.h"

@implementation AZNetRequester (User)

// 发送短信验证码
+ (void)requestUserPhoneAuthcodeSend:(NSString *)tel callBack:(void(^)(NSError *error))callBack {
    tel = [AZStringUtil getNotNullStr:tel];
    NSDictionary *params = @{@"Telephone": tel};
    
    [[self createInstance] doPost:AZApiUriUserPhoneAuthcodeSend params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            callBack(error);
        }
    }];
}


// 获取用户
+ (void)requestUserInfo:(NSString *)uuid callBack:(void(^)(AZUserModel *userModel, NSError *error))callBack {
    uuid = [AZStringUtil getNotNullStr:uuid];
    NSArray *params = @[uuid];
    
    [[self createInstance] doGet:AZApiUriUserInfo params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                if (dataDic) {
                    NSDictionary *userDic = [dataDic dicOfObjectForKey:@"User"];
                    AZUserModel *user = [AZUserModel modelWithDict:userDic];
                    [AZDataManager sharedInstance].userModel = user;
                    callBack(user, error);
                } else {
                    callBack(nil, error);
                }
            }
        }
    }];
}

// 手机号、验证码登录
+ (void)requestUserLoginPhone:(NSString *)tel code:(NSString *)code callBack:(void(^)(AZUserModel *userModel, NSError *error))callBack {
    tel = [AZStringUtil getNotNullStr:tel];
    code = [AZStringUtil getNotNullStr:code];
    NSDictionary *params = @{@"Telephone": tel,
                             @"AuthCode": code,
                             };
    
    [[self createInstance] doPost:AZApiUriUserLogInPhone params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                if (dataDic) {
                    NSDictionary *userDic = [dataDic dicOfObjectForKey:@"User"];
                    AZUserModel *user = [AZUserModel modelWithDict:userDic];
                    [AZDataManager sharedInstance].userModel = user;
                    callBack(user, error);
                } else {
                    callBack(nil, error);
                }
            }
        }
    }];
}

// 第三方登录
+ (void)requestUserLoginThird:(NSString *)thirdId nick:(NSString *)nick avatarUrl:(NSString *)avatarUrl gender:(NSInteger)gender type:(NSInteger)type callBack:(void(^)(AZUserModel *userModel, NSError *error))callBack  {
    thirdId = [AZStringUtil getNotNullStr:thirdId];
    nick = [AZStringUtil getNotNullStr:nick];
    avatarUrl = [AZStringUtil getNotNullStr:avatarUrl];
    
    NSDictionary *params = @{@"ThirdId": thirdId,
                             @"Nick": nick,
                             @"AvatarUrl": avatarUrl,
                             @"Gender": [NSNumber numberWithInteger:gender],
                             @"Type": [NSNumber numberWithInteger:type],
                             };
    
    [[self createInstance] doPost:AZApiUriUserLogInWechat params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                if (dataDic) {
                    NSDictionary *userDic = [dataDic dicOfObjectForKey:@"User"];
                    AZUserModel *user = [AZUserModel modelWithDict:userDic];
                    [AZDataManager sharedInstance].userModel = user;
                    callBack(user, error);
                } else {
                    callBack(nil, error);
                }
            }
        }
    }];
}

// 用户退出登录
+ (void)requestUserLogoutCallBack:(void(^)(NSError *error))callBack {
    [[self createInstance] doPost:AZApiUriUserLogout params:nil requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            callBack(error);
        }
    }];
}



@end
