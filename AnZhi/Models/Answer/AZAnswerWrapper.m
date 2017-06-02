//
//  AZAnswerWrapper.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAnswerWrapper.h"

@implementation AZAnswerWrapper

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"answerModel":@"Answer",
             @"createUserWrapper":@"CreateUserWrapper",
             };
}
@end
