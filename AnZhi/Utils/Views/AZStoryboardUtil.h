//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AZStoryboardConstant.h"

@interface AZStoryboardUtil : NSObject

// 根据Storyboard和identifier获取UIViewController对象
+ (UIViewController *)getViewController:(NSString *)sbName identifier:(NSString *)vcidName;

@end
