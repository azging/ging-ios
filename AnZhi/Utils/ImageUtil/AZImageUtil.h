//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

/*
 Type: "default"
 // 分类文件夹，avatar：头像，cover：计划封面，place：地点封面，photo：个人相册， invite: 新版发邀约配图，activ: 新版旅图配图，chat: 聊天配图
 */
typedef enum : NSUInteger {
    ImageCategoryDefault    = 0,
    ImageCategoryAvatar     = 1,
    ImageCategoryCover,
    ImageCategoryPlace,
    ImageCategoryPhoto,
    ImageCategoryInvite,
    ImageCategoryActiv,
    ImageCategoryChat,
    ImageCategoryVideo,
} ImageCategory;

@interface AZImageUtil : NSObject

// 调整图片方向（都调整为UIImageOrientationUp）
+ (UIImage *)fixOrientation:(UIImage *)aImage;

// 根据颜色uicolor得到一个图片
+ (UIImage *)getImageFromColor:(UIColor *)color;

+ (UIImage *)getImageFromColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

+ (UIImage *)getImageFromImage:(UIImage *)image inRect:(CGRect)rect;
/**
 * @brief   放大缩小图像.
 *
 * @param   image   需要放大缩小的图像.
 * @param   size    放大缩小后的图片尺寸.
 *
 * @return  放大缩小后的图像.
 */
+ (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)size;


/**
 * @brief   按照比例放大缩小图像.
 *
 * @param   image       需要放大缩小的图像.
 * @param   scaleSize   放大的倍数.
 *
 * @return  放大缩小后的图像.
 */
+ (UIImage*)scaleImage:(UIImage *)image toScale:(float)scaleSize;

// 得到当前图片分类类型
+ (NSString *)getImageCategoryStringFromEnum:(ImageCategory)category;

// image转为data
+ (NSData *)getImageDataFromUIImage:(UIImage *)originImage;

//压缩图片到默认大小
+ (NSData *)getDataOfCompressImageToDefaultSize:(UIImage *)originImage;
+ (UIImage *)getImageOfCompressImageToDefaultSize:(UIImage *)originImage;

//压缩图片到某一大小
+ (NSData *)getDataOfCompressImage:(UIImage *)originImage toSize:(NSInteger)maxImageSize;
+ (UIImage *)getImageOfCompressImage:(UIImage *)originImage toSize:(NSInteger)maxImageSize;

// 从原始图片URL得到ThumbURL
+ (NSString *)getThumbImageUrlFromOrigionalImageUrl:(NSString *)origionalImageUrl;

// 上传多张图片到七牛
+ (void)uploadFilesToQiniu:(NSArray *)imageArr imageType:(ImageCategory)category callBack:(void(^)(NSArray *photoUrlArr))callBack;

// 图片上传七牛
+ (void)uploadFileToQinu:(UIImage *)image imageType:(ImageCategory)category completion:(void(^)(NSString *imgUrl))comp;

+ (UIImage *)getVideoCover:(NSURL *)videoURL;

@end
