//
//  AZUserWalletVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserWalletVC.h"
#import "AZUtil.h"
#import "AZNetRequester+Order.h"

@interface AZUserWalletVC ()
@property (weak, nonatomic) IBOutlet UILabel *walletLabel;

@property (assign, nonatomic) CGFloat balance;
@end

@implementation AZUserWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initObserverNotification {
    [self addObserverNotificationNameToRefreshData:AZApiUriWalletBalanceToCash];
}

- (void)refreshData {
    if ([NotificationRefreshReasonViewWillAppear isEqualToString:self.refreshDataReason]) {
        [self updateShow];
    } else {
        [self requestWalletBalance];
    }
}

- (void)updateShow {
    self.walletLabel.text = [NSString stringWithFormat:@"¥ %f", self.balance];
}

- (void)requestWalletBalance {
    [AZNetRequester requestWalletBalance:^(CGFloat balance, NSError *error) {
        if (!error) {
            self.balance = balance;
            [self updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
}

- (IBAction)toCashButtonAction:(id)sender {
    [AZAlertUtil alertTwoButton:@"取消" btnTwo:@"确定" withTitle:@"提现" msg:@"确定将所有余额全部提现吗？" callBack:^(NSInteger selectIndex) {
        if (1 == selectIndex) {
            [AZNetRequester requestWalletBalanceToCash:self.balance callBack:^(NSError *error) {
                if (!error) {
                    [AZAlertUtil tipOneMessage:@"请求成功，请等待后台处理"];
                } else {
                    [AZAlertUtil tipOneMessage:error.domain];
                }
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
