//
//  AZRegisterVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAutoRefreshVC.h"

@interface AZCommonPhotoShowVC : AZAutoRefreshVC

// 传图片ImageModelArr
- (void)showImageModelArr:(NSArray *)imageModelArr index:(NSInteger)index;
// 传图片arr
- (void)showImageArr:(NSArray *)imageArr index:(NSInteger)index;

- (void)showTopView;

@end
