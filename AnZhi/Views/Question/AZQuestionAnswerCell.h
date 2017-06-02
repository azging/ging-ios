//
//  AZQuestionAnswerCell.h
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZAnswerWrapper;

@interface AZQuestionAnswerCell : UITableViewCell

- (void)updateShowAnswerCell:(AZAnswerWrapper *)answerWrapper;

@end
