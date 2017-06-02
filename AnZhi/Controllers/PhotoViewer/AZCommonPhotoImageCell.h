//
//  AZRegisterVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZImageModel.h"

@interface AZCommonPhotoImageCell : UICollectionViewCell

- (UIImage *)getImageCellImage;
- (AZImageModel *)getImageCellImageModel;

- (void)updateShowPhotoImageCell:(UIImage *)image;
- (void)updateShowPhotoImageImageModel:(AZImageModel *)imageModel;
- (void)restoreInitState;

@end
