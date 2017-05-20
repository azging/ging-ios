//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZArrayUtil.h"
#import "AZStringUtil.h"

@implementation AZArrayUtil

+ (BOOL)isValidArray:(NSArray *)arr {
    if (nil != arr && arr.count > 0) {
        return YES;
    }
    return NO;
}

+ (NSArray *)getNotNullArr:(NSArray *)arr {
    if (nil == arr) {
        return [[NSArray alloc] init];
    }
    return arr;
}

+ (NSArray *)mergeArr:(NSArray *)frontArr rearArr:(NSArray *)rearArr {
    if (![AZArrayUtil isValidArray:rearArr]) {
        return frontArr;
    }
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:frontArr];
    [mutArr addObjectsFromArray:rearArr];
    return mutArr;
}

+ (NSArray *)mergeArr:(NSArray *)frontArr atIndex:(NSInteger)idx rearArr:(NSArray *)rearArr {
    if (![AZArrayUtil isValidArray:rearArr]) {
        return frontArr;
    }
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    NSArray *frontIndexArr = [frontArr subarrayWithRange:NSMakeRange(0, idx)];
    NSArray *rearIndexArr = [frontArr subarrayWithRange:NSMakeRange(idx, frontArr.count - idx)];
    [mutArr addObjectsFromArray:frontIndexArr];
    [mutArr addObjectsFromArray:rearArr];
    [mutArr addObjectsFromArray:rearIndexArr];
    return mutArr;
}

+ (NSArray *)updateObject:(NSArray *)arr atIndex:(NSInteger)idx obj:(id)obj {
    arr = [AZArrayUtil getNotNullArr:arr];
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:arr];
    if (idx < mutArr.count) {
        mutArr[idx] = obj;
    } else {
        NSInteger num = idx - mutArr.count + 1;
        NSMutableArray *rearMutArr = [[NSMutableArray alloc] initWithCapacity:num];
        for (NSInteger index = 0; index <num; ++index) {
            if (index == num - 1) {
                rearMutArr[index] = obj;
            } else {
                rearMutArr[index] = @"";
            }
        }
        return [AZArrayUtil mergeArr:arr rearArr:rearMutArr];
    }
    return mutArr;
}

+ (BOOL)isObjAllNotNull:(NSArray *)arr {
    arr = [AZArrayUtil getNotNullArr:arr];
    for (id obj in arr) {
        if ([AZStringUtil isNullString:obj]) {
            return NO;
        }
    }
    return YES;
}

+ (NSArray *)insertObj:(NSArray *)arr obj:(id)obj {
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:arr];
    [mutArr insertObject:obj atIndex:arr.count];
    return mutArr;
}

+ (NSArray *)insertRearFilterObj:(NSArray *)arr obj:(id)obj {
    if (NSNotFound != [arr indexOfObject:obj]) {
        return arr;
    }
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:arr];
    [mutArr insertObject:obj atIndex:arr.count];
    return mutArr;
}

+ (NSArray *)insertFrontFilterObj:(NSArray *)arr obj:(id)obj {
    if (NSNotFound != [arr indexOfObject:obj]) {
        return arr;
    }
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:arr];
    [mutArr insertObject:obj atIndex:0];
    return mutArr;
}

+ (NSArray *)removeRearObj:(NSArray *)arr {
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:arr];
    [mutArr removeObjectAtIndex:arr.count - 1];
    return mutArr;
}

+ (NSArray *)removeRearObj:(NSArray *)arr count:(NSInteger)count {
    if (arr.count < count) {
        return [[NSArray alloc] init];
    }
    for (int i = 0; i < count; i++) {
        arr = [AZArrayUtil removeRearObj:arr];
    }
    return arr;
}

+ (NSArray *)removeFrontObj:(NSArray *)arr count:(NSInteger)count {
    if (arr.count < count) {
        return [[NSArray alloc] init];
    }
    for (int i = 0; i < count; i++) {
        arr = [AZArrayUtil removeObj:arr atIndex:0];
    }
    return arr;
}

+ (NSArray *)changeValue:(NSArray *)arr idx:(NSInteger)idx value:(id)obj {
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:arr];
    if (idx < mutArr.count && idx > 0) {
        mutArr[idx] = obj;
    }
    return [[NSArray alloc] initWithArray:mutArr];
}

+ (NSArray *)removeObj:(NSArray *)arr atIndex:(NSInteger)idx {
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:arr];
    if (idx < arr.count && idx >= 0) {
        [mutArr removeObjectAtIndex:idx];
    }
    return mutArr;
}

+ (id)getArrObject:(NSArray *)arr index:(NSInteger)idx {
    if (arr.count > idx && idx >= 0) {
        return [arr objectAtIndex:idx];
    }
    return nil;
}

+ (BOOL)isSameArr:(NSArray *)originArr compareArr:(NSArray *)compareArr {
    if (originArr.count == compareArr.count) {
        for (int i = 0; i < originArr.count; i++) {
            NSObject *new = [AZArrayUtil getArrObject:originArr index:i];
            NSObject *old = [AZArrayUtil getArrObject:compareArr index:i];
            if (![new isEqual:old]) {
                return NO;
            }
        }
    } else {
        return NO;
    }
    return YES;
}

@end
