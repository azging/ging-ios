//
//  AZFileUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 2016/12/5.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZFileUtil.h"


static NSString * const AZAccountFolder = @"Account";
static NSString * const AZPhoneContactFileName = @"PhoneContact";
static NSString * const AZCalendarEventsFileName = @"CalendarEvents";
static NSString * const AZCalendarFestivalsFileName = @"CalendarFestivals";
static NSString * const AZImageFolder = @"Image";
static NSString * const AZVideoFolder = @"Video";

@implementation AZFileUtil
//在根目录下创建文件夹
+ (BOOL)createFolderInRootFolderIfNotExistWithName:(NSString *)name {
    NSString *folder = [self getRootFolderPathStringWithFolderName:name];
    return [self createFolderIfNotExistForFolderPath:folder];
}

//获取应用根目录的文件夹路径
+ (NSString *)getRootFolderPathStringWithFolderName:(NSString *)folderName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:folderName];
    
    return path;
}

//创建文件夹如果不存在（完整路径）
+ (BOOL)createFolderIfNotExistForFolderPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    NSError *error;
    if(!(isDirExist && isDir)) {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(!bCreateDir) {
//            MyLog(@"创文件夹失败:%@",error);
//            MyLog(@"创建路径：%@",folderPath);
            return NO;
        }
        return YES;
    }
    return YES;
}

//创建文件如果不存在（完整路径）
+ (BOOL)createFileIfNotExistForFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isFileExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if(!isFileExist && !isDir) {
        BOOL bCreateDir = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        if(!bCreateDir) {
//            MyLog(@"创文件失败");
            return NO;
        }
        return YES;
    }
//    MyLog(@"不用创建了");
    return YES;
}

//获取当前时间
+(NSString *)getTimestamp {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd_HHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:now];
    NSTimeInterval timeInterval = [now timeIntervalSince1970];
    nowTimeStr = [nowTimeStr stringByAppendingString:[NSString stringWithFormat:@"_%.7lf", timeInterval]];
    return nowTimeStr;
}

//获取临时文件夹路径
+(NSString *)getTempFolder {
    return NSTemporaryDirectory();
}

//判断文件是否存在
+(BOOL)fileIsExistAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

// 删除文件
+ (void)removeFile:(NSURL *)fileURL callBack:(void(^)(NSError *error))callBack {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePath = [[fileURL absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSError *error = nil;
            [fileManager removeItemAtPath:filePath error:&error];
            if (callBack) {
                callBack(error);
            }
        }
    });
}

//删除文件
+ (void)removeFile:(NSURL *)fileURL {
    [self removeFile:fileURL callBack:nil];
}

// 删除多个文件
+ (void)removeFiles:(NSArray *)urlArray {
    for (NSURL *fileURL in urlArray) {
        [self removeFile:fileURL];
    }
}



+ (BOOL)writeStr:(NSString *)str toFile:(NSString *)filePath {
   return [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


#pragma mark  -- Image 的缓存路径
+ (BOOL)createImageFolderIfNotExist {
    return [AZFileUtil createFolderInRootFolderIfNotExistWithName:AZImageFolder];
}

+ (NSString *)getImageFolderPath {
    [AZFileUtil createImageFolderIfNotExist];
    return [AZFileUtil getRootFolderPathStringWithFolderName:AZImageFolder];
}

// 获取上传图片缓存本地路径
+ (NSString *)getImageTempFilePath {
    return [[AZFileUtil getImageFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Image_%@", [AZFileUtil getTimestamp]]];
}


#pragma mark  -- Video 的缓存路径
+ (BOOL)createVideoFolderIfNotExist {
    return [AZFileUtil createFolderInRootFolderIfNotExistWithName:AZVideoFolder];
}

+ (NSString *)getVideoFolderPath {
    [AZFileUtil createVideoFolderIfNotExist];
    return [AZFileUtil getRootFolderPathStringWithFolderName:AZVideoFolder];
}

// 获取上传视频的缓存本地路径
+ (NSString *)getVideoTempFilePath {
    return [[AZFileUtil getVideoFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Video_%@.mp4", [AZFileUtil getTimestamp]]];
}


#pragma mark  -- 用户信息的 的缓存路径
+ (BOOL)createAccountFolderIfNotExist {
    return [AZFileUtil createFolderInRootFolderIfNotExistWithName:AZAccountFolder];
}

+ (NSString *)getAccountFolderPath {
    [AZFileUtil createAccountFolderIfNotExist];
    return [AZFileUtil getRootFolderPathStringWithFolderName:AZAccountFolder];
}

+ (NSString *)getPhoneContactJsonStrFilePath {
    return [[AZFileUtil getAccountFolderPath] stringByAppendingPathComponent:AZPhoneContactFileName];
}

+ (NSString *)getPhoneContactJsonStrFilePathAfterWriteJsonStr:(NSString *)writeStr {
    NSString *filePath = [AZFileUtil getPhoneContactJsonStrFilePath];
    return [AZFileUtil writeToFile:filePath writeStr:writeStr];
}


+ (NSString *)getPhoneContactJsonStr {
    NSString *filePath = [AZFileUtil getPhoneContactJsonStrFilePath];
    if ([AZFileUtil fileIsExistAtPath:filePath]) {
        NSError *error;
        NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            return jsonStr;
        }
    }
    return @"";
}

+ (NSString *)getCalendarEventsJsonStr {
    NSString *filePath = [AZFileUtil getCalendarEventsJsonStrFilePath];
    if ([AZFileUtil fileIsExistAtPath:filePath]) {
        NSError *error;
        NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            return jsonStr;
        }
    }
    return @"";
}

+ (NSString *)getCalendarEventsJsonStrFilePath {
    return [[AZFileUtil getAccountFolderPath] stringByAppendingPathComponent:AZCalendarEventsFileName];
}

+ (NSString *)getCalendarEventsJsonStrFilePathAfterWriteJsonStr:(NSString *)writeStr {
    NSString *filePath = [AZFileUtil getCalendarEventsJsonStrFilePath];
    return [AZFileUtil writeToFile:filePath writeStr:writeStr];
}

+ (NSString *)getCalendarFestivalsJsonStrFilePath {
    return [[AZFileUtil getAccountFolderPath] stringByAppendingPathComponent:AZCalendarFestivalsFileName];
}

+ (NSString *)getCalendarFestivalsJsonStrFilePathAfterWriteJsonStr:(NSString *)writeStr {
    NSString *filePath = [AZFileUtil getCalendarFestivalsJsonStrFilePath];
    return [AZFileUtil writeToFile:filePath writeStr:writeStr];
}

+ (NSString *)writeToFile:(NSString *)filePath writeStr:(NSString *)writeStr {
    if ([AZFileUtil fileIsExistAtPath:filePath]) {
        [AZFileUtil removeFile:[NSURL fileURLWithPath:filePath]];
    }
    if ([AZFileUtil createFileIfNotExistForFilePath:filePath]) {
        if ([AZFileUtil writeStr:writeStr toFile:filePath]) {
            return filePath;
        }
    }
    return @"";
}

@end
