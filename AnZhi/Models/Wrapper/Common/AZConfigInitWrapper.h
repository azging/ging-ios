//
//  AZConfigInitWrapper.h
//  LinkCity
//
//  Created by 张宗硕 on 11/10/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZUserModel.h"

@interface AZConfigInitWrapper : AZBaseModel

@property (assign, nonatomic) NSInteger isCIDExpired;
@property (strong, nonatomic) AZUserModel *userModel;

@end
