//
//  AZPopViewHelper.m
//  LinkCity
//
//  Created by zzs on 2016/10/17.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZPopViewHelper.h"
#import "AZAppUtil.h"
#import <KLCPopup/KLCPopup.h>
#import "AZConstant.h"
#import "AZAlertUtil.h"

@interface AZPopViewHelper()
@property (strong, nonatomic) KLCPopup *commonPopup;
@property (assign, nonatomic) BOOL isShowNewVersionUpdateView;

@end

@implementation AZPopViewHelper

+ (instancetype)sharedInstance {
    static AZPopViewHelper *staticInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[AZPopViewHelper alloc] init];
    });
    return staticInstance;
}

- (void)dismissPopupView {
    [self.commonPopup dismissPresentingPopup];
}

- (void)cancelButtonClick {
    [self.commonPopup dismissPresentingPopup];
}

@end
