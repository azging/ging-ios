//
//  AZQuestionCell.h
//  AnZhi
//
//  Created by LHJ on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZBaseView.h"


@class AZQuestionWrapper;
@class AZShareView;

@protocol AZShareViewDelegate <NSObject>
@optional
- (void)cancelShareAction:(AZShareView *)view;

@end

@interface AZShareView : AZBaseView

- (void)updateShareView:(AZQuestionWrapper *)wrapper;
- (CGFloat)getShareViewHeight;

- (IBAction)shareWechatAction:(id)sender;
- (IBAction)shareWxTimeLineAction:(id)sender;

@property (strong, nonatomic) AZQuestionWrapper *wrapper;
@property (strong, nonatomic) id<AZShareViewDelegate> delegate;

@end
