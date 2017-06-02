//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"
#import "AZOrderModel.h"
#import "AZWxPrepayModel.h"
#import "AZUserModel.h"

@interface AZOrderWrapper : AZBaseModel

@property (strong, nonatomic) AZOrderModel *orderModel;
@property (strong, nonatomic) AZWxPrepayModel *wxPrepayModel;
@property (strong, nonatomic) AZUserModel *createUserModel;


@end
