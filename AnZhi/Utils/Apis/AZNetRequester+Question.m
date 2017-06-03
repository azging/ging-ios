//
//  AZNetRequester+Question.m
//  AnZhi
//
//  Created by LHJ on 2017/5/20.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZNetRequester+Question.h"
#import "AZQuestionWrapper.h"
#import "AZAnswerWrapper.h"

@implementation AZNetRequester (Question)

// 发布提问
+ (void)requestQuestionPublish:(NSString *)title desc:(NSString *)desc photoUrlArr:(NSArray *)photoUrlArr reward:(CGFloat)reward isAnonymous:(BOOL)isAnonymous callBack:(void(^)(AZQuestionWrapper *questionWrapper, NSError *error))callBack {
    title = [AZStringUtil getNotNullStr:title];
    desc = [AZStringUtil getNotNullStr:desc];
    NSString *photoUrls = [AZStringUtil getJsonStrFromArr:photoUrlArr];
    
    NSDictionary *params = @{@"Title": title,
                             @"Description": desc,
                             @"QuestionUrls": photoUrls,
                             @"Reward": [NSNumber numberWithDouble:reward],
                             @"IsAnonymous": [NSNumber numberWithBool:isAnonymous],
                             };
    
    
    [[self createInstance] doPost:AZApiUriQuestionPublish params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                AZQuestionWrapper *question = [AZQuestionWrapper modelWithDict:dataDic];
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
//                NSDictionary *questionDic = [dataDic dicOfObjectForKey:@"QuestionWrapper"];
                AZQuestionWrapper *question = [AZQuestionWrapper modelWithDict:dataDic];
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
            if (dataDic) {
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


// 提问回答列表
+ (void)requestQuestionAnswerList:(NSString *)quid orderStr:(NSString *)orderStr callBack:(void(^)(NSArray *answerWrapperArr, NSString *orderStr, NSError *error))callBack {
    
    quid = [AZStringUtil getNotNullStr:quid];
    orderStr = [AZStringUtil getNotNullStr:orderStr];
    NSDictionary *params = @{@"OrderStr":orderStr,
                             @"Quid":quid,
                             };

    
    [[self createInstance] doPost:AZApiUriQuestionAnswerList params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                NSArray *answerJsonArr = [dataDic objectForKey:@"AnswerWrapperList"];
                NSString *orderStr = [dataDic objectForKey:@"OrderStr"];
                
                NSMutableArray *mutArr = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in answerJsonArr) {
                    AZAnswerWrapper *answerWrapper = [AZAnswerWrapper modelWithDict:dic];
                    if ([answerWrapper isValidData]) {
                        [mutArr addObject:answerWrapper];
                    }
                }
                
                callBack(mutArr, orderStr, error);
            } else {
                callBack(nil, @"", error);
            }
        }
    }];
}

// 添加回答
+ (void)requestQuestionAnswerAdd:(NSString *)quid content:(NSString *)content callBack:(void(^)(AZAnswerWrapper *answerWrapper, NSError *error))callBack {
    quid = [AZStringUtil getNotNullStr:quid];
    content = [AZStringUtil getNotNullStr:content];
    NSDictionary *params = @{@"Quid": quid,
                             @"Content": content,
                             @"Type": [NSNumber numberWithInteger:0],  // 0为文字回答
                             };

    [[self createInstance] doPost:AZApiUriQuestionAnswerAdd params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (dataDic) {
                NSDictionary *questionDic = [dataDic dicOfObjectForKey:@"AnswerWrapper"];
                AZAnswerWrapper *answerWrapper = [AZAnswerWrapper modelWithDict:questionDic];
                callBack(answerWrapper, error);
            } else {
                callBack(nil, error);
            }
        }
    }];
}

// 挑选满意回答 
+ (void)requestQuestionAnswerAdopt:(NSString *)quid auid:(NSString *)auid callBack:(void(^)(NSError *error))callBack {
    quid = [AZStringUtil getNotNullStr:quid];
    auid = [AZStringUtil getNotNullStr:auid];
    NSDictionary *params = @{@"Quid": quid,
                             @"Auid": auid,
                             };
    
    [[self createInstance] doPost:AZApiUriQuestionAnswerAdopt params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            callBack(error);
        }
    }];
}



@end
