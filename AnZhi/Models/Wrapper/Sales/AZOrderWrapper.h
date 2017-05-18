//
//  AZOrderWrapper.h
//  LinkCity
//
//  Created by 张宗硕 on 09/10/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZOrderModel.h"
#import "AZWxPrepayModel.h"
#import "AZOrderTicketWrapper.h"
#import "AZUserModel.h"

@interface AZOrderWrapper : AZBaseModel

@property (strong, nonatomic) AZOrderModel *orderModel;
@property (strong, nonatomic) AZWxPrepayModel *wxPrepayModel;
@property (copy, nonatomic) NSString *aliOrderSting;
//@property (strong, nonatomic) NSArray *orderTicketArr;
@property (strong, nonatomic) AZOrderTicketWrapper *orderTicketWrapper;
@property (strong, nonatomic) AZUserModel *createUserModel;

- (BOOL)isCanDelete;
- (NSString *)getCalendarTimeStr;
@end
