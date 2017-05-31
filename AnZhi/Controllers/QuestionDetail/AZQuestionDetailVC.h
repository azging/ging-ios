//
//  AZQuestionDetailVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAutoRefreshVC.h"

@class AZQuestionWrapper;

@interface AZQuestionDetailVC : AZAutoRefreshVC

@property (strong, nonatomic) AZQuestionWrapper *questionWrapper;
@end
