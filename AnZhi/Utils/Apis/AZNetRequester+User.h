//
//  AZNetRequester+User.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/19.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZNetRequester.h"
@class AZUserModel;


@interface AZNetRequester (User)

// 发送短信验证码
+ (void)requestUserPhoneAuthcodeSend:(NSString *)tel callBack:(void(^)(NSError *error))callBack;

// 获取用户
+ (void)requestUserInfo:(NSString *)uuid callBack:(void(^)(AZUserModel *userModel, NSError *error))callBack;

// 手机号、验证码登录
+ (void)requestUserLoginPhone:(NSString *)tel code:(NSString *)code callBack:(void(^)(AZUserModel *userModel, NSError *error))callBack;

// 第三方登录
+ (void)requestUserLoginThird:(NSString *)thirdId nick:(NSString *)nick avatarUrl:(NSString *)avatarUrl gender:(NSInteger)gender type:(NSInteger)type callBack:(void(^)(AZUserModel *userModel, NSError *error))callBack;

// 用户退出登录
+ (void)requestUserLogoutCallBack:(void(^)(NSError *error))callBack;

@end
