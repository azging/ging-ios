//
//  AZQuestionCell.h
//  AnZhi
//
//  Created by LHJ on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZTopTabView.h"
#import "AZConstant.h"
#import "AZColorUtil.h"
#import "AZAppUtil.h"

#define AZTabViewNormalTextColor AZColorFontDefault
#define AZTabViewSelectedTextColor AZColorApp

//static const NSInteger AZTabViewNormalTextColor = 0xff841e;
//static const NSInteger AZTabViewSelectedTextColor = 0x2c2a28;
static const CGFloat AZTabViewMarkImageHeight = 3.0f;
static const CGFloat AZTabViewAnimationTime = 0.1f;

@interface AZTopTabView()

@property (assign, nonatomic) CGFloat margin;
@property (strong, nonatomic) NSMutableArray *buttonMutArr;
@property (strong, nonatomic) UIImageView *markImageView;

@end

@implementation AZTopTabView

+ (instancetype)createInstance {
    AZTopTabView *tabView = [[AZTopTabView alloc] initWithFrame:CGRectZero];
    tabView.backgroundColor = [UIColor whiteColor];
    return tabView;
}

- (NSInteger)getTabTotalCount {
    return self.buttonMutArr.count;
}

- (CGFloat)getMarkImageWidth {
    return self.frame.size.width / [self getTabTotalCount] * 2 / 3;
}

- (void)updateTitles:(NSArray *)titleArr withMargin:(CGFloat)margin {
    self.margin = margin;
    
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
    if (nil == titleArr || titleArr.count <= 0) {
        return;
    }
    
    CGFloat btnWidth = (self.frame.size.width - 2 * margin) / titleArr.count;
    self.buttonMutArr = [[NSMutableArray alloc] initWithCapacity:titleArr.count];
    [titleArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *title = (NSString *)obj;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(margin + btnWidth * idx, 0, btnWidth, self.frame.size.height)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont fontWithName:AZFontNameDefault size:[self getFontSizeDeselected]];
        [self.buttonMutArr addObject:btn];
        [self addSubview:btn];
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5f, self.frame.size.width, 0.5f)];
    lineView.backgroundColor = [AZColorUtil getColor:AZColorViewSplitLine];
    [self addSubview:lineView];
    
    self.markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 3.0f, [self getMarkImageWidth], AZTabViewMarkImageHeight)];
    self.markImageView.layer.masksToBounds = YES;
    self.markImageView.contentMode = UIViewContentModeScaleToFill;
    self.markImageView.image = [UIImage imageNamed:@"TopTabMarkLine"];
    [self addSubview:self.markImageView];
    
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    splitLine.backgroundColor = [AZColorUtil getColor:AZColorViewSplitLine];
    [self addSubview:splitLine];
    [self updateShow];
}

- (void)updateShow {
    [UIView animateWithDuration:AZTabViewAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGFloat btnWidth = (self.frame.size.width - 2 * self.margin) / self.buttonMutArr.count;
        CGRect markViewFrame = self.markImageView.frame;
        markViewFrame.origin.x = self.margin + self.selectIndex * btnWidth + (btnWidth - [self getMarkImageWidth]) / 2.0f;
        self.markImageView.frame = markViewFrame;
    } completion:nil];
    
    [self.buttonMutArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = (UIButton *)obj;
        
        [UIView transitionWithView:btn duration:AZTabViewAnimationTime options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut animations:^{
            if (idx == self.selectIndex) {
                [btn setTitleColor:[AZColorUtil getColor:AZTabViewSelectedTextColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:AZFontNameDefault size:[self getFontSizeSelected]];
            } else {
                [btn setTitleColor:[AZColorUtil getColor:AZTabViewNormalTextColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:AZFontNameDefault size:[self getFontSizeDeselected]];
            }
        } completion:nil];
    }];
}

- (CGFloat)getFontSizeSelected {
    CGFloat fontSize = 17.0f;
    if ([AZAppUtil isIPhone4Or4S] || [AZAppUtil isIPhone5Or5S]) {
        fontSize = 14.0f;
    }
    return fontSize;
}

- (CGFloat)getFontSizeDeselected {
    CGFloat fontSize = 15.0f;
    if ([AZAppUtil isIPhone4Or4S] || [AZAppUtil isIPhone5Or5S]) {
        fontSize = 12.0f;
    }
    return fontSize;
}

- (void)buttonAction:(UIButton *)sender {
    [self.buttonMutArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = (UIButton *)obj;
        if (btn == sender) {
            self.selectIndex = idx;
            if ([self.delegate respondsToSelector:@selector(topTabView:didSelectIndex:)]) {
                [self.delegate topTabView:self didSelectIndex:idx];
            }
        }
    }];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    
    [self updateShow];
}

@end
