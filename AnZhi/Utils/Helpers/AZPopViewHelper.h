//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
