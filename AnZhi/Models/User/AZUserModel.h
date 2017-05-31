//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZConstant.h"

@interface AZUserModel : AZBaseModel

- (BOOL)isValidSelfData;
- (BOOL)isMySelf;

@property (copy, nonatomic) NSString *uuid;
@property (copy, nonatomic) NSString *cid;

@property (assign, nonatomic) NSInteger loginType;
@property (copy, nonatomic) NSString *wechatId;

@property (copy, nonatomic) NSString *nick;
@property (copy, nonatomic) NSString *avatarUrl;
@property (copy, nonatomic) NSString *thumbAvatarUrl;
@property (assign, nonatomic) NSInteger gender;
@property (copy, nonatomic) NSString *telephone;


@property (assign, nonatomic) NSInteger liveCityId;
@property (copy, nonatomic) NSString *liveCityName;

@property (assign, nonatomic) NSInteger type;

@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;

@end
