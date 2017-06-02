//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUpLoadManager.h"
#import <Qiniu/QiniuSDK.h>
#import "AZStringUtil.h"
#import "AZConstant.h"
#import "AZFileUtil.h"
#import "AZNetRequester.h"

@implementation AZUpLoadManager

+ (void)uploadFileDataToQinu:(NSData *)data fileType:(NSString *)fileType complete:(void(^)(NSString *fileUrlStr))completionHandler {
    [AZNetRequester getQiniuUploadTokenOfFileType:fileType callBack:^(NSString *uploadToken, NSString *picKey, NSError *error) {
        if (error) {
            if (completionHandler) {
                completionHandler(nil);
            }
            return;
        }
        [AZUpLoadManager putData:data key:picKey token:uploadToken complete:^(NSString *fileUrlStr) {
            if (completionHandler) {
                completionHandler(fileUrlStr);
            }
        }];
    }];
}

+ (void)uploadFileToQinu:(NSString *)filePath fileType:(NSString *)fileType complete:(void(^)(NSString *fileUrlStr))completionHandler {
    [AZNetRequester getQiniuUploadTokenOfFileType:fileType callBack:^(NSString *uploadToken, NSString *picKey, NSError *error) {
        if (error) {
            if (completionHandler) {
                completionHandler(nil);
            }
            return;
        }
        [AZUpLoadManager putFile:filePath key:picKey token:uploadToken complete:^(NSString *fileUrlStr) {
            if (completionHandler) {
                completionHandler(fileUrlStr);
            }
        }];
    }];
}

+ (void)putData:(NSData *)data key:(NSString *)key token:(NSString *)token complete:(void(^)(NSString *fileUrlStr))completionHandler {
    if (data && data.length > 0) {
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//            NSLog(@"QNResponseInfo----%@", info);
//            NSLog(@"resp ------%@",resp);
            NSString *imageUrlStr = nil;
            if (!info.error) {
                if ([AZStringUtil isNotNullString:key] && ![key isEqualToString:@"(null)"]) {
                    imageUrlStr = [NSString stringWithFormat:@"%@%@", AZApiUriQINIUDomain, key];
                }
            }
            if (completionHandler) {
                completionHandler(imageUrlStr);
            }
        } option:nil];
    }
}

+ (void)putFile:(NSString *)filePath key:(NSString *)key token:(NSString *)token complete:(void(^)(NSString *fileUrlStr))completionHandler {
    BOOL fileIsExist = [AZFileUtil fileIsExistAtPath:filePath];
    if (fileIsExist) {
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putFile:filePath key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//            NSLog(@"QNResponseInfo----%@", info);
//            NSLog(@"resp ------%@",resp);
            NSString *imageUrlStr = nil;
            if (!info.error) {
                if ([AZStringUtil isNotNullString:key] && ![key isEqualToString:@"(null)"]) {
                    imageUrlStr = [NSString stringWithFormat:@"%@%@", AZApiUriQINIUDomain, key];
                }
            }
            if (completionHandler) {
                completionHandler(imageUrlStr);
            }
        } option:nil];
    }
}

@end
