//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZImageModel.h"

@implementation AZImageModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"imageUrl":@"ImageUrl",
             @"imageUrlThumb":@"ImageUrlThumb",
             @"imageUrlMd5":@"ImageUrlMd5",
             @"createdTime":@"CreatedTime",
             @"timestamp":@"Timestamp",
             };
}

- (NSURL *)getImageNSURL {
    return [NSURL URLWithString:self.imageUrl];
}

- (NSURL *)getImageThumbNSURL {
    return [NSURL URLWithString:self.imageUrlThumb];
}

@end
