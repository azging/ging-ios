//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZDateUtil.h"
#import "AZStringUtil.h"

@implementation AZDateUtil

+ (NSString *)getDateStrFromDate:(NSDate *)date {
    NSString *str = [[AZDateUtil getYearMonthDayFormatter] stringFromDate:date];
    return str;
}

+ (NSString *)getDateTimeStrFromDate:(NSDate *)date {
    NSString *str = [[AZDateUtil getDateTimeFormatter] stringFromDate:date];
    return str;
}

+ (NSString *)getDateTimeStrYearMonthDayHourMinuteFromDate:(NSDate *)date {
    NSString *str = [[AZDateUtil getYearMonthDayHourMinuteFormatter] stringFromDate:date];
    return str;
}

+ (NSString *)getMonthDayStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil dateFromDateTimeStr:dateTimeStr];
    NSDateFormatter *formatter = [AZDateUtil getMonthAndDayFormatter];
    return [AZDateUtil strFromDate:date withFormatter:formatter];
}

+ (NSString *)getMonthDayEnStrFromDateTimeStr:(NSString *)dateTimeStr {
    return [NSString stringWithFormat:@"%@ %@", [AZDateUtil getMonthEnStrFromDateTimeStr:dateTimeStr], [AZDateUtil getDayStrFromDateTimeStr:dateTimeStr]];
}

+ (NSString *)getYearStrFromDateStr:(NSString *)dateStr {
    NSDate *date = [AZDateUtil getDateFromDateStr:dateStr];
    NSDateFormatter *formatter = [AZDateUtil getYearFormatter];
    return [AZStringUtil getNotNullStr:[formatter stringFromDate:date]];
}

+ (NSString *)getMonthDayStrFromDateStr:(NSString *)dateStr {
    NSDate *date = [AZDateUtil getDateFromDateStr:dateStr];
    NSDateFormatter *formatter = [AZDateUtil getMonthAndDayFormatter];
    return [AZStringUtil getNotNullStr:[formatter stringFromDate:date]];
}

+ (NSString *)getHourMinuteStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil dateFromDateTimeStr:dateTimeStr];
    NSDateFormatter *formatter = [AZDateUtil getHourAndMinuteFormatter];
    return [AZDateUtil strFromDate:date withFormatter:formatter];
}

+ (NSString *)getHourStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil dateFromDateTimeStr:dateTimeStr];
    return [AZDateUtil getHourStrFromDate:date];
}

+ (NSString *)getHourStrFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [AZDateUtil getHourFormatter];
    return [AZDateUtil strFromDate:date withFormatter:formatter];
}

+ (NSString *)getMinuteStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil dateFromDateTimeStr:dateTimeStr];
    return [AZDateUtil getMinuteStrFromDate:date];
}

+ (NSString *)getMinuteStrFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [AZDateUtil getMinuteFormatter];
    return [AZDateUtil strFromDate:date withFormatter:formatter];
}

+ (NSString *)getSecondStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil dateFromDateTimeStr:dateTimeStr];
    return [AZDateUtil getSecondStrFromDate:date];
}

+ (NSString *)getSecondStrFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [AZDateUtil getSecondFormatter];
    return [AZDateUtil strFromDate:date withFormatter:formatter];
}

+ (NSString *)getWeekStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil dateFromDateTimeStr:dateTimeStr];
    return [AZDateUtil getWeekStrByDate:date];
}

+ (NSString *)getWeekStrFromDateStr:(NSString *)dateStr {
    NSDate *date = [AZDateUtil getDateFromDateStr:dateStr];
    return [AZDateUtil getWeekStrByDate:date];
}

+ (NSString *)getUnixTimeStamp {
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", interval];
    return timeString;
}

//+ (NSString *)getTimeIntervalStringFromDateString:(NSString *)dateString {
//        NSString *timeStr = @"";
//        NSDate *createDate = [AZDateUtil dateFromDateTimeStr:dateString];
//        NSTimeInterval timeInterval = [createDate timeIntervalSinceNow];
//        timeInterval = 0-timeInterval;
//        if (timeInterval <= 0) {
//            timeStr = @"";
//        } else if (timeInterval < 60) {
//            timeStr = @"刚刚";
//        } else if (timeInterval < 60 * 60) {
//            timeStr = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval / 60];
//        } else if(timeInterval < 60 * 60 * 3) {
//            timeStr = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval / 60 / 60];
//        } else if(timeInterval < 60 * 60 * 24 * 30) {
//            timeStr = [NSString stringWithFormat:@"%ld天前",(long)timeInterval / 60 / 60 / 24];
//        } else {
//            timeStr = [AZDateUtil getDateStrFromDate:createDate];
//        }
//        return timeStr;
//}

