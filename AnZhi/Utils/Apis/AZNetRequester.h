//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZHttpApi.h"
#import "AZStringUtil.h"
#import "AZApiConstant.h"

@interface AZNetRequester : AZHttpApi

+ (instancetype)createInstance;

+ (void)requestAppConfigInit;
+ (void)requestAppConfigSet;

// 获取七牛Token
+ (void)getQiniuUploadTokenOfFileType:(NSString *)fileType callBack:(void(^)(NSString *uploadToken, NSString *picKey, NSError *error))callBack;

// 意见反馈
+ (void)requestAppFeedBackAdd:(NSString *)content callBack:(void(^)(NSError *error))callBack;

@end
