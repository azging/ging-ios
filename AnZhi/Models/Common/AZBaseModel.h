//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZStringUtil.h"
#import "YYModel.h"
#import "AZArrayUtil.h"

@interface AZBaseModel : NSObject

+ (instancetype)modelWithDict:(NSDictionary *)dict;
//- (void)encodeWithCoder:(NSCoder *)aCoder;
//- (id)initWithCoder:(NSCoder *)aDecoder;
//- (id)copyWithZone:(NSZone *)zone;
//- (BOOL)isEqual:(id)object;
- (BOOL)isValidData;

@end
