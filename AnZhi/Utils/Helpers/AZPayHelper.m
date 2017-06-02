//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZPayHelper.h"
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "AZConstant.h"
#import "AZUtil.h"
#import "PayRequsestHandler.h"
#import "AZNetRequester+Order.h"

static NSString * const AZPayHelperWxKey = @"21b7c851bbad3e0edd477718d59b0de7";

@interface AZPayHelper()

@property (strong, nonatomic) AZWxPrepayModel *wxPrepayModel;

@end

@implementation AZPayHelper

- (instancetype)initWithDelegate:(id<AZPayHelperDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self addObserver];
    }
    return self;
}

- (AZWxPrepayModel *)wxPrepayModel {
    return self.orderWrapper.wxPrepayModel;
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:NotificationWxPay object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationWxPay object:nil];
}

- (void)dealloc {
    [self removeObserver];
}

- (void)callWxPay:(NSString *)quid
             auid:(NSString *)auid
           amount:(CGFloat)amount
      paymentType:(AZOrderPaymentType)paymentType
        tradeType:(AZOrderTradeType)tradeType {
    [AZAlertUtil tipOneMessage:@"正在支付"];
    [AZNetRequester requestAddOrder:quid auid:auid amount:amount paymentType:paymentType tradeType:tradeType callBack:^(AZOrderWrapper *orderWrapper, NSError *error) {
        [AZAlertUtil hideHud];
        if (!error) {
            self.orderWrapper = orderWrapper;
            if (self.orderWrapper.orderModel.amount > 0) {
                [self doWxPay];
            } else {
                [AZAlertUtil tipOneMessage:@"订单金额有误，请重试"];
            }
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
}

- (void)doWxPay {
    //创建支付签名对象
    PayRequsestHandler *reqh = [PayRequsestHandler alloc];
    //初始化支付签名对象
    [reqh init:self.wxPrepayModel.appId mch_id:self.wxPrepayModel.mchId];
    //设置密钥
    [reqh setKey:AZPayHelperWxKey];
    
    NSString    *package, *time_stamp, *nonce_str;
    //设置支付参数
    time_t now;
    time(&now);
    time_stamp  = [NSString stringWithFormat:@"%ld", now];
    nonce_str	= [WXUtil md5:time_stamp];
    //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
    //package       = [NSString stringWithFormat:@"Sign=%@",package];
    package         = @"Sign=WXPay";
    //第二次签名参数列表
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject: self.wxPrepayModel.appId        forKey:@"appid"];
    [signParams setObject: nonce_str    forKey:@"noncestr"];
    [signParams setObject: package      forKey:@"package"];
    [signParams setObject: self.wxPrepayModel.mchId        forKey:@"partnerid"];
    [signParams setObject: time_stamp   forKey:@"timestamp"];
    [signParams setObject: self.wxPrepayModel.prepayId     forKey:@"prepayid"];
    //生成签名
    NSString *sign  = [reqh createMd5Sign:signParams];
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = self.wxPrepayModel.appId;
    req.nonceStr            = nonce_str;
    req.package             = package;
    req.partnerId           = self.wxPrepayModel.mchId;
    req.prepayId            = self.wxPrepayModel.prepayId;
    req.timeStamp           = [time_stamp intValue];
    req.sign                = sign;
    
    [WXApi sendReq:req];
}


- (void)notificationAction:(NSNotification *)notify {
    if ([notify.name isEqualToString:NotificationWxPay]) {
        // 前端微信支付结果的通知
        id resp = [notify.userInfo objectForKey:NotificationWxPayResultKey];
        if([resp isKindOfClass:[PayResp class]]){
            PayResp *payResp = (PayResp *)resp;
            switch (payResp.errCode) {
                case WXSuccess: {
                    NSLog(@"支付成功－PaySuccess，retcode = %d", payResp.errCode);
                    [self clientDidPaySucceed];
                }
                    break;
                default: {
                    NSLog(@"错误，retcode = %d, retstr = %@", payResp.errCode, payResp.errStr);
                    [AZAlertUtil tipOneMessage:@"支付失败"];
                }
                    break;
            }
        }
    }
}

- (void)clientDidPaySucceed {
    [AZAlertUtil tipOneMessage:@"支付成功!"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentHelper:didPaySucceed:order:error:)]) {
        [self.delegate paymentHelper:self didPaySucceed:YES order:self.orderWrapper error:nil];
    }
}


//#pragma mark - WxPay Delegate
//
//-(void)onResp:(BaseResp*)resp {
//    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//    NSString *strTitle;
//    
//    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
//        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//    }
//    if ([resp isKindOfClass:[PayResp class]]) {
//        // 支付返回结果，实际支付结果需要去微信服务器端查询
//        strTitle = [NSString stringWithFormat:@"支付结果"];
//        
//        switch (resp.errCode) {
//            case WXSuccess:
//                strMsg = @"支付结果：成功！";
//                //                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                break;
//                
//            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode, resp.errStr];
//                //                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode, resp.errStr);
//                break;
//        }
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWxPay object:nil userInfo:@{NotificationWxPayResultKey:resp}];
//    }
//}

@end
