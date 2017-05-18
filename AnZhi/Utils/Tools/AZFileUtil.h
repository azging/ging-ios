//
//  AZFileUtil.h
//  LinkCity
//
//  Created by 张宗硕 on 2016/12/5.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AZFileUtil : NSObject
//在根目录下创建文件夹
+ (BOOL)createFolderInRootFolderIfNotExistWithName:(NSString *)name;
//获取应用根目录下某个文件夹的路径
+ (NSString *)getRootFolderPathStringWithFolderName:(NSString *)folderName;
//创建文件夹如果不存在（完整路径）
+ (BOOL)createFolderIfNotExistForFolderPath:(NSString *)folderPath;
//创建文件如果不存在（完整路径）
+ (BOOL)createFileIfNotExistForFilePath:(NSString *)filePath;
//获取当前时间
+ (NSString *)getTimestamp;
//获取临时文件夹路径
+ (NSString *)getTempFolder;
//判断文件是否存在
+ (BOOL)fileIsExistAtPath:(NSString *)path;

//删除文件
+ (void)removeFile:(NSURL *)fileURL callBack:(void(^)(NSError *error))callBack;
+ (void)removeFile:(NSURL *)fileURL;
+ (void)removeFiles:(NSArray *)urlArray;

// 删除视频和图片的缓存文件
+ (void)removeMediaTempFolder;

// 把字符串写入文件
+ (BOOL)writeStr:(NSString *)str toFile:(NSString *)filePath;

// 图片缓存文件夹
+ (NSString *)getImageFolderPath;
// 获取上传图片缓存本地路径
+ (NSString *)getImageTempFilePath;

// 视频缓存文件夹
+ (NSString *)getVideoFolderPath;
// 获取上传视频的缓存本地路径
+ (NSString *)getVideoTempFilePath;

// 创建保存用户信息的文件夹
+ (BOOL)createAccountFolderIfNotExist;
// 获取保存用户信息的文件夹的路径
+ (NSString *)getAccountFolderPath;
// 获取用户通讯录JsonStr文件的保存路径
+ (NSString *)getPhoneContactJsonStrFilePath;
// 获取上次写入的通讯录JsonStr
+ (NSString *)getPhoneContactJsonStr;
// 把通讯录JsonStr写入文件，并获取文件路径
+ (NSString *)getPhoneContactJsonStrFilePathAfterWriteJsonStr:(NSString *)writeStr;
// 获取上次写入的日历事件的JsonStr
+ (NSString *)getCalendarEventsJsonStr;
// 把日历事件写入文件
+ (NSString *)getCalendarEventsJsonStrFilePathAfterWriteJsonStr:(NSString *)writeStr;
// 把日历的节日写入文件
+ (NSString *)getCalendarFestivalsJsonStrFilePathAfterWriteJsonStr:(NSString *)writeStr;
@end
