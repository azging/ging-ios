//
//  AZRegisterVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZCommonPhotoShowVC.h"
#import "AZCommonPhotoImageCell.h"
#import "AZUtil.h"
#import "AZImageModel.h"

@interface AZCommonPhotoShowVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (assign, nonatomic) BOOL isTopViewShow;

@property (strong, nonatomic) NSArray *imageArr;
@property (strong, nonatomic) NSArray *imageModelArr;

@property (assign, nonatomic) NSInteger scrollToIndex;
@property (assign, nonatomic) BOOL hasScrollToIndex;
@property (assign, nonatomic) NSInteger toPhotoIndex;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@property (assign, nonatomic) BOOL hiddenStatusBar;
@end

@implementation AZCommonPhotoShowVC

+ (instancetype)createInstance {
    return (AZCommonPhotoShowVC *)[AZStoryboardUtil getViewController:SBNameCommon identifier:VCIDCommonPhotoShowVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserveNotification];
    [self initCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTopViewShow];
    [self scrollToIndex:self.scrollToIndex];

    [self hideStatusBar];
    if (!self.isTopViewShow) {
        [self updateNaviBarPhotoShow];
    } else {
        [self updateNaviBarTranslucent];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showStatusBar];
    if (!self.isTopViewShow) {
        [self updateNaviBarNormal];
    } else {
        [self updateNaviBarNormal];
    }
}

//- (BOOL)prefersStatusBarHidden {
//    return self.hiddenStatusBar;
//}

- (void)showStatusBar {
    self.hiddenStatusBar = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)hideStatusBar {
    self.hiddenStatusBar = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)addObserveNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageCellTapImage) name:NotificationCommonPhotoShowVCQuit object:nil];
}

- (void)removeObsever {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationCommonPhotoShowVCQuit object:nil];
}

- (void)imageCellTapImage {
    if (self.isTopViewShow) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([AZAppUtil getDeviceWidth], [AZAppUtil getDeviceHeight]);
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
}

- (void)scrollToIndex:(NSInteger)index {
    if (!self.hasScrollToIndex && index >= 0 && index < [self getContentArrCount]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        });
        self.hasScrollToIndex = YES;
        self.currentIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    }
}

- (NSInteger)getContentArrCount {
    NSInteger count = 0;
    if (self.imageArr.count) {
        count = self.imageArr.count;
    } else if (self.imageModelArr.count) {
        count = self.imageModelArr.count;
    }
    return count;
}

- (void)showTopView {
    self.isTopViewShow = YES;
    [self updateTopViewShow];
}

- (void)updateTopViewShow {
    self.topView.hidden = !self.isTopViewShow;
}

- (void)updateNaviBarTranslucent {
    [AZViewUtil updateNavigationBarBackgroundTranslucent:self.navigationController.navigationBar];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)updateNaviBarPhotoShow {
    [AZViewUtil updateNavigationBarBackgroundPhotoShow:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)updateNaviBarNormal {
    [AZViewUtil updateNavigationBarBackgroundWhite:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setTintColor:[AZColorUtil getColor:AZColorNaviFontDefault]];
    self.navigationController.navigationBar.shadowImage = [AZImageUtil getImageFromColor:[AZColorUtil getColorByRgba:0x000000 alpha:0.3] width:0.1 height:0.1];
}

// 传图片ImageModelArr
- (void)showImageModelArr:(NSArray *)imageModelArr index:(NSInteger)index {
    self.imageModelArr = imageModelArr;
    self.scrollToIndex = index;
    self.hasScrollToIndex = NO;
    [self showTopView];
}
// 传图片arr
- (void)showImageArr:(NSArray *)imageArr index:(NSInteger)index {
    self.imageArr = imageArr;
    self.scrollToIndex = index;
    self.hasScrollToIndex = NO;
    [self showTopView];
}

- (NSArray *)getImageModelArr:(NSArray *)imageUrlArr imageThumbUrlArr:(NSArray *)imageThumbUrlArr {
    NSMutableArray *imageModelArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < imageThumbUrlArr.count; ++i) {
        if (i < imageUrlArr.count) {
            AZImageModel *imageModel = [[AZImageModel alloc] init];
            imageModel.imageUrl = imageUrlArr[i];
            imageModel.imageUrlThumb = imageThumbUrlArr[i];
            [imageModelArr addObject:imageModel];
        }
    }
    return imageModelArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)moreButtonAction:(id)sender {
    [self moreButtonJustCanSavePhoto];
}

- (void)moreButtonJustCanSavePhoto {
    [AZAlertUtil showActionSheet:@[@"保存到手机"] callBack:^(NSInteger selectIndex) {
        if (1 == selectIndex) {
            [self savePhoto];
        }
    }];
}

- (void)savePhoto {
    AZCommonPhotoImageCell *cell = (AZCommonPhotoImageCell *)[self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
    UIImage *image = [cell getImageCellImage];
    [self saveImage:image];
}

- (void)saveImage:(UIImage *)image {
    if (nil != image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        [AZAlertUtil tipOneMessage:@"保存失败！"];
    } else {
        [AZAlertUtil tipOneMessage:@"保存成功！"];
    }
}


#pragma mark - collectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageArr.count) {
        return self.imageArr.count;
    } else if (self.imageModelArr.count) {
        return self.imageModelArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AZCommonPhotoImageCell class]) forIndexPath:indexPath];
    [(AZCommonPhotoImageCell *)cell restoreInitState];
    if (self.imageArr.count) {
        UIImage *image = [AZArrayUtil getArrObject:self.imageArr index:indexPath.item];
        [(AZCommonPhotoImageCell *)cell updateShowPhotoImageCell:image];
    } else if (self.imageModelArr.count) {
        AZImageModel *imageModel = [AZArrayUtil getArrObject:self.imageModelArr index:indexPath.item];
        [(AZCommonPhotoImageCell *)cell updateShowPhotoImageImageModel:imageModel];
    }
    if (nil == cell) {
        return [[UICollectionViewCell alloc] init];
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex = (scrollView.contentOffset.x + 1) / [AZAppUtil getDeviceWidth];
    self.currentIndexPath = [NSIndexPath indexPathForItem:pageIndex inSection:0];
}

- (void)dealloc {
    [self removeObsever];
}

@end
