//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZPermissionUtil : NSObject

+ (BOOL)isHaveLocationPermission;

+ (void)alertOpenLocationPermissionWithText:(NSString *)text;

@end
