//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

/**
 * 1、处理各个界面的代理回调
 * 2、界面的显示
 * 3、数据请求与处理
 **/

#import <UIKit/UIKit.h>
#import <KLCPopup/KLCPopup.h>
#import "AZUserModel.h"
#import "AZAuthCode.h"


typedef enum : NSUInteger {
    WorkModeUnknown         = 0,
    WorkModeRegister        = 1,
    WorkModeLogin           = 2,
    WorkModeResetPassword   = 3,
} WorkMode;

@interface AZRegisterHelper : NSObject

+ (instancetype)sharedInstance;

- (void)startRegisterBeginView;
- (void)startRegister;
- (void)startLogin;

@property (assign, nonatomic) CGFloat dimmedMaskAlpha;
@property (strong, nonatomic) AZUserModel *user;    //正在注册或更新的User
@property (assign, nonatomic) WorkMode workMode;

@end
