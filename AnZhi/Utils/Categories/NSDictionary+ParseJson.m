//
//  NSDictionary+ParseJson.m
//  LinkCity
//
//  Created by 张宗硕 on 9/6/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "NSDictionary+ParseJson.h"
#import "AZStringUtil.h"

@implementation NSDictionary (ParseJson)

// 从字典中取出key对应的字典
- (NSDictionary *)dicOfObjectForKey:(NSString *)key {
    id obj = [self objectForKey:key];
    
    if ([obj isKindOfClass:[NSArray class]]) {
        obj = nil;
    } else if ([obj isKindOfClass:[NSDictionary class]]) {
        
    }
    
    return (NSDictionary *)obj;
}

// 从字典中取出key对应的数组
- (NSArray *)arrayForKey:(NSString *)key {
    id obj = [self objectForKey:key];
    
    if ([AZStringUtil isNullString:obj] || [obj isKindOfClass:[NSDictionary class]] || ![obj isKindOfClass:[NSArray class]]) {
        obj = nil;
    }
    
    return (NSArray *)obj;
}

@end
