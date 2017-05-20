//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZBaseModel.h"

@interface AZImageModel : AZBaseModel

- (NSURL *)getImageNSURL;
- (NSURL *)getImageThumbNSURL;

@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *imageUrlThumb;
@property (copy, nonatomic) NSString *imageUrlMd5;
@property (copy, nonatomic) NSString *createdTime;
@property (copy, nonatomic) NSString *timestamp;

@end
