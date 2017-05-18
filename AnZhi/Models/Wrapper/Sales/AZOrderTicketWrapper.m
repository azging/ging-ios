//
//  AZOrderTicketWrapper.m
//  LinkCity
//
//  Created by 张宗硕 on 29/09/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZOrderTicketWrapper.h"
#import "AZDateUtil.h"

@implementation AZOrderTicketWrapper

+ (NSDictionary *)modeAZustomPropertyMapper {
    return @{@"duid":@"Duid",
             @"chatRoomName":@"ChatRoomName",
             @"dateStr":@"DateStr",
             @"ticketCode":@"TicketCode",
             @"orderNumber":@"OrderNumber",
             @"ticketModel":@"ActivTicket",
             };
}

@end
