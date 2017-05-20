//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
