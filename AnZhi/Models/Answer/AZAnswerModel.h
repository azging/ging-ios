//
//  AZAnswerModel.h
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZBaseModel.h"

typedef enum : NSInteger {
    AZAnswerStatus_Default      = 0,    // 0 普通回答
    AZAnswerStatus_Adopt        = 1,    // 1 选中回答
    AZAnswerStatus_AdoptPay     = 2,    // 2 选中的回答，且已支付
} AZAnswerStatus;

@interface AZAnswerModel : AZBaseModel

@property (copy, nonatomic) NSString *auid;
@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) NSInteger type;       // 0 为文字回答
@property (assign, nonatomic) AZAnswerStatus status; 
@property (assign, nonatomic) NSInteger payStatus;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;


@end
