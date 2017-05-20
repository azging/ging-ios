//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZUserModel.h"

@interface AZConfigInitWrapper : AZBaseModel

@property (assign, nonatomic) NSInteger isCIDExpired;
@property (strong, nonatomic) AZUserModel *userModel;

@end
