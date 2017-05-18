//
//  AppDelegate.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZBaseVC.h"

@interface AZAutoRefreshVC : AZBaseVC

- (void)initObserverNotification;
- (void)addObserverNotificationNameToRefreshData:(NSString *)notifyName;
- (void)refreshData;

@property (assign, nonatomic) BOOL isNeedRefreshData;                // 是否需要重新更新网络数据
@property (strong, nonatomic) NSString *refreshDataReason;           // 是什么导致的刷新数据

@end
