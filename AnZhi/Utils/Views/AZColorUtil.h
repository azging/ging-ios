//
//  AZColorUtil.h
//  LinkCity
//
//  Created by 张宗硕 on 8/26/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AZColorConstant.h"

@interface AZColorUtil : NSObject

+ (UIColor *)getColor:(NSInteger)rgbValue;
+ (UIColor *)getColorByRgba:(NSInteger)rgbValue alpha:(CGFloat)alpha;

@end
