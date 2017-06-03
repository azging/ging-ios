//
//  AZAnswerWrapper.h
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZBaseModel.h"
#import "AZAnswerModel.h"
#import "AZUserWrapper.h"

@interface AZAnswerWrapper : AZBaseModel

@property (strong, nonatomic) AZAnswerModel *answerModel;
@property (strong, nonatomic) AZUserWrapper *createUserWrapper;

@property (assign, nonatomic) BOOL showMoreContent;  // 回答cell 是否展开content，在此记录
@end
