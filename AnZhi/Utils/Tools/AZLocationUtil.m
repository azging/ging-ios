//
//  AZLocationUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 2016/11/10.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZLocationUtil.h"

#import <CoreLocation/CoreLocation.h>

@implementation AZLocationUtil

+ (NSArray *)getNotNullLocationArr:(NSArray *)locationArr {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (CLLocation *location in locationArr) {
        if (location.coordinate.latitude && location.coordinate.longitude) {
            //            NSLog(@"latitude:%f-----longitude%f", location.coordinate.latitude, location.coordinate.longitude);
            [mutArr addObject:location];
        }
    }
    return mutArr;
}

@end
