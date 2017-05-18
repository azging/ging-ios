//
//  AZWxPrepayModel.h
//  LinkCity
//
//  Created by 张宗硕 on 08/10/2016.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"

@interface AZWxPrepayModel : AZBaseModel

@property (copy, nonatomic) NSString *appId;
@property (copy, nonatomic) NSString *mchId;
@property (copy, nonatomic) NSString *nonceStr;
@property (copy, nonatomic) NSString *prepayId;

@property (copy, nonatomic) NSString *resultCode;
@property (copy, nonatomic) NSString *returnCode;

@property (copy, nonatomic) NSString *returnMsg;
@property (copy, nonatomic) NSString *sign;
@property (copy, nonatomic) NSString *tradeType;

@end
