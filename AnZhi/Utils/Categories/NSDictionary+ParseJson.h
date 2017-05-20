//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ParseJson)

// 从字典中取出key对应的字典
- (NSDictionary *)dicOfObjectForKey:(NSString *)key;
// 从字典中取出key对应的数组
- (NSArray *)arrayForKey:(NSString *)key;

@end
