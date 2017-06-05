//
//  AZQuestionModel.h
//  AnZhi
//
//  Created by LHJ on 2017/5/22.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZBaseModel.h"

typedef enum : NSInteger {

    AZQuestionStatus_DEFAULT                        = 0,
    AZQuestionStatus_UNPAID                         = 1,
    AZQuestionStatus_ANSWERING                      = 2,
    AZQuestionStatus_EXPIRED_NO_ANSWER              = 3,
    AZQuestionStatus_EXPIRED_NO_ANSWER_REFUNDED     = 4,
    AZQuestionStatus_EXPIRED_UNADOPTED              = 5,
    AZQuestionStatus_EXPIRED_UNADOPTED_PAID_FIRST   = 6,
    AZQuestionStatus_ADOPTED                        = 7,
    AZQuestionStatus_ADOPTED_PAID_BEST              = 8,
} AZQuestionStatus;

@interface AZQuestionModel : AZBaseModel


@property (copy, nonatomic) NSString *quid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *desc;
@property (assign, nonatomic) NSInteger isAnonymous;
@property (assign, nonatomic) CGFloat reward;    // 酬金
@property (strong, nonatomic) NSArray *photoUrls;
@property (strong, nonatomic) NSArray *thumbPhotoUrls;
@property (assign, nonatomic) NSInteger answerNum;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) AZQuestionStatus status;
@property (assign, nonatomic) NSInteger payStatus;
@property (copy, nonatomic) NSString *expireTime;
@property (copy, nonatomic) NSString *expireTimeStr;   // 剩余时间
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;

@property (copy, nonatomic) NSString *shareImageUrl; // 悬赏令url

@end
