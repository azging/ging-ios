//
//  AZImageCollectionCell.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZImageCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)updateImageCollectionCell:(NSString *)photoUrl;

@end
