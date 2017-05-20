//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZAutoRefreshVC.h"
#import "AZStringUtil.h"

@interface AZAutoRefreshVC ()
@property (strong, nonatomic) NSMutableArray *notificationNameMutArr;

@end

@implementation AZAutoRefreshVC


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initObserverNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    self.refreshDataReason = NotificationRefreshReasonViewWillAppear;
    if ([AZStringUtil isNullString:self.refreshDataReason]) {
        self.refreshDataReason = NotificationRefreshReasonViewWillAppear;
    }
    [self refreshDataIfNeed];
}

- (NSMutableArray *)notificationNameMutArr {
    if (!_notificationNameMutArr) {
        _notificationNameMutArr = [NSMutableArray array];
    }
    return _notificationNameMutArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom Init

- (void)initVariable {
    [super initVariable];
    self.isNeedRefreshData = YES;
}

- (void)initObserverNotification {
}


#pragma mark Private Func

- (void)setNeedRefreshData:(NSNotification *)notification {
    self.refreshDataReason = notification.name;
    self.isNeedRefreshData = YES;
    
    if (self.isAppearing) {
        [self refreshDataIfNeed];
    }
}

- (void)refreshDataIfNeed {
    if (self.isNeedRefreshData) {
        self.isNeedRefreshData = NO;
        [self refreshData];
    }
}


#pragma mark - Public Func

- (void)addObserverNotificationNameToRefreshData:(NSString *)notifyName {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedRefreshData:) name:notifyName object:nil];
    [self addNotifyName:notifyName];
}

- (void)addNotifyName:(NSString *)notifyName {
    BOOL hasAdd = NO;
    for (NSString *name in self.notificationNameMutArr) {
        if ([name isEqualToString:[AZStringUtil getNotNullStr:notifyName]]) {
            hasAdd = YES;
        }
    }
    if (!hasAdd) {
        [self.notificationNameMutArr addObject:notifyName];
    }
}

- (void)refreshData {
    
}

- (void)dealloc {
    [self removeAllObserver];
}

- (void)removeAllObserver {
    for (NSString *notifyName in self.notificationNameMutArr) {
        if ([AZStringUtil isNotNullString:notifyName]) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:notifyName object:nil];
        }
    }
}

@end
