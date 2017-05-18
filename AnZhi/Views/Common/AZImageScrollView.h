//
//  AppDelegate.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZImageScrollViewDelegate;

@interface AZImageScrollView : UITableViewCell

+ (instancetype)createInstance;
- (void)updateShowImageScrolAZell:(NSArray *)imageModelArr;
- (void)startAutoImageScroll;
- (void)stopImageScroll;

- (void)updateShowBannerScrolAZell:(NSArray *)themeBannerModelArr;

@property (weak, nonatomic) id<AZImageScrollViewDelegate> delegate;
@property (assign, nonatomic) BOOL isAutoScrolling;
@property (assign, nonatomic) NSInteger showingPageIndex;

@end

@protocol AZImageScrollViewDelegate <NSObject>
@optional
- (void)imageScrolAZell:(AZImageScrollView *)cell didSelectTopListIndex:(NSInteger)topListIndex;

@end
