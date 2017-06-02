//
//  AZQuestionCell.m
//  AnZhi
//
//  Created by LHJ on 2017/5/23.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionCell.h"
#import "AZQuestionWrapper.h"
#import "AZViewUtil.h"
#import "AZAppUtil.h"
#import "AZSwitcherUtil.h"
#import "AZImageCollectionCell.h"

static const CGFloat AZQuestionImageGap = 5.0f;

@interface AZQuestionCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rewardLevelIcon;
@property (weak, nonatomic) IBOutlet UILabel *rewardLevelLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) AZQuestionWrapper *questionWrapper;

@end

@implementation AZQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [AZViewUtil updateViewCircular:self.avatarImageView];
    
    [self initCollectionView];
}

- (void)initCollectionView {
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.scrollEnabled = NO;
    self.photoCollectionView.scrollsToTop = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.photoCollectionView.collectionViewLayout = layout;
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AZImageCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([AZImageCollectionCell class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (AZUserModel *)createUser {
    return self.questionWrapper.createUserWrapper.userModel;
}

- (void)updateShowQuestionCell:(AZQuestionWrapper *)questionWrapper {

    self.questionWrapper = questionWrapper;
    
    [AZViewUtil updateAvatarImageView:self.avatarImageView url:[self createUser].thumbAvatarUrl];
    self.nickLabel.text = [self createUser].nick;
    [AZViewUtil updateGenderImageView:self.genderImageView gender:[self createUser].gender];
    
    [self updateRewardLevel];
    
    self.titleLabel.text = questionWrapper.questionModel.title;
    self.descLabel.text = questionWrapper.questionModel.desc;
    
    [self updateShowPhotoView];
    [self updateQuestionStatus];
}

- (void)updateQuestionStatus {
    self.timeLabel.text = @"";
    if (AZQuestionStatus_ANSWERING ==  self.questionWrapper.questionModel.status) {
        self.timeImageView.image = [UIImage imageNamed:@"QuestionTimeIcon"];
        self.timeLabel.text = [NSString stringWithFormat:@"剩余%@，已有%zd人回答，回答被选中者可获得红包", self.questionWrapper.questionModel.expireTimeStr, self.questionWrapper.questionModel.answerNum];
    } else if (self.questionWrapper.questionModel.status > AZQuestionStatus_ANSWERING) {
        self.timeImageView.image = [UIImage imageNamed:@"QuestionFinishIcon"];
        self.timeLabel.text = @"已结束";
    }
}

- (void)updateRewardLevel {
    
    if (self.questionWrapper.questionModel.reward >= 100) {
        self.rewardLevelIcon.hidden = YES;
        self.rewardLevelLabel.text = [NSString stringWithFormat:@"¥ %f",self.questionWrapper.questionModel.reward];
    } else {
        self.rewardLevelIcon.hidden = NO;
        self.rewardLevelLabel.text = @"";
        
        NSInteger level = self.questionWrapper.questionModel.reward / 10 + 1;
        
        NSString *iconName = @"RewardLevel_";
        if (level < 6) {
            iconName = [iconName stringByAppendingString:[NSString stringWithFormat:@"%zd", level]];
        } else {
            iconName = [iconName stringByAppendingString:@"6"];
        }
        
        self.rewardLevelIcon.image = [UIImage imageNamed:iconName];
    }
    
}

- (void)updateShowPhotoView {
    self.photoHeightConstraint.constant = self.questionWrapper.questionModel.thumbPhotoUrls.count ? [self getPhotoHeight] : 0;
    
    [self.photoCollectionView reloadData];
}

- (CGFloat)getPhotoHeight {
    return ([AZAppUtil getDeviceWidth] - 2 * 16.0 - 2 * AZQuestionImageGap) / 3;
}


#pragma mark UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.questionWrapper.questionModel.thumbPhotoUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AZImageCollectionCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AZImageCollectionCell class]) forIndexPath:indexPath];
    if (nil != self.questionWrapper.questionModel.thumbPhotoUrls && indexPath.item < self.questionWrapper.questionModel.thumbPhotoUrls.count) {
        [cell updateImageCollectionCell:[self.questionWrapper.questionModel.thumbPhotoUrls objectAtIndex:indexPath.item]];
    }
    if (nil == cell) {
        return [[UICollectionViewCell alloc] init];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([self getPhotoHeight], [self getPhotoHeight]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return AZQuestionImageGap;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [AZSwitcherUtil presentToShowCommonPhotoShowVC:indexPath.row imageUrlArr:self.questionWrapper.questionModel.photoUrls imageThumbUrlArr:self.questionWrapper.questionModel.thumbPhotoUrls];
}


@end
