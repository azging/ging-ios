//
//  AZUserVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserVC.h"
#import "AZUtil.h"
#import "AZNetRequester+User.h"
#import "AZDataManager.h"

@interface AZUserVC ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;


@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation AZUserVC

+ (instancetype)createInstance {
    return (AZUserVC *)[AZStoryboardUtil getViewController:SBNameUser identifier:VCIDUserVC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [AZViewUtil updateNavigationBarBackgroundTranslucent:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [AZViewUtil updateNavigationBarBackgroundWhite:self.navigationController.navigationBar];
}

- (void)initVariable {
    [super initVariable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateShow];
}

- (void)refreshData {
    if ([NotificationRefreshReasonViewWillAppear isEqualToString:self.refreshDataReason]) {
        [self updateShow];
    } else {
        [self updateShow];
    }
}

- (void)initObserverNotification {
    [self addObserverNotificationNameToRefreshData:AZApiUriUserInfoUpdate];
}

- (AZUserModel *)getUserModel {
    return [AZDataManager sharedInstance].userModel;
}

- (void)updateShow {
    [AZViewUtil updateViewCircular:self.avatarImageView];
    [AZViewUtil updateAvatarImageView:self.avatarImageView url:[self getUserModel].thumbAvatarUrl];
    self.nickLabel.text = [self getUserModel].nick;
    
    [AZViewUtil updateGenderImageView:self.genderImageView gender:[self getUserModel].gender];
}

- (IBAction)logoutButtonAction:(id)sender {
    [AZNetRequester requestUserLogoutCallBack:^(NSError *error) {
    }];
    
    [[AZDataManager sharedInstance] clearUserDefaultForLogout];
    [[AZDataManager sharedInstance] saveData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
