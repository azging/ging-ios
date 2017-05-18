//
//  AZRegisterHelper.m
//  LinkCity
//
//  Created by whb on 16/8/30.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZRegisterHelper.h"
#import "AZUtil.h"
#import "AZDataManager.h"
#import "AZNetRequester.h"
#import "AZConstant.h"
#import "AZAppUtil.h"

@interface AZRegisterHelper ()

@property (strong, nonatomic) NSString *authCode;// 经用户输入，验证后正确的验证码
@property (strong, nonatomic) NSString *phoneNum;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) KLCPopup *commonPopup;


@end

@implementation AZRegisterHelper

+ (instancetype)sharedInstance {
    static AZRegisterHelper *staticInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[AZRegisterHelper alloc] init];
    });
    return staticInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dimmedMaskAlpha = AZAlertViewMaskAlpha;
        self.workMode = WorkModeUnknown;
        self.user = [AZDataManager sharedInstance].userModel;
    }
    return self;
}

- (void)startRegisterBeginView {
    self.workMode = WorkModeUnknown;

}

- (void)startRegister {
    self.workMode = WorkModeRegister;
}

- (void)startLogin {
    self.workMode = WorkModeLogin;
}


@end
