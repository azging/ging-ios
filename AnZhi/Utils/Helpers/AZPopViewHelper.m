//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZPopViewHelper.h"
#import "AZAppUtil.h"
#import <KLCPopup/KLCPopup.h>
#import "AZConstant.h"
#import "AZAlertUtil.h"
#import "AZShareView.h"
#import "AZQuestionWrapper.h"

@interface AZPopViewHelper() <AZShareViewDelegate>
@property (strong, nonatomic) KLCPopup *commonPopup;

@end

@implementation AZPopViewHelper

+ (instancetype)sharedInstance {
    static AZPopViewHelper *staticInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[AZPopViewHelper alloc] init];
    });
    return staticInstance;
}

- (void)dismissPopupView {
    [self.commonPopup dismissPresentingPopup];
}

- (void)cancelButtonClick {
    [self.commonPopup dismissPresentingPopup];
}


- (void)popSocailShareView:(AZQuestionWrapper *)wrapper {
    AZShareView *shareView = [AZShareView createInstance];
    shareView.delegate = self;
    [shareView updateShareView:wrapper];
    self.commonPopup = [KLCPopup popupWithContentView:shareView
                                             showType:KLCPopupShowTypeBounceInFromBottom
                                          dismissType:KLCPopupDismissTypeBounceOutToBottom
                                             maskType:KLCPopupMaskTypeDimmed
                             dismissOnBackgroundTouch:YES
                                dismissOnContentTouch:NO];
    self.commonPopup.dimmedMaskAlpha = AZAlertViewMaskAlpha;
    CGFloat topSpace = [AZAppUtil getDeviceHeight] - [shareView getShareViewHeight] / 2.0f;
    [self.commonPopup showAtCenter:CGPointMake([AZAppUtil getDeviceWidth] / 2, topSpace) inView:nil];
}

- (void)cancelShareAction:(AZShareView *)view {
    [self dismissPopupView];
}

@end
