//
//  AZPayHelper.m
//  LinkCity
//
//  Created by 张宗硕 on 08/10/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZPayHelper.h"
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "AZConstant.h"
#import "AZUtil.h"
#import "PayRequsestHandler.h"
#import "AZNetRequester.h"

static NSString * const AZPayHelperWxKey = @"21b7c851bbad3e0edd477718d59b0de7";

@interface AZPayHelper()

@property (strong, nonatomic) AZOrderModel *orderModel;
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

- (AZOrderModel *)orderModel {
    return self.orderWrapper.orderModel;
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:NotificationAliPay object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:NotificationWxPay object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationAliPay object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationWxPay object:nil];
}

- (void)dealloc {
    [self removeObserver];
}

- (void)callWxPay:(AZOrderTicketWrapper *)orderTicketWrapper addrUid:(NSString *)addrUid contact:(NSArray *)contactArr {
    [AZAlertUtil showHudWithHint:@"创建订单中..."];

}

- (void)callAliPay:(AZOrderTicketWrapper *)orderTicketWrapper addrUid:(NSString *)addrUid contact:(NSArray *)contactArr {
    [AZAlertUtil showHudWithHint:@"创建订单中..."];

}

- (void)callFreePay:(AZOrderTicketWrapper *)orderTicketWrapper {

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
//    [AZAlertUtil showHudWithHint:@"更新订单"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentHelper:didPaySucceed:order:error:)]) {
        [self.delegate paymentHelper:self didPaySucceed:YES order:self.orderModel error:nil];
    }

//    api/v6/sales/order/detail/
//    //第一次验证订单
//    [AZNetRequester planOrderQuery:self.partnerOrder.guid callBack:^(AZPartnerOrderModel *partnerOrder, NSError *error) {
//        if (error) {
//            //第二次验证订单
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [AZNetRequester planOrderQuery:self.partnerOrder.guid callBack:^(AZPartnerOrderModel *partnerOrder, NSError *error) {
//                    if (error) {
//                        //第三次验证订单
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                            [AZNetRequester planOrderQuery:self.partnerOrder.guid callBack:^(AZPartnerOrderModel *partnerOrder, NSError *error) {
//                                if (error) {
//                                    [YSAlertUtil hideHud];
//                                    [self serverDidOrderPayWithOrder:self.partnerOrder succeed:NO error:[NSError errorWithDomain:@"正在处理您的订单，请稍后重新进入本邀约详情查看订单状态" code:-1 userInfo:nil]];
//                                }else{
//                                    //Succeed
//                                    [YSAlertUtil hideHud];
//                                    [self serverDidOrderPayWithOrder:partnerOrder succeed:YES error:nil];
//                                }
//                            }];
//                        });
//                    }else{
//                        //Succeed
//                        [YSAlertUtil hideHud];
//                        [self serverDidOrderPayWithOrder:partnerOrder succeed:YES error:nil];
//                    }
//                }];
//            });
//        }else{
//            //Succeed
//            [YSAlertUtil hideHud];
//            [self serverDidOrderPayWithOrder:partnerOrder succeed:YES error:nil];
//        }
//    }];
}

//- (void)doWxPay:(AZWxPrepayModel *)prepayModel {
//    //============================================================
//    // V3&V4支付流程实现
//    // 注意:参数配置请查看服务器端Demo
//    // 更新时间：2015年11月20日
//    //============================================================
//    NSString *urlString = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURAZonnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if (response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.partnerId           = [dict objectForKey:@"partnerid"];
//                req.prepayId            = [dict objectForKey:@"prepayid"];
//                req.nonceStr            = [dict objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [dict objectForKey:@"package"];
//                req.sign                = [dict objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
////                return @"";
//            } else {
////                return [dict objectForKey:@"retmsg"];
//            }
//        } else {
////            return @"服务器返回错误，未获取到json对象";
//        }
//    } else {
////        return @"服务器返回错误";
//    }
//}

@end
