//
//  AZImageUploadCell.h
//  LinkCity
//
//  Created by zzs on 2016/10/12.
//  Copyright © 2016年 张宗硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZImageUploadCellDelegate;
@interface AZImageUploadCell : UICollectionViewCell

@property (weak, nonatomic) id<AZImageUploadCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (void)updateShowPhotoPublishImageCell:(UIImage *)image indexPath:(NSIndexPath *)indexPath delegate:(id<AZImageUploadCellDelegate>)delegate;

@end

@protocol AZImageUploadCellDelegate <NSObject>

- (void)imageDeleteAction:(NSIndexPath *)indexPath;

@end
