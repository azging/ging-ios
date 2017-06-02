//
//  AZAnswerModel.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAnswerModel.h"

@implementation AZAnswerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"quid":@"Quid",
             @"title":@"Title",
             @"desc":@"Description",
             @"isAnonymous":@"IsAnonymous",
             @"reward":@"Reward",
             @"photoUrls":@"PhotoUrls",
             @"thumbPhotoUrls":@"ThumbPhotoUrls",
             @"answerNum":@"AnswerNum",
             @"cityId":@"CityId",
             @"status":@"Status",
             @"payStatus":@"PayStatus",
             @"expireTime":@"ExpireTime",
             @"expireTimeStr":@"ExpireTimeStr",
             @"createTime":@"CreateTime",
             @"updateTime":@"UpdateTime",
             //             @"":@"",
             //             @"":@"",
             //             @"":@"",
             //             @"":@"",
             };
}

@end
