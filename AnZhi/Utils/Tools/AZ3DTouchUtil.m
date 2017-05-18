//
//  AZ3DTouchUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 2017/2/16.
//  Copyright © 2017年 张宗硕. All rights reserved.
//

#import "AZ3DTouchUtil.h"
#import "AZAppUtil.h"
#import "AZConstant.h"

static NSString * const AZ3DTouchItemType_InvitePublish         = @"3DTouchItemTypeInvitePublish";
static NSString * const AZ3DTouchItemType_PhotoPublish          = @"3DTouchItemTypePhotoPublish";
static NSString * const AZ3DTouchItemType_HotPhoto              = @"3DTouchItemTypeHotPhoto";

@interface AZ3DTouchUtil ()

@end

@implementation AZ3DTouchUtil

+ (void)setUp3DTouchItem {
    if ([AZAppUtil getDeviceSystemVersion] >= 9.0) {
        UIApplicationShortcutItem *invitePublishItem = [self getShortcutItem:AZ3DTouchItemType_InvitePublish title:@"发邀约" iconName:@"3DTouchInvitePublishIcon"];
        UIApplicationShortcutItem *photoPublishItem = [self getShortcutItem:AZ3DTouchItemType_PhotoPublish title:@"发玩乐" iconName:@"3DTouchPhotoPublishIcon"];
        UIApplicationShortcutItem *hotPhotoItem = [self getShortcutItem:AZ3DTouchItemType_HotPhoto title:@"热门玩乐" iconName:@"3DTouchHotPhotoIcon"];
        [UIApplication sharedApplication].shortcutItems = @[invitePublishItem,photoPublishItem,hotPhotoItem];
    }
}

+ (UIApplicationShortcutItem *)getShortcutItem:(NSString *)type title:(NSString *)title iconName:(NSString *)iconName {
    UIApplicationShortcutIcon *shortcutIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:iconName];
    UIApplicationShortcutItem *shortcutItem = [[UIApplicationShortcutItem alloc] initWithType:type localizedTitle:title localizedSubtitle:@"" icon:shortcutIcon userInfo:nil];
    return shortcutItem;
}

+ (void)setUp3DTouchItemAction:(UIApplicationShortcutItem *)shortcutItem {
//    if ([shortcutItem.type isEqualToString:AZ3DTouchItemType_InvitePublish]) {
//        AZTabBarVC *tabVC = [AZAppUtil getAppDelegate].tabBarVC;
//        [tabVC setSelectedIndex:AZTabBarVCIndex_LocalTab];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification3DTouchInvitePublish object:nil];
//    } else if ([shortcutItem.type isEqualToString:AZ3DTouchItemType_PhotoPublish]) {
//        AZTabBarVC *tabVC = [AZAppUtil getAppDelegate].tabBarVC;
//        [tabVC setSelectedIndex:AZTabBarVCIndex_PhotoTab];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification3DTouchPhotoPublish object:nil];
//    } else if ([shortcutItem.type isEqualToString:AZ3DTouchItemType_HotPhoto]) {
//        AZTabBarVC *tabVC = [AZAppUtil getAppDelegate].tabBarVC;
//        [tabVC setSelectedIndex:AZTabBarVCIndex_PhotoTab];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Notification3DTouchHotPhoto object:nil];
//    }
}

@end
