//
//  AZStoryboardUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 8/25/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZStoryboardUtil.h"
#import "AZStringUtil.h"

@implementation AZStoryboardUtil


#pragma mark - Public Func

// 根据Storyboard和identifier获取UIViewController对象
+ (UIViewController *)getViewController:(NSString *)sbName identifier:(NSString *)vcidName {
    UIViewController *viewController = nil;
    UIStoryboard *storyboard = [AZStoryboardUtil getStoryboardByName:sbName];
    if (nil != storyboard) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:vcidName];
    }
    return viewController;
}


#pragma mark - Private Func

+ (UIStoryboard *)getStoryboardByName:(NSString *)sbName {
    UIStoryboard *stroyboard = nil;
    if ([AZStringUtil isNotNullString:sbName]) {
        stroyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    }
    return stroyboard;
}

@end
