//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface AZViewUtil : NSObject

+ (void)removeAllSubViews:(UIView *)view;
+ (UIView *)getViewFromXib:(Class)class;

+ (void)updateAvatarImageView:(UIImageView *)imageView url:(NSString *)url;
+ (void)updateCoverImageView:(UIImageView *)imageView url:(NSString *)url;
+ (void)updateImageView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl imageThumbUrl:(NSString *)imageThumbUrl placeholderImageName:(NSString *)placeholderImageName;

+ (void)updateGenderImageView:(UIImageView *)genderImageView gender:(NSInteger)gender;
+ (void)updateViewBoarder:(UIView *)view width:(NSInteger)width rgbColor:(NSInteger)rgb;
+ (void)updateViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)cornerRadius;
+ (void)updateViewCircular:(UIView *)view;

+ (void)pickPhotos:(NSInteger)maxNum callBack:(void(^)(NSArray *imageArr))callBack cancel:(void(^)())cancel;

+ (void)updateShowMJRefresh:(MJRefreshHeader *)header footer:(MJRefreshFooter *)footer selfOrderStr:(NSString *)selfOrderStr orderStr:(NSString *)orderStr error:(NSError *)error;
+ (void)updateShowBlankView:(UIView *)blankView tableViewFooter:(UIView *)footer contentArr:(NSArray *)contentArr;

+ (void)updateNavigationBarBackgroundTranslucent:(UINavigationBar *)naviBar;
+ (void)updateNavigationBarBackgroundPhotoShow:(UINavigationBar *)naviBar;
+ (void)updateNavigationBarBackgroundWhite:(UINavigationBar *)naviBar;
+ (void)updateNavigationBarBackgroundAPPColor:(UINavigationBar *)naviBar;

+ (void)setPopViewStatus:(BOOL)hide popUpView:(UIView *)popUpView;

+ (BOOL)isView:(UIView *)view inContainerView:(UIView *)containerView;

+ (void)updateScrollViewScrollToBottom:(UIScrollView *)scrollView;

@end
