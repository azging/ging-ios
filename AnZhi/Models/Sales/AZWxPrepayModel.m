//
//  AZWxPrepayModel.m
//  LinkCity
//
//  Created by 张宗硕 on 08/10/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZWxPrepayModel.h"

@implementation AZWxPrepayModel

+ (NSDictionary *)modeAZustomPropertyMapper {
    return @{@"appId":@"appid",
             @"mchId":@"mch_id",
             @"nonceStr":@"nonce_str",
             @"prepayId":@"prepay_id",
             @"resultCode":@"result_code",
             @"returnCode":@"return_code",
             @"returnMsg":@"return_msg",
             @"sign":@"sign",
             @"tradeType":@"trade_type",
             };
}

@end
