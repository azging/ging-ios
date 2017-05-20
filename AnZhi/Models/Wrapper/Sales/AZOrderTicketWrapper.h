//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZDateUtil.h"

@interface AZOrderTicketWrapper : AZBaseModel

@property (copy, nonatomic) NSString *duid;
@property (copy, nonatomic) NSString *chatRoomName;
@property (copy, nonatomic) NSString *dateStr;
@property (copy, nonatomic) NSString *ticketCode;
@property (assign, nonatomic) NSInteger orderNumber;


@end
