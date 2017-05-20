//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AZAMapManager : NSObject

// 获取数据管理器实例
+ (instancetype)sharedInstance;
// 启动高德地图
- (void)startAMap;
// 判断用户是否开启了定位
- (BOOL)isLocationEnabled;
/**
 * 开始更新定位信息
 * 定位成功后，自动获取坐标描述 （省、市、区、街）
 * 然后自动stopUpdateUserLocation
 * 建议在每次app唤醒时调用一次
 **/
- (void)startUpdateUserLocation;
// 停止定位
- (void)stopUpdateUserLocation;

//@property (assign, nonatomic) CLLocationCoordinate2D currentCoordinate;


@end
