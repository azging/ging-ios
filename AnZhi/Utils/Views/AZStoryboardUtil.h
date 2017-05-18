//
//  AZStoryboardUtil.h
//  LinkCity
//
//  Created by 张宗硕 on 8/25/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AZStoryboardConstant.h"

@interface AZStoryboardUtil : NSObject

// 根据Storyboard和identifier获取UIViewController对象
+ (UIViewController *)getViewController:(NSString *)sbName identifier:(NSString *)vcidName;

@end
