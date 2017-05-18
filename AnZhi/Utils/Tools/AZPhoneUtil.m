//
//  AZPhoneUtil.m
//  LinkCity
//
//  Created by whb on 16/8/30.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZPhoneUtil.h"
#import "AZDataManager.h"
#import "AZUtil.h"


@implementation AZPhoneUtil

// 检查是否是手机号
+ (BOOL)isPhoneNum:(NSString *)mobileNum {
    NSString *wideRegex = [NSString stringWithFormat:@"^1[\\d]{10}$"];
    NSPredicate *regextesWide = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", wideRegex];
    if (NO == [regextesWide evaluateWithObject:mobileNum]) {
        return NO;
    }
    return YES;
}

// 拨打电话
+ (void)dialPhoneNumber:(NSString *)phoneNumber {
    // 有可能010，400开头的电话
    if ([AZStringUtil isNullString:phoneNumber]) {
        [AZAlertUtil alertOneButton:@"我知道了" withTitle:nil msg:@"号码错误" callBack:nil];
    }
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [AZAlertUtil alertTwoButton:@"取消" btnTwo:@"呼叫" withTitle:nil msg:phoneNumber callBack:^(NSInteger selectIndex) {
            if (1 == selectIndex) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];
            }
        }];
    } else {
        [AZAlertUtil alertOneButton:@"我知道了" withTitle:nil msg:@"您的设备不能拨打电话" callBack:nil];
    }
}

+ (NSString *)formatPhoneString:(NSString *)origionPhone{
    NSString *ret = [origionPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    ret = [origionPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([ret hasPrefix:@"+86"]) {
        ret = [ret substringFromIndex:3];
    }else if([ret hasPrefix:@"86"]) {
        ret = [ret substringFromIndex:2];
    }
    return ret;
}

@end
