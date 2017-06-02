//
//  AZRegisterVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZCommonPhotoImageCell.h"
#import "AZDetailPhotoView.h"

@interface AZCommonPhotoImageCell()

@property (weak, nonatomic) IBOutlet AZDetailPhotoView *detailPhotoView;

@end

@implementation AZCommonPhotoImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (UIImage *)getImageCellImage {
    return [self.detailPhotoView getDetailViewImage];
}

- (AZImageModel *)getImageCellImageModel {
    return [self.detailPhotoView getDetailViewImageModel];
}

- (void)updateShowPhotoImageCell:(UIImage *)image {
    self.detailPhotoView.imageSource = image;
    [self.detailPhotoView updateImageView:nil];
}

- (void)updateShowPhotoImageImageModel:(AZImageModel *)imageModel {
    if (imageModel) {
        [self.detailPhotoView updateImageView:imageModel];
    }
}

- (void)restoreInitState {
    [self.detailPhotoView restoreInitState];
}

@end
