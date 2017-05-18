//
//  NSDictionary+ParseJson.h
//  LinkCity
//
//  Created by 张宗硕 on 9/6/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ParseJson)

// 从字典中取出key对应的字典
- (NSDictionary *)dicOfObjectForKey:(NSString *)key;
// 从字典中取出key对应的数组
- (NSArray *)arrayForKey:(NSString *)key;

@end
