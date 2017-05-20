//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 函数命和参数命名规则：
 * Date为NSDate对象，
 * DateStr为yyyy-MM-dd格式字符串
 * DateTimeStr为yyyy-MM-dd HH:mm:ss格式字符串
 * MonthDayStr为MM月dd日格式字符串
 * HourMinute为HH:mm格式字符串
 * CreatedTimeStr为今天HH:mm，昨天HH:mm，2-6天前，MM月dd日
 **/
 
@interface AZDateUtil : NSObject

// NSDate转成yyyy-MM-dd格式的字符串
+ (NSString *)getDateStrFromDate:(NSDate *)date;
+ (NSString *)getDateStrFromDateTimeStr:(NSString *)dateStr;
// NSDate转成yyyy-MM-dd HH:mm:ss格式的字符串
+ (NSString *)getDateTimeStrFromDate:(NSDate *)date;
// NSDate转成yyyy-MM-dd HH:mm格式的字符串
+ (NSString *)getDateTimeStrYearMonthDayHourMinuteFromDate:(NSDate *)date;
// 根据yyyy-MM-dd HH:mm:ss获得MM月dd日
+ (NSString *)getMonthDayStrFromDateTimeStr:(NSString *)dateTimeStr;
// 根据yyyy-MM-dd HH:mm:ss获得Sep 12类型的日期
+ (NSString *)getMonthDayEnStrFromDateTimeStr:(NSString *)dateTimeStr;
// 根据yyyy-MM-dd获得yyyy年
+ (NSString *)getYearStrFromDateStr:(NSString *)dateStr;
// 根据yyyy-MM-dd获得MM月dd日
+ (NSString *)getMonthDayStrFromDateStr:(NSString *)dateStr;
// 根据yyyy-MM-dd HH:mm:ss获得HH:mm
+ (NSString *)getHourMinuteStrFromDateTimeStr:(NSString *)dateTimeStr;
// 根据yyyy-MM-dd HH:mm:ss获得周几
+ (NSString *)getWeekStrFromDateTimeStr:(NSString *)dateTimeStr;
// 根据yyyy-MM-dd获得周几
+ (NSString *)getWeekStrFromDateStr:(NSString *)dateStr;
// 根据yyyy-MM-dd HH:mm:ss获得CreatedTimeStr
+ (NSString *)getCreatedTimeStrFromDateTimeStr:(NSString *)dateTimeStr;
// 根据yyyy-MM-dd获得yyyy年MM月dd日 周几
+ (NSString *)getYearMonthDayWeekStrFromDateStr:(NSString *)dateStr;
// 根据yyyy-MM-dd HH:mm:ss获得yyyy年MM月dd日 周几
+ (NSString *)getYearMonthDayWeekStrFromDateTimeStr:(NSString *)dateTimeStr;

+ (BOOL)isDateTimeNowBeyond:(NSDate *)date limitGap:(CGFloat)limitGap;
+ (NSDate *)getDate:(NSDate *)date limitGap:(CGFloat)limitGap;

+ (BOOL)dateIsToday:(NSDate *)date;
+ (BOOL)dateIsTomorrow:(NSDate *)date;
+ (BOOL)dateIsCurrentSat:(NSDate *)date;
+ (BOOL)dateIsCurrentSun:(NSDate *)date;

+ (BOOL)isToday:(NSString *)dateStr;
+ (BOOL)isTomorrow:(NSString *)dateStr;
+ (BOOL)isCurrentSat:(NSString *)dateStr;
+ (BOOL)isCurrentSun:(NSString *)dateStr;


// yyyy-MM-dd HH:mm:ss格式的字符串转成NSDate
+ (NSDate *)getDateFromDateTimeStr:(NSString *)DateTimeStr;
// yyyy-MM-dd HH:mm格式的字符串转成NSDate
+ (NSDate *)getDateFromDateTimeStrYearMonthDayHourMinuteStr:(NSString *)dateTimeStr;
// yyyy-MM-dd格式的字符串转成NSDate
+ (NSDate *)getDateFromDateStr:(NSString *)dateStr;

+ (NSDate *)getTodayDate;

// 获取星座根据生日
+ (NSString *)getConstellation:(NSString *)dateStr;

// 获取Unix时间戳
+ (NSString *)getUnixTimeStamp;
// 得到当前年份
+ (NSString *)getCurrentYearStr;
+ (NSString *)getYearStrFromDateTimeStr:(NSString *)dateTimeStr;
+ (NSString *)getMonthStrFromDateTimeStr:(NSString *)dateTimeStr;
+ (NSString *)getDayStrFromDateTimeStr:(NSString *)dateTimeStr;
+ (NSString *)getDayStrFromDate:(NSDate *)date;
+ (NSString *)getChineseDayStrFromDate:(NSDate *)date;
+ (NSString *)getTodayDateStr;
+ (NSString *)getTomorrowDateStr;
+ (NSArray *)getWeekDateStrArr;
+ (NSArray *)getWeekDateArr:(NSDate *)date;
+ (NSString *)getDatesShowStrFromDateStrArr:(NSArray *)dateStrArr;
+ (NSString *)getWeekStrByDate:(NSDate *)date;
+ (NSString *)getWeekChineseNumberByDate:(NSDate *)date;
+ (NSDate *)getDateByDaysBefore:(NSInteger)days;

+ (NSDate *)getDate:(NSDate *)date days:(NSInteger)days;

+ (NSInteger)numberOfDaysFromDate:(NSDate *)date1 toDate:(NSDate *)date2;
+ (CGFloat)numberOfSecondsFromDate:(NSDate *)date1 toDate:(NSDate *)date2;

+ (NSString *)getUTCStringFromLocalDate:(NSDate *)localDate;
+ (NSString *)getChatTimeStringFromDate:(NSDate *)msgDate;

@end
