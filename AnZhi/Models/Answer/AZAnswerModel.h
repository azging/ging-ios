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
@property (assign, nonatomic) NSString *content;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) NSInteger payStatus;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;


@end
