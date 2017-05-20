//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
