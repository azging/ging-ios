//
//  AZQuestionAnswerCell.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionAnswerCell.h"

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


@end

@implementation AZQuestionAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateShowAnswerCell:(AZAnswerWrapper *)answerWrapper {

}

@end
