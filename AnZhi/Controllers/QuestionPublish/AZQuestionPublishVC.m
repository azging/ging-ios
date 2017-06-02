//
//  AZQuestionPublishVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionPublishVC.h"
#import "AZUtil.h"
#import "SZTextView.h"
#import "UIImage+Upload.h"
#import "AZImageUploadCell.h"
#import "AZNetRequester+Question.h"
#import "AZNetRequester+Order.h"
#import "AZQuestionWrapper.h"
#import "AZOrderWrapper.h"
#import "AZPayHelper.h"

static const CGFloat AZQuestionPublishImageGap = 5.0f;
static const NSInteger AZQuestionPublishImageMaxNum = 3;
static const NSInteger AZQuestionPublishImageHeight = 70.0f;

static const NSInteger AZQuestionDescTextLenghtMax = 280;


@interface AZQuestionPublishVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AZImageUploadCellDelegate, UITextViewDelegate, AZPayHelperDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet SZTextView *descTextView;
@property (weak, nonatomic) IBOutlet UILabel *descCountLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (strong, nonatomic) NSArray *imageArr;

@property (weak, nonatomic) IBOutlet UITextField *paymentTF;
@property (weak, nonatomic) IBOutlet UIImageView *paymentIcon;
@property (weak, nonatomic) IBOutlet UISwitch *anonymousSwitch;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;

@property (assign, nonatomic) NSInteger uploadTimes;

@property (strong, nonatomic) AZPayHelper *payHelper;

@property (strong, nonatomic) AZQuestionWrapper *questionWrapper;

@end

@implementation AZQuestionPublishVC

+ (instancetype)createInstance {
    return (AZQuestionPublishVC *)[AZStoryboardUtil getViewController:SBNameQuestion identifier:VCIDQuestionPublishVC];
}

- (NSArray *)imageArr {
    if (![AZArrayUtil isValidArray:_imageArr]) {
        UIImage *image = [UIImage imageNamed:AZCommonPhotoAddIcon];
        _imageArr = [[NSArray alloc] initWithObjects:image, nil];
    }
    return _imageArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
}

- (void)initCollectionView {
}

- (IBAction)paymentTFEditingChanged:(UITextField *)sender {
    [self updateRewardLevel:[sender.text doubleValue]];
}

- (void)updateRewardLevel:(CGFloat)reward {
    if (reward >= 100 && reward > 0) {
        self.paymentIcon.hidden = YES;
    } else {
        self.paymentIcon.hidden = NO;
        NSInteger level = reward / 10 + 1;
        NSString *iconName = @"RewardLevel_";
        if (level < 6) {
            iconName = [iconName stringByAppendingString:[NSString stringWithFormat:@"%zd", level]];
        } else {
            iconName = [iconName stringByAppendingString:@"6"];
        }
        self.paymentIcon.image = [UIImage imageNamed:iconName];
    }
}


- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > AZQuestionDescTextLenghtMax) {
        [AZAlertUtil tipOneMessage:[NSString stringWithFormat:@"最多输入%zd个字哦",AZQuestionDescTextLenghtMax]];
        return;
    }
    self.descCountLabel.text = [NSString stringWithFormat:@"%zd/%zd",textView.text.length,AZQuestionDescTextLenghtMax];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UICollectionView Delegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return AZQuestionPublishImageGap;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MIN(self.imageArr.count, AZQuestionPublishImageMaxNum);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = [self.imageArr objectAtIndex:indexPath.item];
    AZImageUploadCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AZImageUploadCell class]) forIndexPath:indexPath];
    [cell updateShowPhotoPublishImageCell:image indexPath:indexPath delegate:self];
    cell.deleteButton.hidden = self.imageArr.count - 1 == indexPath.row;
    if (nil == cell) {
        return [[UICollectionViewCell alloc] init];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(AZQuestionPublishImageHeight, AZQuestionPublishImageHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.imageArr.count - 1 == indexPath.row) {
        __weak typeof(self) weakSelf = self;
        [AZViewUtil pickPhotos:(AZQuestionPublishImageMaxNum - self.imageArr.count + 1) callBack:^(NSArray *imageArr) {
            if (imageArr.count > 0) {
                weakSelf.imageArr = [AZArrayUtil mergeArr:weakSelf.imageArr atIndex:(weakSelf.imageArr.count - 1) rearArr:imageArr];
            }
        } cancel:nil];
    } else {
        NSArray *imageArr = [AZArrayUtil removeRearObj:self.imageArr];
        [AZSwitcherUtil presentToShowCommonPhotoShowVC:indexPath.row imageArr:imageArr];
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}

#pragma mark - AZPhotoPublishImageCell delegate

- (void)imageDeleteAction:(NSIndexPath *)indexPath {
    if (self.imageArr.count - 1 != indexPath.row) {
        [AZAlertUtil showActionSheet:@[@"删除"] callBack:^(NSInteger selectIndex) {
            if (1 == selectIndex) {
                self.imageArr = [AZArrayUtil removeObj:self.imageArr atIndex:indexPath.row];
                [self.photoCollectionView reloadData];
            }
        }];
    }
}


- (BOOL)checkInput {
    if ([AZStringUtil isNullString:self.titleTF.text]) {
        [AZAlertUtil tipOneMessage:@"请输入提问标题"];
        return NO;
    }
    if ([AZStringUtil isNullString:self.descTextView.text]) {
        [AZAlertUtil tipOneMessage:@"请输入问题描述"];
        return NO;
    }
    if ([self.paymentTF.text doubleValue] < 0.01) {
        [AZAlertUtil tipOneMessage:@"金额不能少于¥0.01哦"];
        return NO;
    }
    return YES;
}

#pragma mark - Button Actions

- (IBAction)publishButtonAction:(id)sender {
    [self.view endEditing:YES];
    if (![self checkInput]) {
        return;
    }
    
    self.uploadTimes = 0;
    [AZAlertUtil showHudWithHint:@"正在发布..."];
    
    [self questionPublish];
}


- (void)uploadImage {
    self.uploadTimes ++;
    [self uploadImageToQiNiu:self.imageArr];
}

- (void)uploadImageToQiNiu:(NSArray *)imageArr {
    if (self.uploadTimes > 2) {
        [AZAlertUtil hideHud];
        [AZAlertUtil tipOneMessage:@"图片上传出错，请检查网络情况后重试"];
        return;
    }
    
    [imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == imageArr.count - 1) {
            return;
        }
        UIImage *image = (UIImage *)obj;
        if (image.uploadFinished && [AZStringUtil isNotNullString:image.photoUrl]) {
            [self questionPublish];
            return;
        }
        [AZImageUtil uploadFileToQinu:image imageType:ImageCategoryPhoto completion:^(NSString *imgUrl) {
            image.photoUrl = imgUrl;
            image.uploadFinished = YES;
            
            [self questionPublish];
        }];
    }];
    
}

