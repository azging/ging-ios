//
//  NSString+Additions.h
//  LinkCity
//
//  Created by 张宗硕 on 9/3/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSString *)md5;

- (NSString *)nonBreakSpaceString;

- (NSString *)normalStringFromNonBreakSpaceString;

@end
