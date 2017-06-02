//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAMapManager.h"
#import "AZDataManager.h"
#import "AZConstant.h"
#import "CLLocation+Trans.h"

static NSString * const AZAMapAppKey = @"88ff48cb1c2b61d598ecbd9dee2c063c"; // azging

@interface AZAMapManager () <AMapLocationManagerDelegate>

@property (strong, nonatomic) AMapLocationManager *locationManager;

@end

@implementation AZAMapManager

// 获取数据管理器实例
+ (instancetype)sharedInstance {
    static AZAMapManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^() {
        instance = [[AZAMapManager alloc]init];
    });
    return instance;
}


#pragma mark - Public Func

- (void)startAMap {
    [AMapServices sharedServices].apiKey = AZAMapAppKey;
}

// 判断用户是否开启了定位
- (BOOL)isLocationEnabled {
    BOOL ret = YES;
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        ret = NO;
    }
    return ret;
}

- (void)startUpdateUserLocation {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
    });
    [_locationManager startUpdatingLocation];
}

// 停止定位
- (void)stopUpdateUserLocation {
    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
    }
}

- (void)setUserLocation:(CLLocation *)location  {
    location = [location locationBaiduFromMars];
    [AZDataManager sharedInstance].userLocation = location;
    [self stopUpdateUserLocation];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationJustUpdateLocation object:nil];
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    [AZDataManager sharedInstance].userLocation = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationJustFailUpdateLocation object:nil];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    [self setUserLocation:location];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    [self setUserLocation:location];
}

@end
