//
//  AZQuestionWrapper.m
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionWrapper.h"

@implementation AZQuestionWrapper
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"questionModel":@"Question",
             @"createUserWrapper":@"CreateUserWrapper",
             };
}
@end
