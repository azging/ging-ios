//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZUpLoadManager : NSObject

+ (void)uploadFileDataToQinu:(NSData *)data fileType:(NSString *)fileType complete:(void(^)(NSString *fileUrlStr))completionHandler;

+ (void)uploadFileToQinu:(NSString *)filePath fileType:(NSString *)fileType complete:(void(^)(NSString *fileUrlStr))completionHandler;

+ (void)putData:(NSData *)data key:(NSString *)key token:(NSString *)token complete:(void(^)(NSString *fileUrlStr))completionHandler;

+ (void)putFile:(NSString *)filePath key:(NSString *)key token:(NSString *)token complete:(void(^)(NSString *fileUrlStr))completionHandler;
@end
