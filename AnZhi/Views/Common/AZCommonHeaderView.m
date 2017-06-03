//
//  AZCommonHeaderView.m
//  AnZhi
//
//  Created by LHJ on 2017/6/3.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZCommonHeaderView.h"

@implementation AZCommonHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateShowCommonHeader:(NSString *)title {
    self.titleLabel.text = title;
}

@end
