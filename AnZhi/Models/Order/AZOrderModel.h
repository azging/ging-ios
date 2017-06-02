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


@interface AZOrderModel : AZBaseModel

@property (copy, nonatomic) NSString *ouid;
@property (assign, nonatomic) CGFloat amount;
@property (assign, nonatomic) AZOrderPaymentType paymentType;
@property (assign, nonatomic) AZOrderTradeType tradeType;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;

@end
