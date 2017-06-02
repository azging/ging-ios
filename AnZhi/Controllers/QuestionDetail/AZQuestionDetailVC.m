//
//  AZQuestionDetailVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionDetailVC.h"
#import "AZUtil.h"
#import "DXTextMessageToolBar.h"
#import "AZQuestionCell.h"
#import "AZQuestionAnswerCell.h"
#import "AZRefreshAutoNormalFooter.h"
#import "AZNetRequester+Question.h"
#import "AZQuestionWrapper.h"
#import "AZAnswerWrapper.h"
#import "AZDataManager.h"
#import "AZPopViewHelper.h"

typedef enum {
    AZQuestionDetailCellType_Info           = 0,
    AZQuestionDetailCellType_Answer         = 1,
} AZQuestionDetailCellType;

static NSInteger const AZQuestionCellSectionNum = 2;

static NSString * const AZQuestionAnswerPlaceHolder = @"留下您的答案...";


@interface AZQuestionDetailVC () <UITableViewDelegate, UITableViewDataSource, DXTextMessageToolBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *answerWrapperArr;
@property (copy, nonatomic) NSString *orderStr;

@property (strong, nonatomic) DXTextMessageToolBar *inputToolBar;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (strong, nonatomic) AZAnswerWrapper *selectedAnswerWrapper;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn;

@end

@implementation AZQuestionDetailVC

+ (instancetype)createInstance {
    return (AZQuestionDetailVC *)[AZStoryboardUtil getViewController:SBNameQuestion identifier:VCIDQuestionDetailVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initInputToolBar];
    [self initTableView];
    [self requestQuestionDetail];
    [self refreshAnswerList];
}

- (void)initObserverNotification {
    [self addObserverNotificationNameToRefreshData:AZApiUriQuestionAnswerAdd];
}

- (void)refreshData {
    if ([NotificationRefreshReasonViewWillAppear isEqualToString:self.refreshDataReason]) {
        [self updateShow];
    } else {
        if ([AZApiUriQuestionAnswerAdd isEqualToString:self.refreshDataReason]) {
            [self refreshAnswerList];
        } else {
            [self requestQuestionDetail];
        }
    }
}


- (void)initTableView {
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionAnswerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionAnswerCell class])];
   
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZCommonHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([AZCommonHeaderView class])];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    
    self.tableView.mj_footer = [AZRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)initInputToolBar {
    _inputToolBar = [DXTextMessageToolBar createToolBar:CGRectMake(0, self.view.frame.size.height - [DXTextMessageToolBar defaultHeight], [AZAppUtil getDeviceWidth], [DXTextMessageToolBar defaultHeight]) placeHolder:AZQuestionAnswerPlaceHolder delegate:self];
    [self.view addSubview:_inputToolBar];
}

- (void)dismissAnswerView {
    [self.inputToolBar.inputTextView resignFirstResponder];
    self.inputToolBar.hidden = YES;
    self.shadowView.hidden = YES;
}

- (void)updateShowAnswerView {
    [self.inputToolBar.inputTextView becomeFirstResponder];
    self.inputToolBar.hidden = NO;
    self.shadowView.hidden = NO;
}

- (BOOL)isInputting {
    return [self.inputToolBar.inputTextView isFirstResponder];
}

- (void)updateShow {
    [self.tableView reloadData];
}

- (void)updateToScrollToAnswer {
    if (self.answerWrapperArr.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:AZQuestionDetailCellType_Answer] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    } else {
        [AZViewUtil updateScrollViewScrollToBottom:self.tableView];
    }
}

- (void)refreshAnswerList {
    self.orderStr = @"";
    [self requestQuestionAnswerList];
}

- (void)footerRefreshAction {
    [self requestQuestionAnswerList];
}

- (IBAction)shadowViewAction:(id)sender {
    [self dismissAnswerView];
}

#pragma mark - Server Request

- (void)requestQuestionDetail {
    __weak typeof(self)weakSelf = self;
    [AZNetRequester requestQuestionDetail:self.questionWrapper.questionModel.quid callBack:^(AZQuestionWrapper *questionWrapper, NSError *error) {
        if (!error) {
            weakSelf.questionWrapper = questionWrapper;
            [weakSelf updateShow];
        } else {
            if (-1 == error.code) {
                [self.navigationController popViewControllerAnimated:YES];
                [AZAlertUtil tipOneMessage:@"该提问已删除"];
            } else {
                [AZAlertUtil tipOneMessage:error.domain];
            }
        }
    }];
}

