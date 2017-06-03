//
//  AZCommonHeaderView.h
//  AnZhi
//
//  Created by LHJ on 2017/6/3.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZCommonHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)updateShowCommonHeader:(NSString *)title;

@end
