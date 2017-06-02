//
//  AZNetRequester+Order.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/6/2.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZNetRequester.h"
#import "AZConstant.h"

@class AZOrderWrapper;

@interface AZNetRequester (Order)


// 创建订单
+ (void)requestAddOrder:(NSString *)quid
                   auid:(NSString *)auid
                 amount:(CGFloat)amount
            paymentType:(AZOrderPaymentType)paymentType
              tradeType:(AZOrderTradeType)tradeType
               callBack:(void(^)(AZOrderWrapper *orderWrapper, NSError *error))callBack;

// 订单详情
+ (void)requestOrderDetail:(NSString *)ouid callBack:(void (^)(AZOrderWrapper *, NSError *error))callBack;

@end
