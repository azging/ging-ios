//
//  AZImageUtil.m
//  LinkCity
//
//  Created by whb on 16/9/7.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZImageUtil.h"
#import "AZApiConstant.h"
#import "AZUpLoadManager.h"
#import "AZFileUtil.h"
#import "AZStringUtil.h"

static const CGFloat AZImageUpLoadDefaultMaxSixe = 1024 * 1024 / 2;

@implementation AZImageUtil

// 调整图片方向（都调整为UIImageOrientationUp）
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to caAZulate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // caAZulated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

// 根据颜色uicolor得到一个图片
+ (UIImage *)getImageFromColor:(UIColor *)color {
    return [AZImageUtil getImageFromColor:color width:1 height:1];
}




/**
 * @brief   放大缩小图像.
 *
 * @param   image   需要放大缩小的图像.
 * @param   size    放大缩小后的图片尺寸.
 *
 * @return  放大缩小后的图像.
 */
+ (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)size {
    /// 创建一个bitmap的context，并把它设置成为当前正在使用的context.
    UIGraphicsBeginImageContext(size);
    
    /// 绘制改变大小的图片.
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    /// 从当前context中创建一个改变大小后的图片.
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /// 使当前的context出堆栈.
    UIGraphicsEndImageContext();
    
    /// 返回新的改变大小后的图片.
    return scaledImage;
}

/**
 * @brief   按照比例放大缩小图像.
 *
 * @param   image       需要放大缩小的图像.
 * @param   scaleSize   放大的倍数.
 *
 * @return  放大缩小后的图像.
 */
+ (UIImage*)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    NSLog(@"the image size is %@", NSStringFromCGSize(image.size));
    CGSize desSize = CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize);
    UIImage *scaledImage = [AZImageUtil scaleImage:image toSize:desSize];
    NSLog(@"the scaledImage size is %@", NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}

// 得到当前图片分类类型
+ (NSString *)getImageCategoryStringFromEnum:(ImageCategory)category {
    switch (category) {
        case ImageCategoryDefault:
            return @"default";
            break;
        case ImageCategoryAvatar:
            return @"avatar";
            break;
        case ImageCategoryCover:
            return @"cover";
            break;
        case ImageCategoryPlace:
            return @"place";
            break;
        case ImageCategoryPhoto:
            return @"photo";
            break;
        case ImageCategoryInvite:
            return @"invite";
            break;
        case ImageCategoryActiv:
            return @"activ";
            break;
        case ImageCategoryChat:
            return @"chat";
            break;
        case ImageCategoryVideo:
            return @"video";
            break;
    }
    return @"default";
}

// image转为data
+ (NSData *)getImageDataFromUIImage:(UIImage *)originImage {
    return UIImageJPEGRepresentation(originImage, 1.0);
}

//压缩图片到默认大小
+ (NSData *)getDataOfCompressImageToDefaultSize:(UIImage *)originImage {
    return [AZImageUtil getDataOfCompressImage:originImage toSize:AZImageUpLoadDefaultMaxSixe];
}

+ (UIImage *)getImageOfCompressImageToDefaultSize:(UIImage *)originImage {
    return [UIImage imageWithData:[AZImageUtil getDataOfCompressImage:originImage toSize:AZImageUpLoadDefaultMaxSixe]];
}

//压缩图片到某一大小
+ (NSData *)getDataOfCompressImage:(UIImage *)originImage toSize:(NSInteger)maxImageSize {
    NSData *imagedata = UIImageJPEGRepresentation(originImage, 1.0);
    NSInteger current_size = [imagedata length];
    if (current_size > maxImageSize) {
        float actual_size = (float)((float)maxImageSize/(float)current_size);
        imagedata = UIImageJPEGRepresentation(originImage, actual_size);
    }
    return imagedata;
}

+ (UIImage *)getImageOfCompressImage:(UIImage *)originImage toSize:(NSInteger)maxImageSize {
    return [UIImage imageWithData:[AZImageUtil getDataOfCompressImage:originImage toSize:maxImageSize]];
}

+ (void)compressImagesWithData:(NSArray *)originArray complete:(void (^)(NSArray *compressArray))complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *result = [NSMutableArray array];
        for (UIImage *originImage in originArray) {
            //UIImage *originImage = [dic objectForKey:UIImagePickerControllerOriginalImage];
            NSData *compressData = [self getDataOfCompressImageToDefaultSize:originImage];
            [result addObject:compressData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(result);
        });
    });
}

// 从原始图片URL得到ThumbURL
+ (NSString *)getThumbImageUrlFromOrigionalImageUrl:(NSString *)origionalImageUrl {
    return [NSString stringWithFormat:@"%@?imageView2/2/w/200", origionalImageUrl];
}

+ (void)uploadFilesToQiniu:(NSArray *)imageArr imageType:(ImageCategory)category callBack:(void(^)(NSArray *photoUrlArr))callBack {
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithCapacity:imageArr.count];
    [imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = (UIImage *)obj;
        [AZImageUtil uploadFileToQinu:image imageType:category completion:^(NSString *imgUrl) {
            if ([AZStringUtil isNullString:imgUrl]) {
                if (callBack) {
                    callBack(mutArr);
                }
            } else {
                mutArr[idx] = imgUrl;
                NSInteger idx = 0;
                for (; idx < mutArr.count; ++idx) {
                    if ([AZStringUtil isNullString:mutArr[idx]]) {
                        break;
                    }
                }
                if (mutArr.count == idx) {
                    if (callBack) {
                        callBack(mutArr);
                    }
                }
            }
        }];
    }];
}

// 图片上传七牛
+ (void)uploadFileToQinu:(UIImage *)image imageType:(ImageCategory)category completion:(void (^)(NSString *))comp {
//    NSData *imgData = [AZImageUtil getImageDataFromUIImage:image];
//    NSString *fileType = [AZImageUtil getImageCategoryStringFromEnum:category];
//    if (imgData.length > 1024 * 1024) {
//        NSString *filePath = [AZFileUtil getImageTempFilePath];
//        filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"_%ld",imgData.length]];
//        BOOL success = [imgData writeToFile:filePath atomically:YES];
//        if (success) {
//            [AZUpLoadManager uploadFileToQinu:filePath fileType:fileType complete:^(NSString *fileUrlStr) {
//                if (comp) {
//                    comp(fileUrlStr);
//                }
//                [AZFileUtil removeFile:[NSURL fileURLWithPath:filePath]];
//            }];
//        }
//    } else {
//        [AZUpLoadManager uploadFileDataToQinu:imgData fileType:fileType complete:^(NSString *fileUrlStr) {
//            if (comp) {
//                comp(fileUrlStr);
//            }
//        }];
//    }
    NSData *imgData = [AZImageUtil getDataOfCompressImageToDefaultSize:image];
    NSString *fileType = [AZImageUtil getImageCategoryStringFromEnum:category];
    [AZUpLoadManager uploadFileDataToQinu:imgData fileType:fileType complete:^(NSString *fileUrlStr) {
        if (comp) {
            comp(fileUrlStr);
        }
    }];
}

+ (UIImage *)getVideoCover:(NSURL *)videoURL {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(0, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}

@end
