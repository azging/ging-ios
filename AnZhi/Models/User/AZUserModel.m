//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserModel.h"
#import "AZDateUtil.h"
#import "AZDataManager.h"

@implementation AZUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uuid":@"Uuid",
             @"cid":@"Cid",
             @"loginType":@"LoginType",
             @"wechatId":@"WechatId",
             @"telephone":@"Telephone",
             @"nick":@"Nick",
             @"avatarUrl":@"AvatarUrl",
             @"thumbAvatarUrl":@"ThumbAvatarUrl",
             @"gender":@"Gender",
             @"liveCityId":@"LiveCityId",
             @"liveCityName":@"LiveCityName",
             @"type":@"Type",
             @"createTime":@"CreateTime",
             @"updateTime":@"UpdateTime",
             
             //             @"":@"",
             //             @"deviceUuid":@"DeviceUuid",
             //             @"chatAccount":@"ChatAccount",
             //             @"chatPassword":@"ChatPassword",
             };
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

@end
