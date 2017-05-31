//
//  AZNetRequester+Question.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/20.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZNetRequester.h"
#import "AZConstant.h"

@class AZQuestionWrapper;

@interface AZNetRequester (Question)


// 发布提问
+ (void)requestQuestionPublish:(NSString *)title desc:(NSString *)desc photoUrlArr:(NSArray *)photoUrlArr reward:(CGFloat)reward isAnonymous:(BOOL)isAnonymous callBack:(void(^)(AZQuestionWrapper *questionWrapper, NSError *error))callBack;

// 提问详情
+ (void)requestQuestionDetail:(NSString *)quid callBack:(void(^)(AZQuestionWrapper *questionWrapper, NSError *error))callBack;


// 首页提问列表
+ (void)requestQuestionList:(AZHomeVCTabType)type orderStr:(NSString *)orderStr callBack:(void(^)(NSArray *questionWrapperArr, NSString *orderStr, NSError *error))callBack;

@end
