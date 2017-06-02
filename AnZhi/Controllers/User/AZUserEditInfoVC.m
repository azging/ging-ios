//
//  AZUserEditInfoVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserEditInfoVC.h"
#import "AZUserModel.h"
#import "NSString+Additions.h"
#import "AZUtil.h"
#import "AZDataManager.h"
#import "AZNetRequester+User.h"

@interface AZUserEditInfoVC ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UITextField *nickTF;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@property (weak, nonatomic) IBOutlet UIView *pickerContainerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (assign, nonatomic) BOOL pickedPhoto;

@property (strong, nonatomic) NSArray *genderStrArr;

@property (copy, nonatomic) AZUserModel *userModel;

@end

@implementation AZUserEditInfoVC

- (void)initVariable {
    [super initVariable];
    
    self.genderStrArr = @[@"男",@"女"];
    self.userModel = [AZDataManager sharedInstance].userModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateShow];
}

- (void)updateShow {
    
    [AZViewUtil updateViewCircular:self.avatarImageView];
    
    [AZViewUtil updateAvatarImageView:self.avatarImageView url:self.userModel.thumbAvatarUrl];
    
    self.nickTF.text = [self.userModel.nick nonBreakSpaceString];
    
    NSString *genderStr = @"";
    if (UserGender_Male == self.userModel.gender) {
        genderStr = @"男";
    } else if (UserGender_Female == self.userModel.gender) {
        genderStr = @"女";
    }
    self.genderLabel.text = genderStr;
}


#pragma mark - Server Request

- (void)requestUpdateUserInfo {
    [AZNetRequester requestUpdateUserInfo:self.userModel callBack:^(AZUserModel *userModel, NSError *error) {
        [AZAlertUtil hideHud];
        self.pickedPhoto = NO;
        if (!error) {
            [AZAlertUtil tipOneMessage:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
}


- (BOOL)checkInput {
    self.userModel.nick = self.nickTF.text;
    if (self.nickTF.text.length > AZUserNickMaxLength) {
        [AZAlertUtil tipOneMessage:[NSString stringWithFormat:@"昵称不能超过%zd个字哦", AZUserNickMaxLength]];
        [self.nickTF becomeFirstResponder];
        return NO;
    }
    
    if (!self.pickedPhoto) {
        if ([self.userModel isEqual:[AZDataManager sharedInstance].userModel]) {
            [AZAlertUtil tipOneMessage:@"没有更改信息"];
            return NO;
        }
    }
    return YES;
}


#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.nickTF) {
        if (textField.text.length > AZUserNickMaxLength) {
            [AZAlertUtil tipOneMessage:[NSString stringWithFormat:@"昵称不能超过%zd个字哦", AZUserNickMaxLength]];
        }
        self.userModel.nick = self.nickTF.text;
    }
}


- (IBAction)textFieldEditingChanged:(id)sender {
    UITextField *textField = (UITextField *)sender;
    NSRange range = [textField.text rangeOfString:@" "];
    if (range.length && range.location < textField.text.length) {
        textField.text = [textField.text nonBreakSpaceString];
    }
}

#pragma mark UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.genderStrArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [AZArrayUtil getArrObject:self.genderStrArr index:row];
}

#pragma mark - Button Actions

- (IBAction)avatarButtonAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    [AZViewUtil pickPhotos:1 callBack:^(NSArray *imageArr) {
        if (1 == imageArr.count) {
            UIImage *image = [imageArr firstObject];
            weakSelf.avatarImageView.image = image;
            weakSelf.pickedPhoto = YES;
        }
    } cancel:nil];
}

- (void)uploadImageToQiNiu:(UIImage *)image callBack:(void(^)(NSString *imageUrl))callBack {
    [AZImageUtil uploadFileToQinu:image imageType:ImageCategoryPhoto completion:^(NSString *imgUrl) {
        if (callBack) {
            callBack(imgUrl);
        }
    }];
}

- (IBAction)genderButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self.pickerView reloadAllComponents];
    self.pickerContainerView.hidden = NO;
}

- (IBAction)cancelPickViewAction:(id)sender {
    self.pickerContainerView.hidden = YES;
}

- (IBAction)confirmPickViewAction:(id)sender {
    self.pickerContainerView.hidden = YES;
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    self.userModel.gender = row + 1;
    self.genderLabel.text = [AZArrayUtil getArrObject:self.genderStrArr index:row];
}

- (IBAction)saveButtonAction:(id)sender {
    [self.view endEditing:YES];
    if (![self checkInput]) {
        return;
    }
    if (self.pickedPhoto) {
        UIImage *uploadImage = self.avatarImageView.image;
        if (!uploadImage) {
            [AZAlertUtil tipOneMessage:@"请添加头像"];
            return;
        }
        [AZAlertUtil showHudWithHint:@"正在保存用户信息..."];
        [self uploadImageToQiNiu:uploadImage callBack:^(NSString *imageUrl) {
            if ([AZStringUtil isNullString:imageUrl]) {
                [AZAlertUtil hideHud];
                [AZAlertUtil tipOneMessage:@"上传图片出错，请检查网络情况"];
            } else {
                self.userModel.avatarUrl = imageUrl;
                [self requestUpdateUserInfo];
            }
        }];
    } else {
        [AZAlertUtil showHudWithHint:@"正在保存用户信息..."];
        [self requestUpdateUserInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
