//
//  AZNetRequester+Order.m
//  AnZhi
//
//  Created by Mr.Positive on 2017/6/2.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZNetRequester+Order.h"
#import "AZOrderWrapper.h"


@implementation AZNetRequester (Order)

// 创建订单
+ (void)requestAddOrder:(NSString *)quid
                   auid:(NSString *)auid
                 amount:(CGFloat)amount
            paymentType:(AZOrderPaymentType)paymentType
              tradeType:(AZOrderTradeType)tradeType
               callBack:(void(^)(AZOrderWrapper *orderWrapper, NSError *error))callBack {
    
    quid = [AZStringUtil getNotNullStr:quid];
    auid = [AZStringUtil getNotNullStr:auid];
    
    NSDictionary *params = @{@"Quid":quid,
                             @"Auid":auid,
                             @"Amount":[NSNumber numberWithFloat:amount],
                             @"PaymentType":[NSNumber numberWithInteger:paymentType],
                             @"TradeType":[NSNumber numberWithFloat:tradeType],
                             };
    
    [[self createInstance] doPost:AZApiUriOrderAdd params:params requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (!error) {
                AZOrderWrapper *orderWrapper = [AZOrderWrapper modelWithDict:dataDic];
                callBack(orderWrapper, error);
            } else {
                callBack(nil, error);
            }
        }
    }];
}

// 订单详情
+ (void)requestOrderDetail:(NSString *)ouid callBack:(void (^)(AZOrderWrapper *, NSError *error))callBack {
    ouid = [AZStringUtil getNotNullStr:ouid];
    NSArray *paramArr = @[ouid];
    [[self createInstance] doGet:AZApiUriOrderDetail params:paramArr requestCallBack:^(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error) {
        if (callBack) {
            if (!error) {
                AZOrderWrapper *orderWrapper = [AZOrderWrapper modelWithDict:dataDic];
                callBack(orderWrapper, error);
            } else {
                callBack(nil, error);
            }
        }
    }];
}

@end
