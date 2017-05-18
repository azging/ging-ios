//
//  AZUpLoadManager.h
//  LinkCity
//
//  Created by 张宗硕 on 2017/2/22.
//  Copyright © 2017年 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZUpLoadManager : NSObject

+ (void)uploadFileDataToQinu:(NSData *)data fileType:(NSString *)fileType complete:(void(^)(NSString *fileUrlStr))completionHandler;

+ (void)uploadFileToQinu:(NSString *)filePath fileType:(NSString *)fileType complete:(void(^)(NSString *fileUrlStr))completionHandler;

+ (void)putData:(NSData *)data key:(NSString *)key token:(NSString *)token complete:(void(^)(NSString *fileUrlStr))completionHandler;

+ (void)putFile:(NSString *)filePath key:(NSString *)key token:(NSString *)token complete:(void(^)(NSString *fileUrlStr))completionHandler;
@end
