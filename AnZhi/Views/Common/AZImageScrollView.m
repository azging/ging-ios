//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZImageScrollView.h"
#import "AZArrayUtil.h"
#import "AZImageModel.h"
#import "UIImageView+AFNetworking.h"
#import "AZUtil.h"
#import "AZColorConstant.h"
#import <Masonry/Masonry.h>

const static NSInteger AZImageScorlAZellTimeInterval = 3.0f;
//static const CGFloat AZImageScorlAZellViewHeight = 205.0f;

@interface AZImageScrollView() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *imageModelArr;
@property (strong, nonatomic) NSArray *bannerModelArr;
@property (assign, nonatomic) BOOL scrollBannerList;

@end

@implementation AZImageScrollView

+ (instancetype)createInstance {
    return (AZImageScrollView *)[AZViewUtil getViewFromXib:[AZImageScrollView class]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
}

- (void)updateShowImageScrolAZell:(NSArray *)imageModelArr {
    [self setImageModelArr:imageModelArr];
    [self startAutoImageScroll];
}


- (void)setImageModelArr:(NSArray *)imageModelArr {
    [self layoutIfNeeded];
    if ([AZArrayUtil isSameArr:self.imageModelArr compareArr:imageModelArr]) {
        return;
    }
    _imageModelArr = imageModelArr;
    
    if ([AZArrayUtil isValidArray:imageModelArr] && imageModelArr.count > 1) {
        self.scrollView.scrollEnabled = YES;
    } else {
        self.scrollView.scrollEnabled = NO;
    }
    
    [self updateShow];
}

- (void)startAutoImageScroll {
    if (self.isAutoScrolling) {
        [self stopImageScroll];
    }
    
    self.isAutoScrolling = YES;
    [self performSelector:@selector(autoScroll) withObject:nil afterDelay:AZImageScorlAZellTimeInterval];
}

- (void)stopImageScroll {
    if (self.isAutoScrolling) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScroll) object:nil];
    }
}

- (void)autoScroll {
    if (1 == self.imageModelArr.count) {
        return ;
    }
    NSInteger pageIndex = [self getPageIndex];
    
    if (pageIndex >= self.imageModelArr.count + 1) {
        pageIndex = 1;
    }
    
    if (pageIndex <= 0) {
        pageIndex = self.imageModelArr.count;
    }
    [self.scrollView scrollRectToVisible:CGRectMake(pageIndex * [AZAppUtil getDeviceWidth], 0, self.scrollView.frame.size.width, self.frame.size.height) animated:NO];
    
    // 动画滚到下一页 animated要设为YES，其余的为NO
    [self.scrollView scrollRectToVisible:CGRectMake((pageIndex + 1) * [AZAppUtil getDeviceWidth], 0, self.scrollView.frame.size.width, self.frame.size.height) animated:YES];
    
    // 如果动画滚完后在第n+2页，跳到首页
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger pageIndex = [self getPageIndex];
        if (pageIndex >= self.imageModelArr.count + 1) {
            pageIndex = 1;
        }
        
        if (pageIndex <= 0) {
            pageIndex = self.imageModelArr.count;
        }
        [self.scrollView scrollRectToVisible:CGRectMake(pageIndex * [AZAppUtil getDeviceWidth], 0, self.scrollView.frame.size.width, self.frame.size.height) animated:NO];
    });
    
    // 下方小圆点更新显示为下一页
    pageIndex++;
    if (pageIndex >= self.imageModelArr.count + 1) {
        pageIndex = 1;
    }
    
    if (pageIndex > 0) {
        self.pageControl.currentPage = pageIndex - 1;
    } else {
        self.pageControl.currentPage = 0;
    }
    
    self.showingPageIndex = self.pageControl.currentPage;
    // 一段时间后，进行下一次自动滚
    [self performSelector:@selector(autoScroll) withObject:nil afterDelay:AZImageScorlAZellTimeInterval];
}

