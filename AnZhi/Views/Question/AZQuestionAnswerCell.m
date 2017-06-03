//
//  AZQuestionAnswerCell.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionAnswerCell.h"
#import "AZAnswerWrapper.h"
#import "AZViewUtil.h"
#import "AZDateUtil.h"
#import "AZAppUtil.h"


static NSString * const AZAnswerShowTextMore = @"展开";
static NSString * const AZAnswerShowTextShort = @"收起";

static const CGFloat AZAnswerContentTextHeightShort = 40.0f;
static const CGFloat AZAnswerContentMoreContainerViewHeight = 20.0f;

@interface AZQuestionAnswerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;

@property (weak, nonatomic) IBOutlet UIImageView *questionWinIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *questionChoiceAnswerBtn;

@property (weak, nonatomic) IBOutlet UILabel *answerContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerContentLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreContainerHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) AZAnswerWrapper *answerWrapper;


@end

@implementation AZQuestionAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [AZViewUtil updateViewCircular:self.avatarImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (AZUserModel *)createUser {
    return self.answerWrapper.createUserWrapper.userModel;
}

- (void)updateShowAnswerCell:(AZAnswerWrapper *)answerWrapper {

    self.answerWrapper = answerWrapper;
    
    [AZViewUtil updateAvatarImageView:self.avatarImageView url:[self createUser].thumbAvatarUrl];
    self.nickLabel.text = [self createUser].nick;
    [AZViewUtil updateGenderImageView:self.genderImageView gender:[self createUser].gender];
    
    self.questionWinIconImageView.hidden = YES;
    self.questionChoiceAnswerBtn.hidden = YES;
    if (AZQuestionAnswerCellType_Default == self.cellType) {
        self.questionWinIconImageView.hidden = answerWrapper.answerModel.status == AZAnswerStatus_Default;
    } else {
        self.questionChoiceAnswerBtn.hidden = NO;
    }
    
    self.answerContentLabel.text = [AZStringUtil getNotNullStr:answerWrapper.answerModel.content];
    
    [self updateContentView];
    
    self.timeLabel.text = [AZDateUtil getCreatedTimeStrFromDateTimeStr:answerWrapper.answerModel.createTime];
}

- (void)updateContentView {
    CGSize size = CGSizeMake([AZAppUtil getDeviceWidth] - 30.0f, MAXFLOAT);
    CGRect contentRect = [self.answerWrapper.answerModel.content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.answerContentLabel.font} context:nil];
    //[UIFont fontWithName:AZFontNameDefault size:14.0f]
    //self.answerContentLabel.font
    if (contentRect.size.height < AZAnswerContentTextHeightShort) {
        self.moreContainerHeightConstraint.constant = 0.0f;
        self.answerContentLabelHeightConstraint.constant = contentRect.size.height;
    } else {
        self.moreContainerHeightConstraint.constant = AZAnswerContentMoreContainerViewHeight;
        if (self.answerWrapper.showMoreContent) {
            self.answerContentLabelHeightConstraint.constant = contentRect.size.height + 10;
        } else {
            self.answerContentLabelHeightConstraint.constant = AZAnswerContentTextHeightShort;
        }
        self.moreBtn.selected = self.answerWrapper.showMoreContent;
    }
    [self setNeedsLayout];
    self.answerContentLabel.text = [AZStringUtil getNotNullStr:self.answerWrapper.answerModel.content];
}

- (IBAction)moreButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.answerWrapper.showMoreContent = sender.selected;
    [self updateContentView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(answerCellShowMoreContent: indexPath:)]) {
        [self.delegate answerCellShowMoreContent:self.answerWrapper indexPath:self.indexPath];
    }
}

- (IBAction)choiceButtonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(answerCellChoiceAnswer:indexPath:)]) {
        [self.delegate answerCellChoiceAnswer:self.answerWrapper indexPath:self.indexPath];
    }
}

@end
