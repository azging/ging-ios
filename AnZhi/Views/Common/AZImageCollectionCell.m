//
//  AZImageCollectionCell.m
//  AnZhi
//
//  Created by LHJ on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZImageCollectionCell.h"
#import "AZViewUtil.h"

@implementation AZImageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateImageCollectionCell:(NSString *)photoUrl {
    [AZViewUtil updateCoverImageView:self.imageView url:photoUrl];
}

@end