- (void)requestQuestionAnswerList {
    __weak typeof(self)weakSelf = self;
    NSString *selfOrderStr = self.orderStr;
    [AZNetRequester requestQuestionAnswerList:self.questionWrapper.questionModel.quid orderStr:selfOrderStr callBack:^(NSArray *answerWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:nil footer:weakSelf.tableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
        if (!error) {
            if ([AZStringUtil isNullString:selfOrderStr]) {
                weakSelf.answerWrapperArr = [[NSArray alloc] init];
            }
            if (![selfOrderStr isEqualToString:orderStr]) {
                weakSelf.answerWrapperArr = [AZArrayUtil mergeArr:weakSelf.answerWrapperArr rearArr:answerWrapperArr];
            }
            weakSelf.orderStr = orderStr;
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        weakSelf.tableView.mj_footer.hidden = weakSelf.answerWrapperArr.count == 0;
    }];
}



#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return AZQuestionCellSectionNum;
//    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    switch (section) {
        case AZQuestionDetailCellType_Info:
            number = 1;
            break;
        case AZQuestionDetailCellType_Answer:
            number = self.answerWrapperArr.count;
            break;
        default:
            break;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case AZQuestionDetailCellType_Info: {
            AZQuestionCell *questionCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AZQuestionCell class]) forIndexPath:indexPath];
            [questionCell updateShowQuestionCell:self.questionWrapper];
            cell = questionCell;
        }
            break;

        case AZQuestionDetailCellType_Answer: {
            AZQuestionAnswerCell *answerCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AZQuestionAnswerCell class]) forIndexPath:indexPath];
            AZAnswerWrapper *answerWrapper = [AZArrayUtil getArrObject:self.answerWrapperArr index:indexPath.row];
            [answerCell updateShowAnswerCell:answerWrapper];
            cell = answerCell;
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (nil == cell) {
        return [[UITableViewCell alloc] init];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == AZQuestionDetailCellType_Answer) {
        if (self.answerWrapperArr.count > 0) {
            return 45.0f;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == AZQuestionDetailCellType_Answer) {
        if (self.answerWrapperArr.count > 0) {
            UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
            header.textLabel.text = @"回答";
            return header;
        }
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == AZQuestionDetailCellType_Info) {
        return 12;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (AZQuestionDetailCellType_Answer == indexPath.section) {
        if ([self isInputting]) {
            [self.inputToolBar.inputTextView resignFirstResponder];
//            self.inputToolBar.inputTextView.placeHolder = AZQuestionAnswerPlaceHolder;
        } else {
            if (self.answerWrapperArr.count > indexPath.row) {

                [self updateShowAnswerView];
                //                self.selectedAnswerWrapper = [AZArrayUtil getArrObject:self.answerWrapperArr index:indexPath.row];
                //                self.inputToolBar.inputTextView.placeHolder = [NSString stringWithFormat:@"回复:%@:", self.selectedAnswerWrapper.createUserWrapper.userModel.nick];
            }
        }
    }
}

#pragma mark - XHMessageTextView Delegate

- (void)inputTextViewDidBeginEditing:(XHMessageTextView *)messageInputTextView {
    
}

- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView {
    
}

- (void)didChangeFrameToHeight:(CGFloat)toHeight {
    
}

- (void)didSendText:(NSString *)text {
    [self dismissAnswerView];
    if ([AZStringUtil isNullString:text]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [AZNetRequester requestQuestionAnswerAdd:self.questionWrapper.questionModel.quid content:text callBack:^(AZAnswerWrapper *answerWrapper, NSError *error) {
        if (!error) {
            [AZAlertUtil tipOneMessage:@"回答成功"];
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
    
    self.inputToolBar.inputTextView.placeHolder = AZQuestionAnswerPlaceHolder;
}


#pragma mark - UIButton Actions

- (IBAction)answerAction:(id)sender {
    if (![[AZDataManager sharedInstance] isUserLogin]) {
        [AZSwitcherUtil presentToShowRegisterVC];
        return;
    }
    [self updateShowAnswerView];
    [self updateToScrollToAnswer];
}



- (IBAction)shareAction:(id)sender {
    [[AZPopViewHelper sharedInstance] popSocailShareView:self.questionWrapper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
