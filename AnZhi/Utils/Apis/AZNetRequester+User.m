//
//  AZNetRequester+User.m
//  AnZhi
//
//  Created by LHJ on 2017/5/19.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZNetRequester+User.h"
#import "AZDataManager.h"
#import "AZUserModel.h"
#import "AZQuestionWrapper.h"

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
                NSDictionary *userDic = [dataDic dicOfObjectForKey:@"User"];
                AZUserModel *user = [AZUserModel modelWithDict:userDic];
                callBack(user, error);
            } else {
                callBack(nil, error);
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
                NSDictionary *userDic = [dataDic dicOfObjectForKey:@"User"];
                AZUserModel *user = [AZUserModel modelWithDict:userDic];
                [AZDataManager sharedInstance].userModel = user;
                callBack(user, error);
            } else {
                callBack(nil, error);
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
                NSDictionary *userDic = [dataDic dicOfObjectForKey:@"User"];
                AZUserModel *user = [AZUserModel modelWithDict:userDic];
                [AZDataManager sharedInstance].userModel = user;
                callBack(user, error);
            } else {
                callBack(nil, error);
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

// 更新用户信息
+ (void)requestUpdateUserInfo:(AZUserModel *)userModel callBack:(void(^)(AZUserModel *userModel, NSError *error))callBack {
    NSString *nick          = [AZStringUtil getNotNullStr:userModel.nick];
    NSNumber *gender        = [NSNumber numberWithInteger:userModel.gender];
    NSString *avatarUrl     = [AZStringUtil getNotNullStr:userModel.avatarUrl];

    NSDictionary *paramDic = @{@"Nick":nick,
                               @"Gender":gender,
                               @"AvatarUrl":avatarUrl,
                               
                               };
    [[self createInstance] doPost:AZApiUriUserInfoUpdate params:paramDic requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (!error) {
                AZUserModel *userModel = [AZUserModel modelWithDict:[dataDic dicOfObjectForKey:@"User"]];
                [AZDataManager sharedInstance].userModel = userModel;
                [[AZDataManager sharedInstance] saveData];
                callBack(userModel, error);
            } else {
                callBack(nil, error);
            }
        }
    }];
}




// 我的提问列表
+ (void)requestUserQuestionList:(AZUserQuestionVCType)type orderStr:(NSString *)orderStr callBack:(void(^)(NSArray *questionWrapperArr, NSString *orderStr, NSError *error))callBack {
    orderStr = [AZStringUtil getNotNullStr:orderStr];
    
    NSDictionary *params = @{@"OrderStr":orderStr,
                             @"StatusType":[NSNumber numberWithInteger:type],
                             };

    [[self createInstance] doPost:AZApiUriUserQuestionList params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (!error) {
                NSArray *questionJsonArr = [dataDic objectForKey:@"QuestionWrapperList"];
                NSString *orderStr = [dataDic objectForKey:@"OrderStr"];
                
                NSMutableArray *mutArr = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in questionJsonArr) {
                    AZQuestionWrapper *questionWrapper = [AZQuestionWrapper modelWithDict:dic];
                    if ([questionWrapper isValidData]) {
                        [mutArr addObject:questionWrapper];
                    }
                }
                
                callBack(mutArr, orderStr, error);
            } else {
                callBack(nil, @"", error);
            }
        }
    }];
}


// 我的回答列表
+ (void)requestUserAnswerList:(AZUserAnswerVCType)type orderStr:(NSString *)orderStr callBack:(void(^)(NSArray *questionWrapperArr, NSString *orderStr, NSError *error))callBack {
    orderStr = [AZStringUtil getNotNullStr:orderStr];
    
    NSDictionary *params = @{@"OrderStr":orderStr,
                             @"StatusType":[NSNumber numberWithInteger:type],
                             };
    
    [[self createInstance] doPost:AZApiUriUserAnswerList params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (!error) {
                NSArray *questionJsonArr = [dataDic objectForKey:@"QuestionWrapperList"];
                NSString *orderStr = [dataDic objectForKey:@"OrderStr"];
                
                NSMutableArray *mutArr = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in questionJsonArr) {
                    AZQuestionWrapper *questionWrapper = [AZQuestionWrapper modelWithDict:dic];
                    if ([questionWrapper isValidData]) {
                        [mutArr addObject:questionWrapper];
                    }
                }
                
                callBack(mutArr, orderStr, error);
            } else {
                callBack(nil, @"", error);
            }
        }
    }];
}

@end
