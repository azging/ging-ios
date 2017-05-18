//
//  AppDelegate.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserModel.h"
#import "AZDateUtil.h"
#import "AZDataManager.h"

@implementation AZUserModel

+ (NSDictionary *)modeAZustomPropertyMapper {
    return @{@"uuid":@"Uuid",
             @"cid":@"Cid",
             @"telephone":@"Telephone",
             @"chatAccount":@"ChatAccount",
             @"chatPassword":@"ChatPassword",
             @"nick":@"Nick",
             @"avatarUrl":@"AvatarUrl",
             @"thumbAvatarUrl":@"ThumbAvatarUrl",
             @"gender":@"Gender",
             @"birthday":@"Birthday",
             @"age":@"Age",
             @"constellation":@"Constellation",
             @"stature":@"Stature",
             @"liveCityId":@"LiveCityId",
             @"liveCityName":@"LiveCityName",
             @"school":@"School",
             @"industry":@"Industry",
             @"duty":@"Duty",
             @"salary":@"Salary",
             @"hobby":@"Hobby",
             @"signature":@"Signature",
             @"coins":@"Coins",
             @"isNameAuth":@"IsNameAuth",
             @"type":@"Type",
             @"recentVisitNum":@"RecentVisitNum",
             @"deviceUuid":@"DeviceUuid",
             @"ticketNum":@"TicketNum",
             @"activNum":@"ActivNum",
             @"photoNum":@"PhotoNum",
             @"inviteNum":@"InviteNum",
             @"focusNum":@"FocusNum",
             @"fansNum":@"FansNum",
             @"createTime":@"CreateTime",
             @"updateTime":@"UpdateTime",
             @"publishTime":@"PublishTime",};
}

- (NSString *)getUserAgeStr {
    if (self.age <= 0 || self.age >= 100) {
        return @"—";
    } else {
        return [NSString stringWithFormat:@"%zd", self.age];
    }
}

- (NSString *)getStatureStr {
    if (self.stature <= 0 || self.stature >= 300) {
        return @"未填写";
    }
    return [NSString stringWithFormat:@"%zdcm", self.stature];
}

- (BOOL)isValidSelfData {
    if ([AZStringUtil isNullString:self.cid] || [AZStringUtil isNullString:self.uuid]) {
        return NO;
    }
    return YES;
}

- (BOOL)isMySelf {
    AZUserModel *userModel = [AZDataManager sharedInstance].userModel;
    if ([self.uuid isEqualToString:userModel.uuid]) {
        return YES;
    }
    return NO;
}

- (BOOL)isMerchant {
    if (AZUserModelType_TravelAgency == self.type || AZUserModelType_LocalService == self.type || AZUserModelType_TravelLeader == self.type) {
        return YES;
    }
    return NO;
}

- (NSString *)getIndustryDutyStr {
    NSString *industryDuty = [AZStringUtil getNotNullStr:self.industry];
    if ([AZStringUtil isNotNullString:self.duty]) {
        if ([AZStringUtil isNotNullString:self.industry]) {
            industryDuty = [NSString stringWithFormat:@"%@·%@", self.industry, self.duty];
        } else {
            industryDuty = self.duty;
        }
    }
    return industryDuty;
}

@end
