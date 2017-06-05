//
//  AZQuestionCell.h
//  AnZhi
//
//  Created by LHJ on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZShareView.h"
#import "AZUtil.h"
#import <KLCPopup/KLCPopup.h>
#import "AZUMengHelper.h"
#import "AZQuestionWrapper.h"

@interface AZShareView()

@end

@implementation AZShareView

+ (instancetype)createInstance {
    return (AZShareView *)[AZViewUtil getViewFromXib:[AZShareView class]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CGRect bounds = self.bounds;
    bounds.size.width = [AZAppUtil getDeviceWidth];
    self.bounds = bounds;
    [self layoutIfNeeded];
}

- (CGFloat)getShareViewHeight {
    return 179.0f;
}

- (void)updateShareView:(AZQuestionWrapper *)wrapper {
    self.wrapper = wrapper;
}

- (IBAction)shareWechatAction:(id)sender {
    [self shareToSocial:UMSocialPlatformType_WechatSession];
}

- (IBAction)shareWxTimeLineAction:(id)sender {
    [self shareToSocial:UMSocialPlatformType_WechatTimeLine];
}

- (IBAction)cancelAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelShareAction:)]) {
        [self.delegate cancelShareAction:self];
    }
}

- (void)shareToSocial:(UMSocialPlatformType)type {
    UMSocialMessageObject *messageObject = [self getShareMessageObject];
    if (nil == messageObject) {
        [AZAlertUtil tipOneMessage:@"请等待加载完后再分享"];
        return;
    }
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        [self cancelAction:nil];
        if (!error) {
//            [self cancelAction:nil];
        } else {
            if (error.code == 2009) {
                [AZAlertUtil tipOneMessage:@"取消分享"];
            } else {
                [AZAlertUtil tipOneMessage:@"分享失败"];
            }
        }
    }];
}

- (UMSocialMessageObject *)getShareMessageObject {
    id image = [self getShareImage];
    if (image == nil) {
        return nil;
    }
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *imgObj = [[UMShareImageObject alloc] init];
    imgObj.shareImage = image;
    messageObject.shareObject = imgObj;
    return messageObject;
}

- (NSString *)getShareTitle {
    return self.wrapper.questionModel.title;
}

- (NSString *)getShareContent {
    return self.wrapper.questionModel.desc;
}

- (id)getShareImage {
    NSString *url = self.wrapper.questionModel.shareImageUrl;

    if ([AZStringUtil isNotNullString:url]) {
        return url;
    } else {
        return nil;
    }
//    return [UIImage imageNamed:@"CommonAppIcon"];
}

@end

