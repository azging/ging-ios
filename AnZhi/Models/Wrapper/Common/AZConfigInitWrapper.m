//
//  AZConfigInitWrapper.m
//  LinkCity
//
//  Created by 张宗硕 on 11/10/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZConfigInitWrapper.h"

@implementation AZConfigInitWrapper

+ (NSDictionary *)modeAZustomPropertyMapper {
    return @{@"isCIDExpired":@"IsCIDExpired",
             @"userModel":@"User",
             @"userNotifyModel":@"UserNotify",
             @"themeArr":@"ThemeList",
             @"travelInviteTagArr":@"TravelInviteTagList",
             @"localInviteTagArr":@"LocalInviteTagList",
             @"hotThemeArr":@"HotThemeList",
             @"hotPlaceArr":@"HotPlaceList",
             @"versionInfo":@"VersionInfo",
             @"expressFee":@"ExpressFee",
             @"initIndex":@"InitIndex",
             @"calendarGuideArr":@"CalendarBgList",
             };
}



@end
