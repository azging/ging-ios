//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
