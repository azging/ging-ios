//
//  AZPermissionUtil.m
//  LinkCity
//
//  Created by zzs on 2016/11/9.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZPermissionUtil.h"
#import "AZAlertUtil.h"
#import <CoreLocation/CoreLocation.h>
#import "AZAMapManager.h"

@implementation AZPermissionUtil

+ (BOOL)isHaveLocationPermission {
    return [[AZAMapManager sharedInstance] isLocationEnabled];
}

+ (void)alertOpenLocationPermissionWithText:(NSString *)text {
    if (![AZPermissionUtil isHaveLocationPermission]) {
        [AZAlertUtil alertTwoButton:@"取消" btnTwo:@"开启定位" withTitle:@"定位服务未开启" msg:text callBack:^(NSInteger selectIndex) {
            if (0 == selectIndex) {
                return;
            } else if (1 == selectIndex) {
                NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                if ([CLLocationManager locationServicesEnabled]) {
                    url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                }
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }];
    }
}

@end
