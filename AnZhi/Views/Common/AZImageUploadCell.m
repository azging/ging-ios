//
//  AZImageUploadCell.m
//  LinkCity
//
//  Created by zzs on 2016/10/12.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import "AZImageUploadCell.h"

@interface AZImageUploadCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AZImageUploadCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateShowPhotoPublishImageCell:(UIImage *)image indexPath:(NSIndexPath *)indexPath delegate:(id<AZImageUploadCellDelegate>)delegate {
    self.imageView.image = image;
    self.delegate = delegate;
    self.indexPath = indexPath;
}

- (IBAction)photoDeleteButtonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageDeleteAction:)]) {
        [self.delegate imageDeleteAction:self.indexPath];
    }
}
@end
