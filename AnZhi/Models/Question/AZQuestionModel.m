//
//  AZQuestionModel.m
//  AnZhi
//
//  Created by LHJ on 2017/5/22.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionModel.h"

@implementation AZQuestionModel

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
             @"shareImageUrl":@"ShareUrl",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             @"":@"",
             };
}

@end
