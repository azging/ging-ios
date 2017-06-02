//
//  AZQuestionCell.h
//  AnZhi
//
//  Created by LHJ on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZTopTabViewDelegate;

@interface AZTopTabView : UIView

+ (instancetype)createInstance;
- (void)updateTitles:(NSArray *)titleArr withMargin:(CGFloat)margin;
- (NSInteger)getTabTotalCount;
@property (assign, nonatomic) NSInteger selectIndex;
@property (weak, nonatomic) id<AZTopTabViewDelegate> delegate;

@end

@protocol AZTopTabViewDelegate <NSObject>
@optional
- (void)topTabView:(AZTopTabView *)tabView didSelectIndex:(NSInteger)index;

@end
