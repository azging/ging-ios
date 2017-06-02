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
            [self cancelAction:nil];
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
    NSString *title = [self getShareTitle];
    NSString *descr = [self getShareContent];
    NSString *webpageUrl = [self getShareUrl];
    if ([AZStringUtil isNullString:title] || [AZStringUtil isNullString:webpageUrl]) {
        return nil;
    }
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *webObj = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:[self getShareImage]];
    webObj.webpageUrl = webpageUrl;
    messageObject.shareObject = webObj;
    messageObject.title = title;
    messageObject.text = [title stringByAppendingString:webpageUrl]; // 分享到微博的内容和链接
    return messageObject;
}

- (NSString *)getShareTitle {
    return self.wrapper.questionModel.title;
}

- (NSString *)getShareContent {
    return self.wrapper.questionModel.desc;
}

- (NSString *)getShareUrl {
    return @"www.azging.com";
}

- (id)getShareImage {
    NSString *url = @"";

    if ([AZStringUtil isNotNullString:url]) {
        return url;
    }
    return [UIImage imageNamed:@"AppIcon"];
}

@end

