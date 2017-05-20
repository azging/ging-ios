//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
