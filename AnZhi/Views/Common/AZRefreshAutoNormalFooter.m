//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZRefreshAutoNormalFooter.h"
#import "AZUtil.h"

@interface AZRefreshAutoNormalFooter()

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation AZRefreshAutoNormalFooter

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.color = [AZColorUtil getColor:AZColorApp];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)prepare {
    [super prepare];
    self.stateLabel.textColor = [AZColorUtil getColor:0x7d7975];
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

@end
