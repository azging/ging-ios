//
//  AZQuestionModel.m
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/22.
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
             @"cityId":@"CityId",
             @"status":@"Status",
             @"payStatus":@"PayStatus",
             @"expireTime":@"ExpireTime",
             @"createTime":@"CreateTime",
             @"updateTime":@"UpdateTime",
//             @"":@"",
//             @"":@"",
//             @"":@"",
//             @"":@"",
             };
}
@end
