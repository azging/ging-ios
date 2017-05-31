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

static const CGFloat AZQuestionPublishImageGap = 5.0f;
static const NSInteger AZQuestionPublishImageMaxNum = 3;
static const NSInteger AZQuestionPublishImageHeight = 70.0f;

@interface AZQuestionPublishVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AZImageUploadCellDelegate>

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

@end

@implementation AZQuestionPublishVC

+ (instancetype)createInstance {
    return (AZQuestionPublishVC *)[AZStoryboardUtil getViewController:SBNameQuestion identifier:VCIDQuestionPublishVC];
}

- (NSArray *)imageArr {
    if (![AZArrayUtil isValidArray:_imageArr]) {
        UIImage *image = [UIImage imageNamed:AZCommonCameraAddIcon];
        _imageArr = [[NSArray alloc] initWithObjects:image, nil];
    }
    return _imageArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self initCollectionView];
}


- (void)initCollectionView {
//    [self.photoCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AZImageUploadCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([AZImageUploadCell class])];
}


- (IBAction)paymentTFEditingChanged:(UITextField *)sender {
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
//        [AZSwitcherUtil presentToShowCommonPhotoShowVC:indexPath.row imageArr:imageArr];
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
    if ([self.paymentTF.text floatValue] < 0.01) {
        [AZAlertUtil tipOneMessage:@"请输入正确的红包金额"];
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
    
    [self requesetQuestionPublish];
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
            [self requesetQuestionPublish];
            return;
        }
        [AZImageUtil uploadFileToQinu:image imageType:ImageCategoryPhoto completion:^(NSString *imgUrl) {
            image.photoUrl = imgUrl;
            image.uploadFinished = YES;
            
            [self requesetQuestionPublish];
        }];
    }];
    
}

- (void)requesetQuestionPublish {
    
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

    [AZNetRequester requestQuestionPublish:self.titleTF.text desc:self.descTextView.text photoUrlArr:uploadImageArr reward:[self.paymentTF.text floatValue] isAnonymous:self.anonymousSwitch.on callBack:^(AZQuestionWrapper *questionWrapper, NSError *error) {
        [AZAlertUtil hideHud];
        if (!error) {
            [AZSwitcherUtil pushToShowQuestionPublishFinishVC:questionWrapper];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
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
