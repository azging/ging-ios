//
//  AZQuestionWrapper.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZBaseModel.h"
#import "AZUserWrapper.h"
#import "AZQuestionModel.h"

@interface AZQuestionWrapper : AZBaseModel

@property (strong, nonatomic) AZQuestionModel *questionModel;
@property (strong, nonatomic) AZUserWrapper *createUserWrapper;

@end
