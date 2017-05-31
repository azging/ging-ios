//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZViewUtil.h"
#import "AZImageUtil.h"
#import "AZAppUtil.h"
#import "AZUserModel.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "AZColorUtil.h"
#import "AZStringUtil.h"
#import <Masonry/Masonry.h>
#import <DKImagePickerController/DKImagePickerController-Swift.h>
#import "AZSwitcherUtil.h"
#import <Photos/Photos.h>
#import <objc/runtime.h>
#import <KLCPopup/KLCPopup.h>
#import "AZDataManager.h"
#import "AZPopViewHelper.h"


@implementation AZViewUtil

#pragma mark - Public Func

+ (void)removeAllSubViews:(UIView *)view {
    for (UIView *v in view.subviews) {
        [v removeFromSuperview];
    }
}

+ (UIView *)getViewFromXib:(Class)class {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(class) bundle:nil];
    
    NSArray *views = [nib instantiateWithOwner:nil options:nil];
    for (UIView *v in views) {
        if ([v isKindOfClass:class]) {
            return (UIView *)v;
        }
    }
    return nil;
}

+ (void)updateAvatarImageView:(UIImageView *)imageView url:(NSString *)url {
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:AZDefaultAvatarImageName]];
}

+ (void)updateCoverImageView:(UIImageView *)imageView url:(NSString *)url {
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:AZDefaultCoverImageName]];
}

+ (void)updateImageView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl imageThumbUrl:(NSString *)imageThumbUrl placeholderImageName:(NSString *)placeholderImageName {
    if ([AZStringUtil isNotNullString:imageThumbUrl]) {
        [imageView setImageWithURL:[NSURL URLWithString:imageThumbUrl] placeholderImage:[UIImage imageNamed:placeholderImageName]];
    }
    if ([AZStringUtil isNotNullString:imageUrl]) {
        UIImage *image = imageView.image;
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image];
    }
}

+ (void)updateGenderImageView:(UIImageView *)genderImageView gender:(NSInteger)gender {
    genderImageView.hidden = YES;
    if (UserGender_Male == gender) {
        genderImageView.hidden = NO;
        genderImageView.image = [UIImage imageNamed:AZImageNameUserGenderMale];
    } else if (UserGender_Female == gender) {
        genderImageView.hidden = NO;
        genderImageView.image = [UIImage imageNamed:AZImageNameUserGenderFemale];
    }
}


#pragma mark - Private Func

+ (void)pickPhotos:(NSInteger)maxNum callBack:(void(^)(NSArray *imageArr))callBack cancel:(void(^)())cancel {
    [self pickPhotos:maxNum needLocation:NO hidePopView:NO popInView:nil callBack:^(NSArray *imageArr, NSArray *imageLocationArr) {
        if (callBack) {
            if (imageArr.count > 0) {
                callBack(imageArr);
            }
        }
    } cancel:^{
        if (cancel) {
            cancel();
        }
    }];
}

+ (void)pickPhotos:(NSInteger)maxNum hidePopView:(UIView *)popView callBack:(void (^)(NSArray *))callBack cancel:(void(^)())cancel {
    [self pickPhotos:maxNum needLocation:NO hidePopView:YES popInView:popView callBack:^(NSArray *imageArr, NSArray *imageLocationArr) {
        if (callBack) {
            if (imageArr.count > 0) {
                callBack(imageArr);
            }
        }
    } cancel:^{
        if (cancel) {
            cancel();
        }
    }];
}

+ (void)pickPhotosAndLocation:(NSInteger)maxNum callBack:(void (^)(NSArray *, NSArray *))callBack cancel:(void(^)())cancel {
    [self pickPhotos:maxNum needLocation:YES hidePopView:NO popInView:nil callBack:^(NSArray *imageArr, NSArray *imageLocationArr) {
        if (callBack) {
            if (imageArr.count > 0) {
                callBack(imageArr, imageLocationArr);
            }
        }
    } cancel:^{
        if (cancel) {
            cancel();
        }
    }];
}

+ (void)pickPhotos:(NSInteger)maxNum needLocation:(BOOL)needLocation hidePopView:(BOOL)hidePopView popInView:(UIView *)popInView callBack:(void(^)(NSArray *imageArr, NSArray *imageLocationArr))callBack cancel:(void(^)())cancel {
    DKImagePickerController *pickerController = [self getDKImagePickerController:maxNum];
    [pickerController setDidCancel:^{
        if (hidePopView) {
            [AZViewUtil setPopViewStatus:NO popUpView:popInView];
        }
        if (cancel) {
            cancel();
        }
    }];
    [pickerController setDidSelectAssets:^(NSArray <DKAsset *> *assets) {
        if (hidePopView) {
            [AZViewUtil setPopViewStatus:NO popUpView:popInView];
        }
        if (assets.count > 0) {
            NSMutableArray *mutImageArr = [[NSMutableArray alloc] init];
            NSMutableArray *mutImageLocationArr = [[NSMutableArray alloc] init];
            [assets enumerateObjectsUsingBlock:^(DKAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (needLocation) {
                    CLLocation *location = obj.originalAsset.location;
                    if (!location) {
                        location = [[CLLocation alloc] init];
                    }
                    [mutImageLocationArr addObject:location];
                }
                
                [obj fetchFullScreenImage:YES completeBlock:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
                    [mutImageArr addObject:image];
                }];
            }];
            if (callBack) {
                callBack(mutImageArr, mutImageLocationArr);
            }
        } else {
            if (cancel) {
                cancel();
            }
        }
    }];
    if (hidePopView) {
        [AZViewUtil setPopViewStatus:YES popUpView:popInView];
    }
    UINavigationController *naviVC = [AZAppUtil getTopMostNavigationController];
    [naviVC presentViewController:pickerController animated:YES completion:nil];
}

