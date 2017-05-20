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

static const CGFloat AZQuestionPublishImageImageGap = 3.0f;
static const NSInteger AZQuestionPublishImageImageColumNum = 3;
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
@property (weak, nonatomic) IBOutlet UISwitch *hideSwitchBar;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;

@end

@implementation AZQuestionPublishVC

+ (instancetype)createInstance {
    return (AZQuestionPublishVC *)[AZStoryboardUtil getViewController:SBNameQuestion identifier:VCIDQuestionPublishVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}







- (IBAction)paymentTFEditingChanged:(UITextField *)sender {
}


#pragma mark - UICollectionView Delegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return AZQuestionPublishImageImageGap;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MIN(self.imageArr.count, AZQuestionPublishImageMaxNum);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = [self.imageArr objectAtIndex:indexPath.row];
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
                [weakSelf uploadImageToQiNiu:imageArr];
            }
        } cancel:nil];
    } else {
        NSArray *imageArr = [AZArrayUtil removeRearObj:self.imageArr];
//        [AZSwitcherUtil presentToShowCommonPhotoShowVC:indexPath.row imageArr:imageArr];
    }
}

- (void)uploadImageToQiNiu:(NSArray *)imageArr {
    [imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = (UIImage *)obj;
        [AZImageUtil uploadFileToQinu:image imageType:ImageCategoryPhoto completion:^(NSString *imgUrl) {
            image.photoUrl = imgUrl;
            image.uploadFinished = YES;
        }];
    }];
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
//                [self updateShow];
            }
        }];
    }
}

#pragma mark - Button Actions

- (IBAction)publishButtonAction:(id)sender {
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
