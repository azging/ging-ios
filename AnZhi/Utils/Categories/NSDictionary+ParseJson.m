//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
