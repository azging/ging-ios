//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AZColorConstant.h"

@interface AZColorUtil : NSObject

+ (UIColor *)getColor:(NSInteger)rgbValue;
+ (UIColor *)getColorByRgba:(NSInteger)rgbValue alpha:(CGFloat)alpha;

@end
