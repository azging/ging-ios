//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
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