- (void)questionPublish {
    NSArray *uploadImageArr = [AZArrayUtil removeRearObj:self.imageArr];
    NSMutableArray *uploadUrlArr = [NSMutableArray array];
    for (UIImage *image in uploadImageArr) {
        if (image.uploadFinished && [AZStringUtil isNotNullString:image.photoUrl]) {
            [uploadUrlArr addObject:image.photoUrl];
        } else {
            if (image.uploadFinished && [AZStringUtil isNullString:image.photoUrl]) {
                [self uploadImage];
            }
            return;
        }
    }
    
    [self requestQuestionPublish:uploadImageArr];
}

- (void)requestQuestionPublish:(NSArray *)uploadImageArr {
    [AZNetRequester requestQuestionPublish:self.titleTF.text desc:self.descTextView.text photoUrlArr:uploadImageArr reward:[self.paymentTF.text doubleValue] isAnonymous:self.anonymousSwitch.on callBack:^(AZQuestionWrapper *questionWrapper, NSError *error) {
        
        [AZAlertUtil hideHud];
        if (!error) {
            self.questionWrapper = questionWrapper;
            [self addOrder:questionWrapper];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
}


- (void)addOrder:(AZQuestionWrapper *)questionWrapper {
    self.payHelper = [[AZPayHelper alloc] initWithDelegate:self];
    [self.payHelper callWxPay:questionWrapper.questionModel.quid auid:@"" amount:[self.paymentTF.text doubleValue] paymentType:AZOrderPaymentType_Wx tradeType:AZOrderTradeType_QuestionPublish];
}


- (void)paymentHelper:(AZPayHelper *)paymentHelper didPaySucceed:(BOOL)issucceed order:(AZOrderWrapper *)orderWrapper error:(NSError *)error {
    
    //前端支付完成，向后端验证支付状态
    [AZAlertUtil showHudWithHint:@"正在处理"];

//    [NSThread sleepForTimeInterval:0.5f];
    
    //第一次验证订单
    [AZNetRequester requestOrderDetail:orderWrapper.orderModel.ouid callBack:^(AZOrderWrapper *orderWrapper, NSError *error) {
        if (error) {
            //第二次验证订单
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [AZNetRequester requestOrderDetail:orderWrapper.orderModel.ouid callBack:^(AZOrderWrapper *orderWrapper, NSError *error) {
                    if (error) {
                        //第三次验证订单
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [AZNetRequester requestOrderDetail:orderWrapper.orderModel.ouid callBack:^(AZOrderWrapper *orderWrapper, NSError *error) {
                                [AZAlertUtil hideHud];
                                if (error) {
                                    [AZAlertUtil tipOneMessage:@"正在处理您的提问，稍后您可以在我的提问中查看"];
                                    UINavigationController *naviVC = [AZAppUtil getTopMostNavigationController];
                                    [naviVC popViewControllerAnimated:YES];
                                }else{
                                    [self paySuccessPushToFinish];
                                }
                            }];
                        });
                    } else {
                        [AZAlertUtil hideHud];
                        [self paySuccessPushToFinish];
                    }
                }];
            });
        } else {
            [AZAlertUtil hideHud];
            [self paySuccessPushToFinish];
        }
    }];
}

- (void)paySuccessPushToFinish {
    
    [AZNetRequester requestQuestionDetail:self.questionWrapper.questionModel.quid callBack:^(AZQuestionWrapper *questionWrapper, NSError *error) {
        
    }];
    [AZSwitcherUtil pushToShowQuestionPublishFinishVC:self.questionWrapper];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