- (void)addScrollViewImageView:(AZImageModel *)model withIndex:(NSInteger)index {
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.tag = 111111;
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).with.offset(index * [AZAppUtil getDeviceWidth]);
        make.top.equalTo(self.scrollView.mas_top);
        make.width.equalTo(self.scrollView.mas_width);
        make.height.equalTo(self.scrollView.mas_height);
    }];

    UIEdgeInsets padding = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:containerView.bounds];
    [AZViewUtil updateCoverImageView:imageView url:model.imageUrlThumb];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [containerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(containerView).with.insets(padding);
    }];

    
    UIButton *button = [[UIButton alloc] initWithFrame:containerView.bounds];
    button.tag = index;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(containerView).with.insets(padding);
    }];;
}

- (void)updateShow {
    for (UIView *view in self.scrollView.subviews) {
        if (111111 == view.tag) {
            [view removeFromSuperview];
        }
    }

    /// 前面多加一个按钮，就于右滑循环滚动.
    if (self.imageModelArr && self.imageModelArr.count > 0) {
        AZImageModel *imageModel = (AZImageModel *)[self.imageModelArr lastObject];
        [self addScrollViewImageView:imageModel withIndex:0];
    }
    
    [self.imageModelArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AZImageModel *imageModel = (AZImageModel *)obj;
        [self addScrollViewImageView:imageModel withIndex:(idx + 1)];
    }];
    
    /// 再多加一个按钮，就于最后一张左滑循环滚动.
    if (self.imageModelArr && self.imageModelArr.count > 0) {
        AZImageModel *imageModel = (AZImageModel *)[self.imageModelArr firstObject];
        [self addScrollViewImageView:imageModel withIndex:(self.imageModelArr.count + 1)];
    }
    
    CGFloat height = self.scrollView.frame.size.height;
    if (height > 300) {
        height = 100.0f;
    }
    self.scrollView.contentSize = CGSizeMake((self.imageModelArr.count + 2) * [AZAppUtil getDeviceWidth], height);
    [self layoutIfNeeded];
    self.scrollView.delegate = self;
    
    if (self.imageModelArr.count <= 1) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
    self.pageControl.numberOfPages = self.imageModelArr.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    // 只有存在page时，才有currentPageIndicator，否则设置self.pageControl.currentPageIndicatorTintColor会导致崩溃
    if (self.pageControl.numberOfPages > 0) {
        self.pageControl.currentPageIndicatorTintColor = [AZColorUtil getColor:AZColorAppDuckr];
    }
    
//    [self.scrollView scrollRectToVisible:CGRectMake([AZAppUtil getDeviceWidth], 0, self.scrollView.frame.size.width, self.frame.size.height) animated:NO];
    self.scrollView.contentOffset = CGPointMake([AZAppUtil getDeviceWidth], 0);
}

- (void)buttonAction:(UIButton *)sender {
    NSInteger index = sender.tag - 1;
    index = [self getIndex:index];
    if ([self.delegate respondsToSelector:@selector(imageScrolAZell:didSelectTopListIndex:)]) {
        [self.delegate imageScrolAZell:self didSelectTopListIndex:index];
    }
}

- (NSInteger)getIndex:(NSInteger)index {
    if (index < 0) {
        index += self.imageModelArr.count;
    } else if (index >= self.imageModelArr.count) {
        index -= self.imageModelArr.count;
    }
    return index;
}

- (NSInteger)getPageIndex {
    float offsetX = self.scrollView.contentOffset.x;
    NSInteger pageIndex = (offsetX + 10) / [AZAppUtil getDeviceWidth];
    return pageIndex;
}


# pragma mark - UIScorllView Delegate
// 结束减速后
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex = [self getPageIndex];
    
    if (pageIndex >= self.imageModelArr.count + 1) {
        pageIndex = 1;
    }
    
    if (pageIndex <= 0) {
        pageIndex = self.imageModelArr.count;
    }
    [scrollView scrollRectToVisible:CGRectMake(pageIndex * [AZAppUtil getDeviceWidth], 0, scrollView.frame.size.width, 10.0f) animated:NO];
    
    if (pageIndex > 0) {
        self.pageControl.currentPage = pageIndex - 1;
    } else {
        self.pageControl.currentPage = 0;
    }
    
    // 如果用户操作了，并且正在自动滚，重新对自动滚进行计时
    if (self.isAutoScrolling) {
        [self startAutoImageScroll];
    }
}

@end
