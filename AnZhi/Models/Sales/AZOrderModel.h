//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZConstant.h"

//typedef enum : NSInteger {
//    AZOrderRefundStatus_unRefund        == 0 , //
//    AZOrderRefundStatus_Refunded        == 1 , //
//    AZOrderRefundStatus_        == 2 , //
//    AZOrderRefundStatus_        == 3 , //
//    AZOrderRefundStatus_        == 4 , //
//    AZOrderRefundStatus_        == 5 , //
//    
//} AZOrderRefundStatus;//0未申请退款，1为退款成功，2为待退款，3商家确认退款，4为商家拒绝退款，5为走私退款


typedef enum : NSInteger {
    AZOrderIsEvaluatedtype_NotToTime      = 0,    // 时间未到，不可评价
    AZOrderIsEvaluatedtype_Evaluated      = 1,    // 已评价
    AZOrderIsEvaluatedtype_UnEvaluated    = 2,    // 未评价
} AZOrderIsEvaluatedtype;

@interface AZOrderModel : AZBaseModel

@property (copy, nonatomic) NSString *ouid;
@property (copy, nonatomic) NSString *seriaAZode;
@property (copy, nonatomic) NSString *ticketCode;
@property (assign, nonatomic) CGFloat sumAmount;
@property (assign, nonatomic) CGFloat sumCoins;
@property (assign, nonatomic) CGFloat coinsAmount;
@property (assign, nonatomic) NSInteger sumPerson; // 单数
@property (assign, nonatomic) CGFloat perPrice; // 每单价格
@property (assign, nonatomic) NSInteger isUsed;
@property (assign, nonatomic) AZOrderIsEvaluatedtype isEvaluated;
@property (assign, nonatomic) OrderPaymentType paymentType;
@property (assign, nonatomic) NSInteger refundStatus;
@property (copy, nonatomic) NSString *refundTime;
@property (assign, nonatomic) CGFloat refundAmount;
@property (copy, nonatomic) NSString *refundReason;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;

//- (NSString *)getOrderStatusStr;
@end