+ (NSString *)getCreatedTimeStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSString *resStr = @"";
    NSDate *date1 = [AZDateUtil getDateFromDateTimeStr:dateTimeStr];
    NSTimeInterval timeInterval = -1 * [date1 timeIntervalSinceNow];
    if (timeInterval <= 60) {
        resStr = @"刚刚";
    } else if (timeInterval < 60 * 60) {
        resStr = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval / 60];
    } else if (timeInterval < 60 * 60 * 3) {
        resStr = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval / 60 / 60];
    } else {
        NSString *timeStr = [AZDateUtil getHourMinuteStrFromDateTimeStr:dateTimeStr];
        NSString *monthDayStr = [AZDateUtil getMonthDayStrFromDateTimeStr:dateTimeStr];
        NSDate *date2 = [AZDateUtil getTodayDate];
        NSInteger days = [AZDateUtil numberOfDaysFromDate:date1 toDate:date2];
        timeStr = [AZStringUtil getNotNullStr:timeStr];
        if (0 == days) {
            resStr = [NSString stringWithFormat:@"今天 %@", timeStr];
        } else if (1 == days) {
            resStr = [NSString stringWithFormat:@"昨天 %@", timeStr];
        } else if (days >= 2 && days <= 3) {
            resStr = [NSString stringWithFormat:@"%zd天前", days];
        } else if (days > 3) {
            NSString *year = [AZDateUtil getYearStrFromDateTimeStr:dateTimeStr];
            NSString *currentYear = [AZDateUtil getCurrentYearStr];
            if ([currentYear isEqualToString:year]) {
                resStr = monthDayStr;
            } else {
                resStr = [NSString stringWithFormat:@"%@年%@", year, monthDayStr];
            }
        }
    }
    resStr = [AZStringUtil getNotNullStr:resStr];
    return resStr;
}

+ (NSString *)getYearMonthDayWeekStrFromDateStr:(NSString *)dateStr {
    return [NSString stringWithFormat:@"%@%@  %@", [AZDateUtil getYearStrFromDateStr:dateStr], [AZDateUtil getMonthDayStrFromDateStr:dateStr], [AZDateUtil getWeekStrFromDateStr:dateStr]];
}

+ (NSString *)getYearMonthDayWeekStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSString *dateStr = [AZDateUtil getDateStrFromDateTimeStr:dateTimeStr];
    return [AZDateUtil getYearMonthDayWeekStrFromDateStr:dateStr];
}

+ (BOOL)isDateTimeNowBeyond:(NSDate *)date limitGap:(CGFloat)limitGap {
    if (nil == date) {
        return NO;
    }
    NSDate *date2 = [AZDateUtil getTodayDate];
    CGFloat seconds = [AZDateUtil numberOfSecondsFromDate:date toDate:date2];
    if (seconds > limitGap) {
        return YES;
    }
    return NO;
}

+ (NSDate *)getDate:(NSDate *)date limitGap:(CGFloat)limitGap {
    if (nil == date) {
        date = [NSDate date];
    }
    NSString *dateStr = [AZDateUtil getDateStrFromDate:date];
    NSInteger hour = [[AZDateUtil getHourStrFromDate:date] integerValue];
    NSInteger minute = [[AZDateUtil getMinuteStrFromDate:date] integerValue];
    NSInteger second = [[AZDateUtil getSecondStrFromDate:date] integerValue];
    NSInteger limitMinute = limitGap / 60;
    if (60 - minute < limitMinute) {
        hour += 1;
        minute = 0;
    } else {
        minute += limitMinute - minute % limitMinute;
    }
    second = 0;
    NSString *dateTimeStr = [NSString stringWithFormat:@"%@ %2zd:%2zd:%2zd", dateStr, hour, minute, second];
    return [AZDateUtil getDateFromDateTimeStr:dateTimeStr];
}

+ (BOOL)dateIsToday:(NSDate *)date {
    NSInteger days = [AZDateUtil numberOfDaysFromDate:[AZDateUtil getTodayDate] toDate:date];
    return days == 0;
}

