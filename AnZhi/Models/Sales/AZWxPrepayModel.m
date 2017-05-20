//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
