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
             @"amount":@"Amount",
             @"paymentType":@"PaymentType",
             @"tradeType":@"TradeType",
             @"createTime":@"CreateTime",
             @"updateTime":@"UpdateTime",
             };
}

@end