+ (BOOL)dateIsTomorrow:(NSDate *)date {
    NSInteger days = [AZDateUtil numberOfDaysFromDate:[AZDateUtil getTodayDate] toDate:date];
    return days == 1;
}

+ (BOOL)dateIsCurrentSat:(NSDate *)date {
    NSInteger days = [AZDateUtil numberOfDaysFromDate:[AZDateUtil getTodayDate] toDate:date];
    NSInteger weekDay = [AZDateUtil getWeekNumber:date];
    NSInteger todayWeek = [AZDateUtil getWeekNumber:[NSDate date]];
    if (todayWeek == 1) { // 今天是周天
        return days == -1;
    } else {
        if (weekDay == 7 && days >= 0 && days < 7 ) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)dateIsCurrentSun:(NSDate *)date {
    NSInteger days = [AZDateUtil numberOfDaysFromDate:[AZDateUtil getTodayDate] toDate:date];
    NSInteger weekDay = [AZDateUtil getWeekNumber:date];
    if (weekDay == 1 && days >= 0 && days < 7) {
        return YES;
    }
    return NO;
}

+ (BOOL)isToday:(NSString *)dateStr {
    return [AZDateUtil dateIsToday:[AZDateUtil getDateFromDateStr:dateStr]];
}

+ (BOOL)isTomorrow:(NSString *)dateStr {
    return [AZDateUtil dateIsTomorrow:[AZDateUtil getDateFromDateStr:dateStr]];
}

+ (BOOL)isCurrentSat:(NSString *)dateStr {
    return [AZDateUtil dateIsCurrentSat:[AZDateUtil getDateFromDateStr:dateStr]];
}

+ (BOOL)isCurrentSun:(NSString *)dateStr {
    return [AZDateUtil dateIsCurrentSun:[AZDateUtil getDateFromDateStr:dateStr]];
}

+ (NSString *)getCurrentYearStr {
    NSDate *date = [AZDateUtil getTodayDate];
    NSDateComponents *comps = [AZDateUtil getComps:date];
    return [NSString stringWithFormat:@"%zd", [comps year]];
}

+ (NSString *)getYearStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil getDateFromDateTimeStr:dateTimeStr];
    NSDateComponents *comps = [AZDateUtil getComps:date];
    return [NSString stringWithFormat:@"%zd", [comps year]];
}

+ (NSString *)getMonthStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil getDateFromDateTimeStr:dateTimeStr];
    NSDateComponents *comps = [AZDateUtil getComps:date];
    return [NSString stringWithFormat:@"%zd", [comps month]];
}

+ (NSString *)getMonthEnStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil dateFromDateTimeStr:dateTimeStr];
    NSDateFormatter *formatter = [AZDateUtil getMonthEnSimpleFormatter];
    return [AZDateUtil strFromDate:date withFormatter:formatter];
}

+ (NSString *)getDayStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil getDateFromDateTimeStr:dateTimeStr];
    NSDateComponents *comps = [AZDateUtil getComps:date];
    return [NSString stringWithFormat:@"%zd", [comps day]];
}

+ (NSString *)getDayStrFromDate:(NSDate *)date {
    NSDateComponents *comps = [AZDateUtil getComps:date];
    return [NSString stringWithFormat:@"%zd", [comps day]];
}

+ (NSString *)getChineseDayStrFromDate:(NSDate *)date {
    NSDateComponents *comps = [AZDateUtil getChineseComps:date];
//    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSString *dayStr = @"";
    if (1 == day) {
        dayStr = [[AZDateUtil getChineseMonthArr] objectAtIndex:month - 1];
    } else {
        dayStr = [[AZDateUtil getChineseDayArr] objectAtIndex:day - 1];
    }
    return dayStr;
}

+ (NSString *)getTodayDateStr {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSString *nowStr = [AZDateUtil getDateStrFromDate:date];
    return nowStr;
}

+ (NSString *)getTomorrowDateStr {
    NSDate *date = [AZDateUtil getDateByDaysBefore:-1];
    return [AZDateUtil getDateStrFromDate:date];
}

