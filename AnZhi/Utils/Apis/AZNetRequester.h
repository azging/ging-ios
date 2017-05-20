//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZHttpApi.h"
#import "AZAuthCode.h"
#import "AZUserModel.h"
#import "AZConfigInitWrapper.h"



@interface AZNetRequester : AZHttpApi

+ (instancetype)createInstance;

+ (void)requestAppConfigInit;
+ (void)requestAppConfigSet;


@end
