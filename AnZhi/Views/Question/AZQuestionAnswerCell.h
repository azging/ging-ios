//
//  AZQuestionAnswerCell.h
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    AZQuestionAnswerCellType_Default    = 0,  // 普通
    AZQuestionAnswerCellType_Adopt      = 1,  // 提问发布者挑选答案
} AZQuestionAnswerCellType;

@class AZAnswerWrapper;
@protocol AZQuestionAnswerCellDelegate;

@interface AZQuestionAnswerCell : UITableViewCell

@property (assign, nonatomic) AZQuestionAnswerCellType cellType;
@property (weak, nonatomic) id<AZQuestionAnswerCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)updateShowAnswerCell:(AZAnswerWrapper *)answerWrapper;

@end

@protocol AZQuestionAnswerCellDelegate <NSObject>
- (void)answerCellShowMoreContent:(AZAnswerWrapper *)answerWrapper indexPath:(NSIndexPath *)indexPath;
- (void)answerCellChoiceAnswer:(AZAnswerWrapper *)answerWrapper indexPath:(NSIndexPath *)indexPath;
@end
