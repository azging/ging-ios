//
//  AZColorUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 8/26/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZColorUtil.h"

@implementation AZColorUtil


#pragma mark - Public Func

+ (UIColor *)getColor:(NSInteger)rgbValue {
    return [AZColorUtil getColorByRgba:rgbValue alpha:1.0f];
}

// 根据rgb值和alpha获取UIColor对象
+ (UIColor *)getColorByRgba:(NSInteger)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:alpha];
}

@end
