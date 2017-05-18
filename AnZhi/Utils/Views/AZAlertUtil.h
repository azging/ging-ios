//
//  AZAlertHelper.h
//  LinkCity
//
//  Created by 张宗硕 on 9/2/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

static float const AZAlertTipDefaultYoffset = 0.0f;
static float const AZAlertTipRegisterYoffset = -100.0f;

static float const AZAlertTipDefaultDelay = 1.0f;
static float const AZAlertTipRightDelay = 0.6f;
static float const AZAlertTipErrorDelay = 1.6f;

@interface AZAlertUtil : NSObject

// 提示一条信息
+ (void)tipOneMessage:(NSString *)str;
// 指定位置和时间提示一条信息
+ (void)tipOneMessage:(NSString *)str yoffset:(float)yoffset delay:(float)delay;
// 指定在哪个视图上的位置和时间提示一条信息
+ (void)tipOneMessage:(NSString *)str onView:(UIView *)view yoffset:(float)yoffset delay:(float)delay;

// 显示加载动画内容
+ (void)showHudWithHint:(NSString *)hint;
// 在某个视图上显示加载动画内容
+ (void)showHudWithHint:(NSString *)hint inView:(UIView *)view;
// 在某个视图上显示加载动画内容，并指定用户是否还可以和App交互
+ (void)showHudWithHint:(NSString *)hint inView:(UIView *)view enableUserInteraction:(BOOL)enable;
// 关闭加载动画
+ (void)hideHud;
// 判断是否在显示加载动画
+ (BOOL)isShowingHud;


// 弹出一条信息
+ (void)alertOneMessage:(NSString*)msg;
// 带有一个按钮的弹出信息
+ (void)alertOneButton:(NSString *)btnOne withTitle:(NSString *)title msg:(NSString *)msg callBack:(void(^)(NSInteger selectedIndex))callBack;
// 带有两个按钮的弹出信息
+ (void)alertTwoButton:(NSString *)btnOne btnTwo:(NSString *)btnTwo withTitle:(NSString *)title msg:(NSString *)msg callBack:(void(^)(NSInteger selectedIndex))callBack;
// 底部显示选择按钮
+ (void)showActionSheet:(NSArray *)buttonTitleArr callBack:(void(^)(NSInteger selectedIndex))callBack;

+ (void)hideAlert;
@end
