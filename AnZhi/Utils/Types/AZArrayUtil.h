//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZArrayUtil : NSObject

+ (BOOL)isValidArray:(NSArray *)arr;
+ (NSArray *)mergeArr:(NSArray *)frontArr rearArr:(NSArray *)rearArr;
+ (NSArray *)mergeArr:(NSArray *)frontArr atIndex:(NSInteger)idx rearArr:(NSArray *)rearArr;
+ (NSArray *)updateObject:(NSArray *)arr atIndex:(NSInteger)idx obj:(id)obj;
+ (BOOL)isObjAllNotNull:(NSArray *)arr;
+ (NSArray *)insertObj:(NSArray *)arr obj:(id)obj;
+ (NSArray *)insertFrontFilterObj:(NSArray *)arr obj:(id)obj;
+ (NSArray *)insertRearFilterObj:(NSArray *)arr obj:(id)obj;
+ (NSArray *)getNotNullArr:(NSArray *)arr;
+ (NSArray *)removeRearObj:(NSArray *)arr;
+ (NSArray *)removeRearObj:(NSArray *)arr count:(NSInteger)count;
+ (NSArray *)removeFrontObj:(NSArray *)arr count:(NSInteger)count;
+ (NSArray *)changeValue:(NSArray *)arr idx:(NSInteger)idx value:(id)obj;
+ (NSArray *)removeObj:(NSArray *)arr atIndex:(NSInteger)idx;
+ (id)getArrObject:(NSArray *)arr index:(NSInteger)idx;

+ (BOOL)isSameArr:(NSArray *)originArr compareArr:(NSArray *)compareArr;

@end
