//
//  AZPhoneUtil.h
//  LinkCity
//
//  Created by whb on 16/8/30.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AZPhoneUtil : NSObject

// 检查是否是手机号
+ (BOOL)isPhoneNum:(NSString *)mobileNum;
+ (void)dialPhoneNumber:(NSString *)phoneNumber;
// 获取11位手机号 （去掉 +86、86、空格、-等）
+ (NSString *)formatPhoneString:(NSString *)origionPhone;

// 读取通讯录数据，解析为PhoneContactModel数组
+ (void)getPhoneContactModelList:(void(^)(NSArray *phoneContactModelList))callBack;
// 获取存入文件的通讯录JsonStr （由PhoneContactModelList生成）
+ (void)getPhoneContactJsonStr:(void(^)(NSString *jsonStr))callBack;

// 检查本地通讯录变化，并上传
+ (void)checkAndUploadTelephoneContact;

@end