+ (NSArray *)getWeekDateStrArr {
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comp = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger weekDay = [comp weekday];
    
    NSInteger firstDiff = -6;
    NSInteger lastDiff = 0;
    if (weekDay == 1) {
        firstDiff = -6;
        lastDiff = 0;
    } else {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    
    for (NSInteger i = firstDiff + 4; i <= lastDiff; ++i) {
        NSDate *date = [AZDateUtil getDateByDaysBefore: -1 * i];
        NSString *dayStr = [AZDateUtil getDateStrFromDate:date];
        [mutArr addObject:dayStr];
    }
    
    return mutArr;
}

+ (NSArray *)getWeekDateArr:(NSDate *)date {
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comp = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDay = [comp weekday];
    
    NSInteger firstDiff = - weekDay + 1;
    if (weekDay == [calendar firstWeekday]) {
        firstDiff = 0;
    }

    NSDate *firstDate = [AZDateUtil getDate:date days:firstDiff];
    [mutArr addObject:firstDate];
    
    for (NSInteger i = 1; i < 7; ++i ) {
        NSDate *weekdate = [AZDateUtil getDate:firstDate days:i];
        [mutArr addObject:weekdate];
    }
    return mutArr;
}

+ (NSString *)getDatesShowStrFromDateStrArr:(NSArray *)dateStrArr {
    NSString *str = @"日历";
    if (nil == dateStrArr || dateStrArr.count <= 0) {
        return str;
    }
    if (1 == dateStrArr.count) {
        NSString *dateStr = [dateStrArr objectAtIndex:0];
        str = [AZDateUtil getMonthDayStrFromDateStr:dateStr];
    } else if (dateStrArr.count >= 2) {
        NSString *minDateStr = [dateStrArr objectAtIndex:0];
        NSString *maxDateStr = [dateStrArr objectAtIndex:0];
        for (NSInteger index = 1; index < dateStrArr.count; ++index) {
            NSString *dateStr = [dateStrArr objectAtIndex:index];
            if (NSOrderedDescending == [minDateStr compare:dateStr]) {
                minDateStr = dateStr;
            } else if (NSOrderedAscending == [maxDateStr compare:dateStr]) {
                maxDateStr = dateStr;
            }
        }
        NSInteger days = [AZDateUtil numberOfDaysFromDateStr:minDateStr toDate:maxDateStr];
        if (days == dateStrArr.count - 1) {
            NSString *minShowStr = [AZDateUtil getMonthDayStrFromDateStr:minDateStr];
            NSString *maxShowStr = [AZDateUtil getMonthDayStrFromDateStr:maxDateStr];
            str = [NSString stringWithFormat:@"%@-%@", minShowStr, maxShowStr];
        }
    }
    return str;
}



+ (NSString *)getUTCStringFromLocalDate:(NSDate *)localDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4]; // Use unicode patterns (as opposed to 10_3)
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *utcValue = [df stringFromDate:localDate];
    return utcValue;
}

+ (NSString *)getChatTimeStringFromDate:(NSDate *)msgDate {
    NSString *ret = @"";
    NSDate *localDate = [AZDateUtil getLocalDateFromGMTDate:msgDate];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *utcValue = [df stringFromDate:localDate];
    
    ret = [AZDateUtil getCreatedTimeStrFromDateTimeStr:utcValue];
    return ret;
}

+ (NSDate *)getTodayDate {
    NSDate *date = [NSDate date];
    return date;
}

+ (NSString *)getConstellation:(NSString *)dateStr {
    NSDateComponents *comps = [AZDateUtil getChineseComps:[AZDateUtil getDateFromDateStr:dateStr]];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result = @"";
    if (month<1 || month>12 || day<1 || day>31) {
        return result;
    }
    if (month == 2 && day > 29) {
        return result;
    } else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return result;
        }
    }
    result = [NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19)) * 2, 2)]];
    return [NSString stringWithFormat:@"%@座", result];
}


#pragma mark - Private Func

+ (NSDate *)getDateFromDateStr:(NSString *)str {
    NSDate *date = [[AZDateUtil getYearMonthDayFormatter] dateFromString:str];
    return date;
}

+ (NSDate *)getDateFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [[AZDateUtil getDateTimeFormatter] dateFromString:dateTimeStr];
    return date;
}

+ (NSDate *)getDateFromDateTimeStrYearMonthDayHourMinuteStr:(NSString *)dateTimeStr {
    return [[AZDateUtil getYearMonthDayHourMinuteFormatter] dateFromString:dateTimeStr];
}

+ (NSDate *)dateFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [[AZDateUtil getDateTimeFormatter] dateFromString:dateTimeStr];
    return date;
}

