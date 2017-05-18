//
//  AZStringUtil.h
//  LinkCity
//
//  Created by 张宗硕 on 8/25/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AZStringUtil : NSObject

// 得到非空的NSString对象
+ (NSString *)getNotNullStr:(id)obj;
// 如果字符串为空，赋初值
+ (NSString *)getShowStr:(id)obj defaultStr:(NSString *)str;
// 判断是否为空的对象
+ (BOOL)isNullString:(id)obj;
// 判断是否不为空的对象
+ (BOOL)isNotNullString:(id)obj;
// 对象转化成Int类型
+ (int)idToInt:(id)obj;
// 对象转化成NSInteger
+ (NSInteger)idToNSInteger:(id)obj;
// 对象转化成Bool
+ (BOOL)idToBool:(id)obj;
// 对象转化成CGFloat
+ (CGFloat)idToCGFloat:(id)obj;
// 对象转化成double
+ (double)idToDouble:(id)obj;
// NSInteger转成NSString
+ (NSString *)integerToStr:(NSInteger)integer;
// 去除NSString中的空格和回车
+ (NSString *)trimSpaceAndEnter:(NSString *)str;

// 得到距离字符串
+ (NSString *)getDistanceString:(CGFloat)distance;
// 得到显示的价钱字符串
+ (NSString *)getPriceString:(CGFloat)price;

// 获取角标字符串
+ (NSString *)getBadgeStr:(NSInteger)unReadNum;

// 拼接网络访问地址
+ (NSString *)getServerFullUrl:(NSString *)prefix suffix:(NSString *)suffix;
// 拼接网络访问地址，后面跟一个参数
+ (NSString *)getGuidServerFullUrl:(NSString *)prefix suffix:(NSString *)suffix guid:(NSString *)guid;
// 获取前number个字
+ (NSString *)getFrontEllipsisString:(NSString *)str number:(NSUInteger)number;
// 如果显示的文字为空显示默认文字
+ (NSString *)getShowString:(NSString *)showStr withDefault:(NSString *)defaultStr;
// 得到Json Encode Array后的字符串
+ (NSString *)getJsonStrFromArr:(NSArray *)arr;

// 得到Json Encode Array后的字符串 可以传字典、数组
+ (NSString *)getJsonStr:(id)data;

+ (NSArray *)getArrFromJsonStr:(NSString *)jsonStr;
+ (NSDictionary *)getDictFromJsonStr:(NSString *)jsonStr;

// 金币转成NSString
+ (NSString *)coinsToStr:(float)value;
+ (NSString *)getSubStr:(NSString *)str length:(NSInteger)length;
+ (NSString *)getSubStr:(NSString *)str hint:(NSString *)hint;
+ (NSArray *)getAllSubStr:(NSString *)str hint:(NSString *)hint;

+ (NSString *)getInviteJoinMessageWithUserNick:(NSString *)nick;
+ (NSString *)getActivJoinMessageWithUserNick:(NSString *)nick;
+ (NSMutableDictionary *)getURLParamDictionaryFromURLString:(NSString *)absoluteURLString;
//+ (NSString *)getInviteJidStr:(NSString *)jid;

+ (NSString *)getThemeTitleShowStr:(NSString *)themeTitle;

+ (NSString *)getFilePathFromFileUrl:(NSURL *)fileUrl;

@end
