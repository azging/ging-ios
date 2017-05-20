//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
