//
//  AZRegisterVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZImageModel.h"
#import "MBProgressHUD.h"

@interface AZDetailPhotoView : UIView<UIScrollViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIImage *imageSource;
@property (nonatomic) UIImageView *imageView;

- (void)updateImageView:(AZImageModel *)imageModel;
- (void)restoreInitState;
- (UIImage *)getDetailViewImage;
- (AZImageModel *)getDetailViewImageModel;

@end
