//
//  AZPopViewHelper.h
//  LinkCity
//
//  Created by zzs on 2016/10/17.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AZPopViewHelper;

@protocol AZPopViewHelperDelegate <NSObject>

- (void)popViewHelperDidCancel:(AZPopViewHelper *)helper;
- (void)popViewHelperConfirmDate:(AZPopViewHelper *)helper;

@end

@interface AZPopViewHelper : NSObject

+ (instancetype)sharedInstance;
- (void)dismissPopupView;

@end
