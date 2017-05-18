//
//  AZPermissionUtil.h
//  LinkCity
//
//  Created by zzs on 2016/11/9.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZPermissionUtil : NSObject

+ (BOOL)isHaveLocationPermission;

+ (void)alertOpenLocationPermissionWithText:(NSString *)text;

@end
