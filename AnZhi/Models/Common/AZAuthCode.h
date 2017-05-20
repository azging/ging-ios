//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"

@interface AZAuthCode : AZBaseModel

- (NSInteger)getIntegerAuthcode;

@property (nonatomic, retain) NSString *authCode;
@property (nonatomic, assign) NSInteger expireTime;

@end
