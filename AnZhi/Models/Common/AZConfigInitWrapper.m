//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZConfigInitWrapper.h"

@implementation AZConfigInitWrapper

+ (NSDictionary *)modelCustomPropertyMapper {
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