+ (DKImagePickerController *)getDKImagePickerController:(NSInteger)maxNum {
    DKImagePickerController *pickerController = [DKImagePickerController new];
    pickerController.assetType = DKImagePickerControllerAssetTypeAllPhotos;
    pickerController.showsCancelButton = YES;
    pickerController.showsEmptyAlbums = YES;
    pickerController.allowMultipleTypes = NO;
    pickerController.defaultSelectedAssets = @[];
    pickerController.sourceType = DKImagePickerControllerSourceTypeBoth;
    pickerController.maxSelectableCount = maxNum;
    return pickerController;
}

+ (void)updateViewBoarder:(UIView *)view width:(NSInteger)width rgbColor:(NSInteger)rgb {
    view.layer.borderWidth = width;
    view.layer.borderColor = [[AZColorUtil getColor:rgb] CGColor];
}

+ (void)updateViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)cornerRadius {
    view.layer.cornerRadius = cornerRadius;
    [view.layer setMasksToBounds:YES];
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

+ (void)updateViewCircular:(UIView *)view {
    [AZViewUtil updateViewCornerRadius:view cornerRadius:view.frame.size.height/2];
}

+ (void)updateShowMJRefresh:(MJRefreshHeader *)header footer:(MJRefreshFooter *)footer selfOrderStr:(NSString *)selfOrderStr orderStr:(NSString *)orderStr error:(NSError *)error {
    if (header) {
        [header endRefreshing];
    }
    if (footer) {
        if ([selfOrderStr isEqualToString:orderStr]) {
            [footer endRefreshingWithNoMoreData];
        } else {
            [footer endRefreshing];
        }
        if (error) {
            [footer endRefreshingWithNoMoreData];
        }
    }
}

+ (void)updateShowBlankView:(UIView *)blankView tableViewFooter:(UIView *)footer contentArr:(NSArray *)contentArr {
    if ([AZArrayUtil isValidArray:contentArr]) {
        blankView.hidden = YES;
        footer.hidden = NO;
    } else {
        blankView.hidden = NO;
        footer.hidden = YES;
    }
}

+ (void)updateNavigationBarBackgroundWhite:(UINavigationBar *)naviBar {
    [naviBar setBackgroundImage:[AZImageUtil getImageFromColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}

+ (void)updateNavigationBarBackgroundDuckrColor:(UINavigationBar *)naviBar {
    [naviBar setBackgroundImage:[AZImageUtil getImageFromColor:[AZColorUtil getColor:AZColorAppDuckr]] forBarMetrics:UIBarMetricsDefault];
    [naviBar setTintColor:[AZColorUtil getColor:AZColorNaviFontDefault]];
}

+ (void)updateNavigationBarBackgroundPhotoShow:(UINavigationBar *)naviBar {
    [naviBar setBackgroundImage:[AZImageUtil getImageFromColor:[AZColorUtil getColorByRgba:0x000000 alpha:0.5]] forBarMetrics:UIBarMetricsDefault];
}

+ (void)updateNavigationBarBackgroundTranslucent:(UINavigationBar *)naviBar {
    [naviBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}

+ (void)setPopViewStatus:(BOOL)hide popUpView:(UIView *)popUpView {
    while (![popUpView isKindOfClass:[KLCPopup class]]) {
        popUpView = popUpView.superview;
    }
    popUpView.hidden = hide;
}

+ (BOOL)isView:(UIView *)view inContainerView:(UIView *)containerView {
    CGRect rect = [view convertRect:view.frame fromView:containerView];
    CGFloat x = rect.origin.x;
    if (x > view.frame.size.width / 3 || x < - containerView.frame.size.width + view.frame.size.width * 2 / 3) {
        return NO;
    }
    CGFloat y = rect.origin.y;
    if (y > view.frame.size.height / 3 || y < - containerView.frame.size.height + view.frame.size.height * 2 / 3) {
        return NO;
    }
    return YES;
}


+ (void)updateScrollViewScrollToBottom:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentSize.height - scrollView.frame.size.height;
    if (y <= 0) {
        return;
    }
    [scrollView setContentOffset:CGPointMake(0.0f, y) animated:YES];
}


@end
