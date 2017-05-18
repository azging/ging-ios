//
//  AZBaseModel.m
//  LinkCity
//
//  Created by 张宗硕 on 8/27/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZBaseModel.h"

@implementation AZBaseModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [self yy_modelWithDictionary:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}
    
- (BOOL)isValidData {
    return YES;
}

@end
