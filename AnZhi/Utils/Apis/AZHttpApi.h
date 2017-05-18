//
//  AZHttpApi.h
//  LinkCity
//
//  Created by 张宗硕 on 8/26/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NSDictionary+ParseJson.h"

typedef void(^requestCallBack)(NSInteger status, NSDictionary *dataDic, NSString *msg, NSError *error);

@interface AZHttpApi : NSObject

// 用GET方法请求后台
- (void)doGet:(NSString *)uriStr params:(NSArray *)params requestCallBack:(requestCallBack)callBack;
// 用POST方法请求后台
- (void)doPost:(NSString *)uriStr params:(NSDictionary *)params requestCallBack:(requestCallBack)callBack;

@end
