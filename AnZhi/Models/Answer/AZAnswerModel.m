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
    return @{@"auid":@"Auid",
             @"content":@"Content",
             @"type":@"Type",
             @"status":@"Status",
             @"payStatus":@"PayStatus",
             @"createTime":@"CreateTime",
             @"updateTime":@"UpdateTime",
             //             @"":@"",
             //             @"":@"",
             //             @"":@"",
             //             @"":@"",
             };
}

@end
