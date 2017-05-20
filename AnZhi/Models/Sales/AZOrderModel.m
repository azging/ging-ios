//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//
#import "AZOrderModel.h"

@implementation AZOrderModel

+ (NSDictionary *)modeAZustomPropertyMapper {
    return @{@"ouid":@"Ouid",
             @"seriaAZode":@"SeriaAZode",
             @"ticketCode":@"TicketCode",
             @"sumAmount":@"SumAmount",
             @"sumCoins":@"SumCoins",
             @"coinsAmount":@"CoinsAmount",
             @"sumPerson":@"SumPerson",
             @"perPrice":@"PerPrice",
             @"isUsed":@"IsUsed",
             @"isEvaluated":@"IsEvaluated",
             @"paymentType":@"PaymentType",
             @"refundStatus":@"RefundStatus",
             @"refundTime":@"RefundTime",
             @"refundAmount":@"RefundAmount",
             @"refundReason":@"RefundReason",
             @"createTime":@"CreateTime",
             @"updateTime":@"UpdateTime",
             };
}



//0未申请退款，1为退款成功，2为待退款，3商家确认退款，4为商家拒绝退款，5为走私退款
//- (NSString *)getOrderStatusStr {
//    if (self.refundStatus != 0) { // 在退款
//        switch (self.refundStatus) {
//            case 1:
//                return @"退款完成";
//                break;
//            case 2:
//                return @"退款中";
//                break;
////            case 3:
////                return @"退款处理完成";
////                break;
////            case 4:
////                return @"商家拒绝退款";
////                break;
////            case 5:
////                return @"已申请退款";
////                break;
//                
//            default:
//                return @"退款中";
//                break;
//        }
//    } else{
//        if (self.isEvaluated == 0) { // 评价按钮
//            return @"待评价";
//        }
//    }
//    return @"";
//}

@end
