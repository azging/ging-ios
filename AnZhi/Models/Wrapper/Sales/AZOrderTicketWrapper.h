//
//  AZOrderTicketWrapper.h
//  LinkCity
//
//  Created by 张宗硕 on 29/09/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
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
