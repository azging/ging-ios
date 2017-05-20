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

@interface AZRegisterVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *naviBar;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *logInBtn;


@end

@implementation AZRegisterVC

+ (instancetype)createInstance {
    return (AZRegisterVC *)[AZStoryboardUtil getViewController:SBNameRegister identifier:VCIDRegisterVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}


#pragma Button Actions


- (IBAction)cancleButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sendButtonAction:(id)sender {
    [AZNetRequester requestUserPhoneAuthcodeSend:self.phoneTF.text callBack:^(NSError *error) {
        if (!error) {
            [AZAlertUtil tipOneMessage:@"发送成功"];
        }
    }];
}

- (IBAction)logInButtonAction:(id)sender {
    [AZNetRequester requestUserLoginPhone:self.phoneTF.text code:self.codeTF.text callBack:^(AZUserModel *userModel, NSError *error) {
        if (!error) {
            
        }
    }];
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
