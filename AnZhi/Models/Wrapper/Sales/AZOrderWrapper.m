//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZOrderWrapper.h"
#import "AZOrderTicketWrapper.h"
#import "AZDateUtil.h"

@implementation AZOrderWrapper

+ (NSDictionary *)modeAZustomPropertyMapper {
    return @{@"orderModel":@"Order",
             @"wxPrepayModel":@"WxPrepay",
             @"aliOrderSting":@"AliOrderSting",
             @"activWrapper":@"ActivWrapper",
//             @"orderTicketArr":@"OrderTicketList",
             @"orderTicketWrapper":@"OrderTicketWrapper",
             @"createUserModel":@"CreateUser",
             @"userAddrModel":@"UserAddressModel",
             };
}



//+ (NSDictionary *)modeAZontainerPropertyGenericClass {
//    return @{@"orderTicketArr":[AZOrderTicketWrapper class],
//             };
//}



@end
