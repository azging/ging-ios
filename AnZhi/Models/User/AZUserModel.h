//
//  AppDelegate.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZConstant.h"

//实名验证状态
typedef enum : NSUInteger {
    AZIdentityStatus_None       = 0,
    AZIdentityStatus_Done       = 1,
    AZIdentityStatus_Failed     = 2,
    AZIdentityStatus_Verifying  = 3,
} AZIdentityStatus;

typedef enum : NSUInteger {
    AZUserModelType_Default         = 0,
    AZUserModelType_Common          = 1,
    AZUserModelType_AdminMain       = 2,
    AZUserModelType_AdminSub        = 3,
    AZUserModelType_DuckrSide       = 4,
    AZUserModelType_TravelAgency    = 5,
    AZUserModelType_LocalService    = 6,
    AZUserModelType_TravelLeader    = 7,
} AZUserModelType;

@interface AZUserModel : AZBaseModel

- (NSString *)getUserAgeStr;
- (NSString *)getStatureStr;
- (NSString *)getIndustryDutyStr;
- (BOOL)isMerchant;
- (BOOL)isValidSelfData;
- (BOOL)isMySelf;

@property (copy, nonatomic) NSString *uuid;
@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *telephone;
@property (copy, nonatomic) NSString *chatAccount;
@property (copy, nonatomic) NSString *chatPassword;
@property (copy, nonatomic) NSString *nick;
@property (copy, nonatomic) NSString *avatarUrl;
@property (copy, nonatomic) NSString *thumbAvatarUrl;
@property (assign, nonatomic) NSInteger gender;
@property (copy, nonatomic) NSString *birthday;
@property (assign, nonatomic) NSInteger age;
@property (copy, nonatomic) NSString *constellation;
@property (assign, nonatomic) NSInteger stature;
@property (assign, nonatomic) NSInteger liveCityId;
@property (copy, nonatomic) NSString *liveCityName;
@property (copy, nonatomic) NSString *school;
@property (copy, nonatomic) NSString *industry;
@property (copy, nonatomic) NSString *duty;
@property (copy, nonatomic) NSString *salary;
@property (copy, nonatomic) NSString *hobby;
@property (copy, nonatomic) NSString *signature;
@property (assign, nonatomic) NSInteger coins;
@property (assign, nonatomic) NSInteger isNameAuth;
@property (assign, nonatomic) AZUserModelType type;
@property (assign, nonatomic) NSInteger recentVisitNum;
@property (copy, nonatomic) NSString *deviceUuid;
@property (assign, nonatomic) NSInteger orderNum;
@property (assign, nonatomic) NSInteger ticketNum;
@property (assign, nonatomic) NSInteger activNum;
@property (assign, nonatomic) NSInteger photoNum;
@property (assign, nonatomic) NSInteger inviteNum;
@property (assign, nonatomic) NSInteger focusNum;
@property (assign, nonatomic) NSInteger fansNum;
@property (copy, nonatomic) NSString *loginTime;
@property (assign, nonatomic) NSInteger isValid;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;
@property (copy, nonatomic) NSString *publishTime;

@end