+ (NSString *)getDateStrFromDateTimeStr:(NSString *)dateTimeStr {
    NSDate *date = [AZDateUtil getDateFromDateTimeStr:dateTimeStr];
    return [[AZDateUtil getYearMonthDayFormatter] stringFromDate:date];
}

+ (NSString *)strFromDate:(NSDate *)date withFormatter:(NSDateFormatter *)formatter {
    return [formatter stringFromDate:date];
}

+ (NSDateFormatter *)getDateTimeFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return formatter;
}

+ (NSDateFormatter *)getYearMonthDayHourMinuteFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return formatter;
}

+ (NSDateFormatter *)getYearMonthDayFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return formatter;
}

+ (NSDateFormatter *)getHourAndMinuteFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return formatter;
}

+ (NSDateFormatter *)getHourFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    return formatter;
}

+ (NSDateFormatter *)getMinuteFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm"];
    return formatter;
}

+ (NSDateFormatter *)getSecondFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss"];
    return formatter;
}

+ (NSDateFormatter *)getYearFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年"];
    return formatter;
}

+ (NSDateFormatter *)getMonthAndDayFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M月d日"];
    return formatter;
}

+ (NSDateFormatter *)getMonthEnSimpleFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setDateFormat:@"MMM"];
    return formatter;
}

+ (NSString *)getWeekStrByDate:(NSDate *)date {
    return [NSString stringWithFormat:@"周%@", [AZDateUtil getWeekChineseNumberByDate:date]];
}

+ (NSString *)getWeekChineseNumberByDate:(NSDate *)date {
    NSString *weekStr = @"";
    NSInteger weekday = [AZDateUtil getWeekNumber:date];
    NSArray *weekArray = [AZDateUtil getWeekArr];
    if (weekday >= 1) {
        weekStr = weekArray[weekday - 1];
    }
    weekStr = [AZStringUtil getNotNullStr:weekStr];
    return weekStr;
}


+ (NSInteger)getWeekNumber:(NSDate *)date {
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    return [componets weekday];
}

+ (NSDate *)getDateByDaysBefore:(NSInteger)days {
    NSInteger oneDaySecs = 24 * 3600;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-1 * oneDaySecs * days];
    return date;
}

+ (NSDate *)getDate:(NSDate *)date days:(NSInteger)days {
    NSInteger daysSecs = 24 * 3600 * days;
    return [date dateByAddingTimeInterval:daysSecs];
}

+ (NSInteger)numberOfDaysFromDateStr:(NSString *)dateStr1 toDate:(NSString *)dateStr2 {
    NSDate *date1 = [AZDateUtil getDateFromDateStr:dateStr1];
    NSDate *date2 = [AZDateUtil getDateFromDateStr:dateStr2];
    NSDate *startOfDate1 = [[NSCalendar currentCalendar] startOfDayForDate:date1];
    NSDate *startOfDate2 = [[NSCalendar currentCalendar] startOfDayForDate:date2];
    return [AZDateUtil numberOfDaysFromDate:startOfDate1 toDate:startOfDate2];
}
                          
// date2-date1
+ (NSInteger)numberOfDaysFromDate:(NSDate *)date1 toDate:(NSDate *)date2 {
    NSDate *startOfDate1 = [[NSCalendar currentCalendar] startOfDayForDate:date1];
    NSDate *startOfDate2 = [[NSCalendar currentCalendar] startOfDayForDate:date2];
    NSTimeInterval time = [AZDateUtil numberOfSecondsFromDate:startOfDate1 toDate:startOfDate2];
    NSInteger oneDaySecs = 24 * 3600;
    return time / oneDaySecs;
}

+ (CGFloat)numberOfSecondsFromDate:(NSDate *)date1 toDate:(NSDate *)date2 {
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    return time;
}

+ (NSDateComponents *)getComps:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    return dateComponent;
}

+ (NSDateComponents *)getChineseComps:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    return dateComponent;
}

+ (NSDate *)getLocalDateFromGMTDate:(NSDate *)gmtDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    NSDate *localeDate = [gmtDate  dateByAddingTimeInterval: interval];
    return localeDate;
}


+ (NSArray *)getWeekArr {
    return @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}

+ (NSArray *)getChineseYearArr {
    return @[@"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥"];
}

+ (NSArray *)getChineseMonthArr {
    return @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
             @"九月", @"十月", @"冬月", @"腊月"];
}

+ (NSArray *)getChineseDayArr {
    return @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
             @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
             @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
}

@end
