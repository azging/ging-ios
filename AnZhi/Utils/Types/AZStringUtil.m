//
//  AZStringUtil.m
//  LinkCity
//
//  Created by 张宗硕 on 8/25/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZStringUtil.h"
#import "AZArrayUtil.h"
#import "AZConstant.h"
#import "AZDataManager.h"

@implementation AZStringUtil

// 得到非空的NSString对象
+ (NSString *)getNotNullStr:(id)obj {
    if ([AZStringUtil isNullString:obj]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", obj];
}
    
+ (NSString *)getShowStr:(id)obj defaultStr:(NSString *)str {
    NSString *resStr = str;
    if ([AZStringUtil isNotNullString:obj]) {
        resStr = [AZStringUtil getNotNullStr:obj];
    }
    return resStr;
}
    
// 判断是否为空的对象
+ (BOOL)isNullString:(id)obj {
    if (nil == obj || NULL == obj || [NSNull null] == obj) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

// 判断是否不为空的对象
+ (BOOL)isNotNullString:(id)obj {
    if ([AZStringUtil isNullString:obj]) {
        return NO;
    }
    return YES;
}

// 对象转化成Int类型
+ (int)idToInt:(id)obj {
    NSString *str = [AZStringUtil getNotNullStr:obj];
    return [str intValue];
}

// 对象转化成NSInteger
+ (NSInteger)idToNSInteger:(id)obj {
    NSString *str = [AZStringUtil getNotNullStr:obj];
    return [str integerValue];
}

// 对象转化成Bool
+ (BOOL)idToBool:(id)obj {
    NSString *str = [AZStringUtil getNotNullStr:obj];
    return [str boolValue];
}

// 对象转化成CGFloat
+ (CGFloat)idToCGFloat:(id)obj {
    NSString *str = [AZStringUtil getNotNullStr:obj];
    return [str floatValue];
}

// 对象转化成double
+ (double)idToDouble:(id)obj {
    NSString *str = [AZStringUtil getNotNullStr:obj];
    return [str doubleValue];
}

// NSInteger转成NSString
+ (NSString *)integerToStr:(NSInteger)integer {
    return [NSString stringWithFormat:@"%zd", integer];
}

// 去除NSString中的空格和回车
+ (NSString *)trimSpaceAndEnter:(NSString *)str {
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    str = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return str;
}

+ (NSString *)getDistanceString:(CGFloat)distance {
    NSString *str = @"";
    if (distance >= 0.0f) {
        if (distance <= 100.0f) {
            str = @"0.1km";
        } else if (distance < 10000000.0f) {
            str = [NSString stringWithFormat:@"%.1fkm", distance / 1000.0f];
        } else {
            str = @"9999.1km";
        }
    }
    return str;
}

+ (NSString *)getPriceString:(CGFloat)price {
    NSString *priceStr = @"免费";
    if (price < 0.1f && price > 0.0f) {
        priceStr = [NSString stringWithFormat:@"￥%.2f", price];
    } else if (price > 0.1f) {
        priceStr = [NSString stringWithFormat:@"￥%.1f", price];
    }
    return priceStr;
}

+ (NSString *)getBadgeStr:(NSInteger)unReadNum {
    NSString *badgeStr = @"";
    if (unReadNum <= 0) {
        badgeStr = nil;
    } else if (unReadNum < 100) {
        badgeStr = [NSString stringWithFormat:@"%zd", unReadNum];
    } else {
        badgeStr = @"99+";
    }
    return badgeStr;
}

+ (NSString *)getServerFullUrl:(NSString *)prefix suffix:(NSString *)suffix {
    prefix = [AZStringUtil getNotNullStr:prefix];
    suffix = [AZStringUtil getNotNullStr:suffix];
    return [NSString stringWithFormat:@"%@%@", prefix, suffix];
}

+ (NSString *)getGuidServerFullUrl:(NSString *)prefix suffix:(NSString *)suffix guid:(NSString *)guid {
    prefix = [AZStringUtil getNotNullStr:prefix];
    suffix = [AZStringUtil getNotNullStr:suffix];
    guid = [AZStringUtil getNotNullStr:guid];
    return [NSString stringWithFormat:@"%@%@%@", prefix, suffix, guid];
}

+ (NSString *)getFrontEllipsisString:(NSString *)str number:(NSUInteger)number {
    str = [AZStringUtil getNotNullStr:str];
    NSString *frontStr = @"";
    if (str.length > number) {
        frontStr = [str substringWithRange:NSMakeRange(0, number)];
        frontStr = [NSString stringWithFormat:@"%@...", frontStr];
    } else {
        frontStr = [str substringWithRange:NSMakeRange(0, str.length)];
    }
    return frontStr;
}

+ (NSString *)getShowString:(NSString *)showStr withDefault:(NSString *)defaultStr {
    if ([AZStringUtil isNullString:showStr]) {
        return defaultStr;
    }
    return showStr;
}

+ (NSString *)getJsonStrFromArr:(NSArray *)arr {
    arr = [AZArrayUtil getNotNullArr:arr];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:0 error:&error];
    if (error) {
        return @"";
    }
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [AZStringUtil getNotNullStr:jsonStr];
}

+ (NSString *)getJsonStr:(id)data {
    if (!data) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if (error) {
        return @"";
    }
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [AZStringUtil getNotNullStr:jsonStr];
}

+ (NSArray *)getArrFromJsonStr:(NSString *)jsonStr {
    if ([AZStringUtil isNullString:jsonStr]) {
        return [NSArray array];
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *dictArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return [NSArray array];
    }
    return dictArr;
}

+ (NSDictionary *)getDictFromJsonStr:(NSString *)jsonStr {
    if ([AZStringUtil isNullString:jsonStr]) {
        return [NSDictionary dictionary];
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return [NSDictionary dictionary];
    }
    return dict;
}

// 金币转成NSString
+ (NSString *)coinsToStr:(float)value {
    return [NSString stringWithFormat:@"%.2f", value];
}

+ (NSString *)getSubStr:(NSString *)str length:(NSInteger)length {
    str = [AZStringUtil getNotNullStr:str];
    if (length > 0) {
        if (str.length > length) {
            str = [str substringWithRange:NSMakeRange(0, length - 1)];
        }
    }
    return str;
}

+ (NSString *)getSubStr:(NSString *)str hint:(NSString *)hint {
    NSRange range = [str rangeOfString:hint];
    if (range.length && range.location < str.length) { //
        long index = range.location;//获取hint的位置，从0开始
        return [AZStringUtil getSubStr:str length:index+1];
    } else {
        return str;
    }
}

+ (NSArray *)getAllSubStr:(NSString *)str hint:(NSString *)hint {
    return [str componentsSeparatedByString:hint];
}

+ (NSArray *)getAllSubStr:(NSString *)str hint:(NSString *)hint arr:(NSMutableArray *)arr {
    if (!arr) {
        arr = [NSMutableArray array];
    }
    if ([AZStringUtil isNullString:str]) {
        return arr;
    }
    NSRange range = [str rangeOfString:hint];
    if (range.length && range.location < str.length) { //
        long index = range.location;//获取hint的位置，从0开始
        NSString *subStr =  [AZStringUtil getSubStr:str length:index+1];
        if ([AZStringUtil isNotNullString:subStr]) {
            subStr = [subStr stringByReplacingOccurrencesOfString:hint withString:@""];
            [arr addObject:subStr];
        }
        
        NSString *restStr = [str substringFromIndex:index + 1];
        if ([AZStringUtil isNotNullString:restStr]) {
            NSString *firstStr = [restStr substringToIndex:1];
            if ([hint isEqualToString: firstStr]) {
                restStr = [restStr substringFromIndex:1];
            }
            arr = [NSMutableArray arrayWithArray:[self getAllSubStr:restStr hint:hint arr:arr]] ;
        }
    } else {
        if ([AZStringUtil isNotNullString:str]) {
            [arr addObject:str];
        }
        return arr;
    }
    return arr;
}


+ (NSString *)getInviteJoinMessageWithUserNick:(NSString *)nick {
    return [NSString stringWithFormat:@"%@加入了群聊", nick];
}

+ (NSString *)getActivJoinMessageWithUserNick:(NSString *)nick {
    return [NSString stringWithFormat:@"%@购买了活动", nick];
}

+ (NSMutableDictionary *)getURLParamDictionaryFromURLString:(NSString *)absoluteURLString {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSArray *strArr = [absoluteURLString componentsSeparatedByString:@"?"];
    if (strArr && strArr.count>0) {
        absoluteURLString = [strArr lastObject];
    }
    
    strArr = [absoluteURLString componentsSeparatedByString:@"&"];
    for (NSString *paramPair in strArr) {
        NSArray *paramPairArray = [paramPair componentsSeparatedByString:@"="];
        if (paramPairArray && paramPairArray.count >= 2) {
            NSString *key = [paramPairArray objectAtIndex:0];
            NSString *value = [paramPairArray objectAtIndex:1];
            
            [paramDic setObject:value forKey:key];
        }
    }
    
    return paramDic;
}

//+ (NSString *)getInviteJidStr:(NSString *)jid {
//    return @"";
//}


+ (NSString *)getFilePathFromFileUrl:(NSURL *)fileUrl {
   return [AZStringUtil getNotNullStr:[fileUrl.absoluteString stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
}

@end
