//
//  AZAlertUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 9/2/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZAlertUtil.h"
#import "AZStringUtil.h"
#import "AZConstant.h"
#import "AZColorUtil.h"
#import "AZAppUtil.h"
#import "AZArrayUtil.h"

@interface AZAlertUtil() <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) MBProgressHUD *showingHud;
@property (nonatomic, strong) UIAlertController *alert;
@end

@implementation AZAlertUtil


#pragma mark - Life Cycle

// 获取提示单例
+ (instancetype)sharedInstance {
    static AZAlertUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AZAlertUtil alloc]init];
    });
    return instance;
}


#pragma mark - Toast View

// 提示一条信息
+ (void)tipOneMessage:(NSString *)str {
    if ([AZStringUtil isNotNullString:str]) {
        [AZAlertUtil tipOneMessage:str yoffset:AZAlertTipDefaultYoffset delay:AZAlertTipDefaultDelay];
    }
}

// 指定位置和时间提示一条信息
+ (void)tipOneMessage:(NSString *)str yoffset:(float)yoffset delay:(float)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = str;
    hud.bezelView.color = [AZColorUtil getColor:AZColorFontDefault];
    hud.contentColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont fontWithName:AZFontNameDefault size:14];
    hud.margin = 10.f;
    hud.offset = CGPointMake(hud.offset.x, yoffset);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

// 指定在哪个视图上的位置和时间提示一条信息
+ (void)tipOneMessage:(NSString *)str onView:(UIView *)view yoffset:(float)yoffset delay:(float)delay {
    if (nil != view) {
        // 显示提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.userInteractionEnabled = NO;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = str;
        hud.bezelView.color = [AZColorUtil getColor:AZColorFontDefault];
        hud.contentColor = [UIColor whiteColor];
        hud.detailsLabel.font = [UIFont fontWithName:AZFontNameDefault size:14.0f];
        hud.margin = 10.f;
        hud.offset = CGPointMake(hud.offset.x, yoffset);
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:delay];
    }
}

#pragma mark - Hud View

// 显示加载动画内容
+ (void)showHudWithHint:(NSString *)hint {
    [AZAlertUtil showHudWithHint:hint inView:[UIApplication sharedApplication].delegate.window];
}

// 在某个视图上显示加载动画内容
+ (void)showHudWithHint:(NSString *)hint inView:(UIView *)view {
    [self showHudWithHint:hint inView:view enableUserInteraction:NO];
}

// 在某个视图上显示加载动画内容，并指定用户是否还可以和App交互
+ (void)showHudWithHint:(NSString *)hint inView:(UIView *)view enableUserInteraction:(BOOL)enable {
    // 如果有正在显示的Hud，不创建新的
    MBProgressHUD *hud = [AZAlertUtil sharedInstance].showingHud;
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:view];
    }
    
    hud.label.text = hint;
    hud.userInteractionEnabled = !enable;
    hud.bezelView.color = [AZColorUtil getColor:AZColorFontDefault];
    hud.contentColor = [UIColor whiteColor];
    [view addSubview:hud];
    [hud showAnimated:YES];
    [AZAlertUtil sharedInstance].showingHud = hud;
}

// 关闭加载动画
+ (void)hideHud {
    [[AZAlertUtil sharedInstance].showingHud hideAnimated:YES];
    [AZAlertUtil sharedInstance].showingHud = nil;
}

// 判断是否在显示加载动画
+ (BOOL)isShowingHud {
    return [AZAlertUtil sharedInstance].showingHud != nil;
}


#pragma mark - UIAlert View

// 弹出一条信息
+ (void)alertOneMessage:(NSString*)msg {
    [AZAlertUtil alertOneButton:@"确定" withTitle:@"提示" msg:msg callBack:nil];
}

// 带有一个按钮的弹出信息
+ (void)alertOneButton:(NSString *)btnOne withTitle:(NSString *)title msg:(NSString *)msg callBack:(void(^)(NSInteger selectIndex))callBack {
    UIAlertController *alert = [AZAlertUtil getAlert:title message:msg style:UIAlertControllerStyleAlert];
    alert = [AZAlertUtil alertAddAction:alert title:btnOne style:UIAlertActionStyleDefault index:0 changeColor:NO callBack:callBack];
    [[AZAppUtil getTopMostViewController] presentViewController:alert animated:YES completion:nil];
}

// 带有两个按钮的弹出信息
+ (void)alertTwoButton:(NSString *)btnOne btnTwo:(NSString *)btnTwo withTitle:(NSString *)title msg:(NSString *)msg callBack:(void(^)(NSInteger selectIndex))callBack {
    UIAlertController *alert = [AZAlertUtil getAlert:title message:msg style:UIAlertControllerStyleAlert];
    alert = [AZAlertUtil alertAddAction:alert title:btnOne style:UIAlertActionStyleDefault index:0 changeColor:NO callBack:callBack];
    alert = [AZAlertUtil alertAddAction:alert title:btnTwo style:UIAlertActionStyleDefault index:1 changeColor:NO callBack:callBack];
    [[AZAppUtil getTopMostViewController] presentViewController:alert animated:YES completion:nil];
}

// 底部显示选择按钮
+ (void)showActionSheet:(NSArray *)buttonTitleArr callBack:(void(^)(NSInteger selectIndex))callBack {
    buttonTitleArr = [AZArrayUtil insertFrontFilterObj:buttonTitleArr obj:@"取消"];
    UIAlertController *alert = [AZAlertUtil getAlert:nil message:nil style:UIAlertControllerStyleActionSheet];
    [buttonTitleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = obj;
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if (0 == idx && [@"取消" isEqualToString:title]) {
            style = UIAlertActionStyleCancel;
        }
        [AZAlertUtil alertAddAction:alert title:title style:style index:idx changeColor:YES callBack:callBack];
    }];
    [[AZAppUtil getTopMostViewController] presentViewController:alert animated:YES completion:nil];
}

+ (UIAlertController *)getAlert:(NSString *)title message:(NSString *)msg style:(UIAlertControllerStyle)style {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    [AZAlertUtil sharedInstance].alert = alert;
    return alert;
}

+ (UIAlertController *)alertAddAction:(UIAlertController *)alert title:(NSString *)title style:(UIAlertActionStyle)style index:(NSInteger)index changeColor:(BOOL)changeColor callBack:(void(^)(NSInteger selectIndex))callBack {
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
        if (callBack) {
            callBack(index);
            [AZAlertUtil sharedInstance].alert = nil;
        }
    }];
    if (changeColor) {
        if ([self buttonTitleChangeToRedColor:title]) {
            [alertAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
        }
    }
    [alert addAction:alertAction];
    return alert;
}

+ (BOOL)buttonTitleChangeToRedColor:(NSString *)title {
    BOOL toChange = NO;
    for (NSString *name in [self titleToChangeRedColorArr]) {
        if ([name isEqualToString:title]) {
            toChange = YES;
            break;
        }
    }
    return toChange;
}

+ (NSArray *)titleToChangeRedColorArr {
    return @[@"删除", @"举报", @"投诉"];
}

+ (void)hideAlert {
    if ([AZAlertUtil sharedInstance].alert) {
        [[AZAlertUtil sharedInstance].alert dismissViewControllerAnimated:YES completion:^{
            [AZAlertUtil sharedInstance].alert = nil;
        }];
    }
}

@end
