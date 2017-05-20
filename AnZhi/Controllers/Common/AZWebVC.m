//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZWebVC.h"
#import "AZUtil.h"
#import "AZConstant.h"
#import "AZDataManager.h"
#import "AZRegisterHelper.h"
#import "AZSwitcherUtil.h"
#import "AZPayHelper.h"

@interface AZWebVC () <UIWebViewDelegate, AZPayHelperDelegate>


@property (weak, nonatomic) IBOutlet UILabel *titleLabelForUserPolicy;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *naviBarForUserPolicy;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewTopConstraint;

@end

@implementation AZWebVC

+ (instancetype)createInstance {
    return (AZWebVC *)[AZStoryboardUtil getViewController:SBNameCommon identifier:VCIDWebVC];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [AZAlertUtil hideHud];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];
    [self initNaviBar];
}

- (void)initWebView {
    if ([AZStringUtil isNotNullString:self.webUrlStr]) {
        NSURL *url = [NSURL URLWithString:self.webUrlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)initNaviBar {
    if (self.isShowForUserPolicy) {
        self.naviBarForUserPolicy.hidden = NO;
        self.titleLabelForUserPolicy = self.titleLabelForUserPolicy;
    } else {
        [self.naviBarForUserPolicy removeFromSuperview];
    }
}

#pragma mark - UIWebview Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [AZAlertUtil showHudWithHint:nil inView:self.webView enableUserInteraction:NO];
    
    // hide hud after 3s, incase webview don't callback "webViewDidFinishLoad"  "didFailLoadWithError"
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AZAlertUtil hideHud];
    });
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [AZAlertUtil hideHud];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.webView.scrollView.contentSize = CGSizeMake([AZAppUtil getDeviceWidth], [AZAppUtil getDeviceHeight] - 64);
    
    for (UIView *subView in self.webView.scrollView.subviews) {
        if ([[subView class] isSubclassOfClass: NSClassFromString(@"UIWebBrowserView")]) {
            CGRect frame = subView.frame;
            frame.size = self.webView.scrollView.contentSize;
            subView.frame = frame;
            break;
        }
    }

    [AZAlertUtil hideHud];
}

#pragma mark - button Actions


- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view removeFromSuperview];
}

- (void)dealloc {
    [self.view removeFromSuperview];
}

@end
