//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAuthCode.h"
#import "AZStringUtil.h"

@implementation AZAuthCode

+ (NSDictionary *)modeAZustomPropertyMapper {
    return @{@"authCode":@"AuthCode",
             @"expireTime":@"ExpireTime",
             };
}

- (NSInteger)getIntegerAuthcode{
    return [AZStringUtil idToNSInteger:self.authCode];
}

@end
