//
//  AZRegisterVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZRegisterVC.h"
#import "AZUtil.h"
#import "AZSwitcherUtil.h"
#import "AZNetRequester+User.h"
#import "AZAlertUtil.h"
#import <UMSocialCore/UMSocialCore.h>
#import "AZWebVC.h"
#import "AZDataManager.h"


static const NSInteger VerifyCodeLength = 6;
static const NSInteger INTERVAL_FOR_SEND_AUTHCODE = 60;
static NSInteger countDownTime;

@interface AZRegisterVC () <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *phoneBGView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIView *codeBGView;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *logInBtn;


@end

@implementation AZRegisterVC

+ (instancetype)createInstance {
    return (AZRegisterVC *)[AZStoryboardUtil getViewController:SBNameRegister identifier:VCIDRegisterVC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [AZViewUtil updateNavigationBarBackgroundTranslucent:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [AZViewUtil updateNavigationBarBackgroundWhite:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}


- (void)initSubViews {
    [AZViewUtil updateViewBoarder:self.phoneBGView width:1.0f rgbColor:AZColorTextApp];
    [AZViewUtil updateViewBoarder:self.codeBGView width:1.0f rgbColor:AZColorTextApp];
    
    [AZViewUtil updateViewCornerRadius:self.phoneBGView cornerRadius:5.0f];
    [AZViewUtil updateViewCornerRadius:self.codeBGView cornerRadius:5.0f];
    
    [AZViewUtil updateViewCornerRadius:self.logInBtn cornerRadius:5.0f];
    
//    self.logInBtn.enabled = NO;
}

- (void)startCountDown {
    [self resetSendBtnState];
    [self countDown];
}

- (void)countDown {
    countDownTime--;
    if (countDownTime > 0) {
        [self.sendBtn setEnabled:NO];
        self.sendBtn.alpha = 0.5;
        [self.sendBtn setTitle:[NSString stringWithFormat:@"%zds", countDownTime] forState:UIControlStateNormal];
        [self performSelector:@selector(countDown) withObject:nil afterDelay:1];
    } else {
        [self resetSendBtnState];
    }
}


#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.codeTF) {
        NSString *verifyCode = textField.text;
        verifyCode = [verifyCode stringByReplacingCharactersInRange:range withString:string];
        
        [self updateShowWithVerifyCode:verifyCode];
        
        if (verifyCode.length > VerifyCodeLength) {
            return NO;
        }
    }
    return YES;
}

- (void)updateShowWithVerifyCode:(NSString *)code {
    self.logInBtn.enabled = code.length == VerifyCodeLength;
}


#pragma mark - CountDown & Button state

- (void)resetSendBtnState {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(countDown) object:nil];
    countDownTime = INTERVAL_FOR_SEND_AUTHCODE;
    [self setSendBtnEnable];
}

- (void)setSendBtnEnable {
    self.sendBtn.enabled = YES;
    self.sendBtn.alpha = 1.0;
    [self.sendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
}

- (BOOL)checkPhoneNum {
    return [AZPhoneUtil isPhoneNum:self.phoneTF.text];
}

#pragma Button Actions


- (IBAction)cancleButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sendButtonAction:(id)sender {
    
    if (![self checkPhoneNum]) {
        [AZAlertUtil tipOneMessage:@"请输入正确的手机号"];
        return;
    }
    
    [self startCountDown];
    [AZNetRequester requestUserPhoneAuthcodeSend:self.phoneTF.text callBack:^(NSError *error) {
        if (!error) {
            [AZAlertUtil tipOneMessage:@"发送成功"];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
            [self resetSendBtnState];
        }
    }];
}

- (IBAction)logInButtonAction:(id)sender {
    
    if (![self checkPhoneNum]) {
        [AZAlertUtil tipOneMessage:@"请输入正确的手机号"];
        return;
    }
    [AZNetRequester requestUserLoginPhone:self.phoneTF.text code:self.codeTF.text callBack:^(AZUserModel *userModel, NSError *error) {
        if (!error) {
            [self registerSuccess:userModel];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
}

- (void)registerSuccess:(AZUserModel *)userModel {
    [AZAlertUtil tipOneMessage:@"登录成功"];
    [self cancleButtonAction:nil];
    [AZDataManager sharedInstance].userModel = userModel;
    [[AZDataManager sharedInstance] saveData];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserJustLogin object:nil];
}

- (IBAction)weChatButtonAction:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        
        if (!error) {
            UMSocialUserInfoResponse *resp = result;
            
            UserGender userGender = UserGender_Default;
            if ([@"男" isEqualToString:resp.unionGender] || [@"male" isEqualToString:resp.unionGender]) {
                userGender = UserGender_Male;
            } else if ([@"女" isEqualToString:resp.unionGender] || [@"female" isEqualToString:resp.unionGender]) {
                userGender = UserGender_Female;
            }
            
            [AZNetRequester requestUserLoginThird:resp.uid
                                             nick:resp.name
                                        avatarUrl:resp.iconurl
                                           gender:userGender
                                             type:UMSocialPlatformType_WechatSession
                                         callBack:^(AZUserModel *userModel, NSError *error) {
                                             if (!error) {
                                                 [self registerSuccess:userModel];
                                             } else {
                                                 [AZAlertUtil tipOneMessage:error.domain];
                                             }
                                         }];
            
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        
    }];
}

- (IBAction)userPolicyButtonAction:(id)sender {
    NSString *url = [AZStringUtil getServerFullUrl:AZServerMobilePrefix suffix:AZUriMobileUserPolicy];
    AZWebVC *vc = [AZWebVC createInstance];
    vc.webUrlStr = url;
    vc.titleForUserPolicy = @"协议条款";
    vc.isShowForUserPolicy = YES;
    [AZSwitcherUtil presentToShowWebVC:vc];
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
