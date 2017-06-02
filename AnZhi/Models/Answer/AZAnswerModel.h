//
//  AZAnswerModel.h
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZBaseModel.h"

@interface AZAnswerModel : AZBaseModel


@property (copy, nonatomic) NSString *auid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *desc;
@property (assign, nonatomic) NSInteger isAnonymous;
@property (assign, nonatomic) CGFloat reward;    // 酬金
@property (strong, nonatomic) NSArray *photoUrls;
@property (strong, nonatomic) NSArray *thumbPhotoUrls;
@property (assign, nonatomic) NSInteger answerNum;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) NSInteger payStatus;
@property (copy, nonatomic) NSString *expireTime;
@property (copy, nonatomic) NSString *expireTimeStr;   // 剩余时间
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;


@end
