//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZDataManager.h"
#import "AZStringUtil.h"


@implementation AZDataManager


#pragma mark - Life Cycle

// 获取数据管理器实例
+ (instancetype)sharedInstance {
    static AZDataManager *staticInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[AZDataManager alloc] init];
        [staticInstance initVariable];
    });
    return staticInstance;
}

- (void)initVariable {
}



#pragma mark - Public Func

// 判断用户是否登录
- (BOOL)isUserLogin {
    if (nil == self.userModel || [AZStringUtil isNullString:self.userModel.cid] || [AZStringUtil isNullString:self.userModel.uuid]) {
        return NO;
    }
    return YES;
}

// 读取所有缓存数据
- (void)readData {
    self.isFirstTimeOpenApp = [self readBoolByKey:NSStringFromSelector(@selector(isFirstTimeOpenApp)) withDefaultValue:YES];

    self.userModel = (AZUserModel *)[self readObjByKey:NSStringFromSelector(@selector(userModel))];
    self.clientId = [self readObjByKey:NSStringFromSelector(@selector(clientId))];
    self.deviceUuid = [self readObjByKey:NSStringFromSelector(@selector(deviceUuid))];
    self.deviceToken = [self readObjByKey:NSStringFromSelector(@selector(deviceToken))];
    
   
    self.isAlertLocationCity = [self readBoolByKey:NSStringFromSelector(@selector(isAlertLocationCity)) withDefaultValue:NO];
    self.isReleaseServer = [self readBoolByKey:NSStringFromSelector(@selector(isReleaseServer)) withDefaultValue:NO];
  

}

// 存储所有需要缓存的数据
- (void)saveData {
    [self saveBool:self.isFirstTimeOpenApp withKey:NSStringFromSelector(@selector(isFirstTimeOpenApp))];
      [self saveObj:self.userModel withKey:NSStringFromSelector(@selector(userModel))];
    [self saveObj:self.clientId withKey:NSStringFromSelector(@selector(clientId))];
    [self saveObj:self.deviceUuid withKey:NSStringFromSelector(@selector(deviceUuid))];
    [self saveObj:self.deviceToken withKey:NSStringFromSelector(@selector(deviceToken))];
       [self saveBool:self.isAlertLocationCity withKey:NSStringFromSelector(@selector(isAlertLocationCity))];
    [self saveBool:self.isReleaseServer withKey:NSStringFromSelector(@selector(isReleaseServer))];
   
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self readData];
}



#pragma mark - Private Func

// 清除用户相关数据
- (void)clearUserDefaultForLogout {
    [self saveData];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:NSStringFromSelector(@selector(userInfo))];
    [userDefaults removeObjectForKey:NSStringFromSelector(@selector(userModel))];
    self.userModel = nil;

    [self saveData];
}


- (NSArray *)readArrByKey:(NSString *)key {
    NSData *data = [self readDataByKey:key];
    if (nil == data) {
        return [[NSArray alloc] init];
    }
    return (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (id)readObjByKey:(NSString *)key {
    NSData *data = [self readDataByKey:key];
    if (nil == data) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (BOOL)readBoolByKey:(NSString *)key withDefaultValue:(BOOL)defaultValue {
    NSNumber *value = [self readDataByKey:key];
    if (!value) {
        return defaultValue;
    }
    return [AZStringUtil idToBool:value];
}

- (NSInteger)readIntegerByKey:(NSString *)key withDefaultValue:(NSInteger)defaultValue {
    NSNumber *value = [self readDataByKey:key];
    if (!value) {
        return defaultValue;
    }
    return [AZStringUtil idToNSInteger:value];
}

- (id)readDataByKey:(NSString *)key {
//    key = [AZDataManager keyWithVersion:key];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

- (void)saveBool:(BOOL)value withKey:(NSString *)key {
    NSNumber *number = [NSNumber numberWithBool:value];
    [self saveData:number withKey:key];
}

- (void)saveInteger:(NSInteger)value withKey:(NSString *)key {
    NSNumber *number = [NSNumber numberWithInteger:value];
    [self saveData:number withKey:key];
}

- (void)saveArr:(NSArray *)arr withKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [self saveData:data withKey:key];
}

- (void)saveObj:(id)obj withKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [self saveData:data withKey:key];
}

- (void)saveData:(id)obj withKey:(NSString *)key {
//    key = [AZDataManager keyWithVersion:key];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:obj forKey:key];
}

//+ (NSString *)keyWithVersion:(NSString *)key {
//    return [NSString stringWithFormat:@"%@%@", AZDataManagerVersion, key];
//}

@end
