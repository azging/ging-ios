//
//  AZOrderWrapper.m
//  LinkCity
//
//  Created by 张宗硕 on 09/10/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
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
