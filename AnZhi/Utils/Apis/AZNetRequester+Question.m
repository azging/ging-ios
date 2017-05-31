//
//  AZNetRequester+Question.m
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/20.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZNetRequester+Question.h"
#import "AZQuestionWrapper.h"

@implementation AZNetRequester (Question)

// 发布提问
+ (void)requestQuestionPublish:(NSString *)title desc:(NSString *)desc photoUrlArr:(NSArray *)photoUrlArr reward:(CGFloat)reward isAnonymous:(BOOL)isAnonymous callBack:(void(^)(AZQuestionWrapper *questionWrapper, NSError *error))callBack {
    title = [AZStringUtil getNotNullStr:title];
    desc = [AZStringUtil getNotNullStr:desc];
    NSString *photoUrls = [AZStringUtil getJsonStrFromArr:photoUrlArr];
    
    NSDictionary *params = @{@"Title": title,
                             @"Description": desc,
                             @"QuestionUrls": photoUrls,
                             @"Reward": [NSNumber numberWithFloat:reward],
                             @"IsAnonymous": [NSNumber numberWithBool:isAnonymous],
                             };
    
    
    [[self createInstance] doPost:AZApiUriQuestionPublish params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                NSDictionary *questionDic = [dataDic dicOfObjectForKey:@"QuestionWrapper"];
                AZQuestionWrapper *question = [AZQuestionWrapper modelWithDict:questionDic];
                callBack(question, error);
            } else {
                callBack(nil, error);
            }
        }
    }];
    
    
}

// 提问详情
+ (void)requestQuestionDetail:(NSString *)quid callBack:(void(^)(AZQuestionWrapper *questionWrapper, NSError *error))callBack {
    quid = [AZStringUtil getNotNullStr:quid];
    NSArray *params = @[quid];
    
    [[self createInstance] doGet:AZApiUriQuestionDetail params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                NSDictionary *questionDic = [dataDic dicOfObjectForKey:@"QuestionWrapper"];
                AZQuestionWrapper *question = [AZQuestionWrapper modelWithDict:questionDic];
                callBack(question, error);
            } else {
                callBack(nil, error);
            }
        }
    }];
}


// 首页提问列表
+ (void)requestQuestionList:(AZHomeVCTabType)type orderStr:(NSString *)orderStr callBack:(void(^)(NSArray *questionWrapperArr, NSString *orderStr, NSError *error))callBack {
    orderStr = [AZStringUtil getNotNullStr:orderStr];
    NSDictionary *params = @{@"OrderStr":orderStr};
    
    NSString *uriStr = AZApiUriQuestionListNearby;
    switch (type) {
        case AZHomeVCTabType_Nearby:
            uriStr = AZApiUriQuestionListNearby;
            break;
        case AZHomeVCTabType_News:
            uriStr = AZApiUriQuestionListNews;
            break;
        case AZHomeVCTabType_Hot:
            uriStr = AZApiUriQuestionListHot;
            break;
        default:
            break;
    }
    
    [[self createInstance] doPost:uriStr params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
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
