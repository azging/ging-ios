//
//  AZUserAnswerVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserAnswerVC.h"
#import "AZUtil.h"
#import "AZTopTabView.h"
#import "AZQuestionCell.h"
#import "AZRefreshNormalHeader.h"
#import "AZRefreshAutoNormalFooter.h"
#import "AZNetRequester+User.h"

@interface AZUserAnswerVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, AZTopTabViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tabContainerView;
@property (strong, nonatomic) AZTopTabView *tabView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *allTableView;
@property (weak, nonatomic) IBOutlet UITableView *winTableView;


@property (copy, nonatomic) NSString *allOrderStr;
@property (strong, nonatomic) NSArray *allContentArr;
@property (copy, nonatomic) NSString *winOrderStr;
@property (strong, nonatomic) NSArray *winContentArr;

@end

@implementation AZUserAnswerVC

//+ (instancetype)createInstance {
//    return (AZUserAnswerVC *)[AZStoryboardUtil getViewController:SBNameUser identifier:@""];
//}

- (void)initVariable {
    [super initVariable];
    
    self.allOrderStr = @"";
    self.winOrderStr = @"";
}

- (void)initObserverNotification {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopTabView];
    
    [self initScrollView];
    [self initAllTableView];
    [self initWinTableView];
    
    [self headerRefreshAction];
    [self requestWinList];
}

- (void)initScrollView {
    self.scrollView.scrollsToTop = NO;
}

- (void)initTopTabView {
    AZTopTabView *topTabView = [AZTopTabView createInstance];
    topTabView.frame = CGRectMake(0, 0, [AZAppUtil getDeviceWidth], AZTopTabHeightDefault);
    [topTabView updateTitles:@[@"全部", @"获得红包"] withMargin:0];
    topTabView.delegate = self;
    topTabView.selectIndex = AZUserAnswerVCType_All;
    self.tabView = topTabView;
    [self.tabContainerView addSubview:self.tabView];
}

- (void)initAllTableView {
    self.allTableView.estimatedRowHeight = 180;
    self.allTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.allTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
    self.allTableView.mj_header = [AZRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    self.allTableView.mj_footer = [AZRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    self.allTableView.mj_footer.hidden = YES;
}

- (void)initWinTableView {
    self.winTableView.estimatedRowHeight = 180;
    self.winTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.winTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
    self.winTableView.mj_header = [AZRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    self.winTableView.mj_footer = [AZRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    self.winTableView.mj_footer.hidden = YES;
}

//- (void)initBlankContentView {
//    self.hotBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.hotTableView insertSubview:self.hotBlankView atIndex:0];
//    self.winBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.winTableView insertSubview:self.winBlankView atIndex:0];
//    self.allBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.winTableView insertSubview:self.allBlankView atIndex:0];
//}

- (void)refreshData {
    //    if ([AZApiUriPhotoDel isEqualToString:self.refreshDataReason] || [AZApiUriPhotoPublish isEqualToString:self.refreshDataReason]) {
    //        [self headerRefreshAction];
    //        return;
    //    }
    //    self.hotContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.hotContentArr];
    //    self.winContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.winContentArr];
    //    self.allContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.allContentArr];
    
    if ([NotificationRefreshReasonViewWillAppear isEqualToString:self.refreshDataReason]) {
        [self updateShow];
    } else {
        [self headerRefreshAction];
    }
}


- (void)headerRefreshAction {
    switch (self.tabView.selectIndex) {
        case AZUserAnswerVCType_All:
            self.allOrderStr = @"";
            break;
        case AZUserAnswerVCType_Win:
            self.winOrderStr = @"";
            break;
    }
    [self requestContentDatas];
}

- (void)footerRefreshAction {
    [self requestContentDatas];
}

- (void)requestContentDatas {
    switch (self.tabView.selectIndex) {
        case AZUserAnswerVCType_All:
            [self requestAllList];
            break;
        case AZUserAnswerVCType_Win:
            [self requestWinList];
            break;
        default:
            break;
    }
}

- (void)updateShow {
    NSInteger index = self.tabView.selectIndex;
    [self scrollViewScrollToIndex:index];
    switch (index) {
        case AZUserAnswerVCType_All:
            [self updateAllScrollView];
            break;
        case AZUserAnswerVCType_Win:
            [self updateWinScrollView];
            break;
    }
}

- (void)scrollViewScrollToIndex:(AZHomeVCTabType)index {
    [self.scrollView scrollRectToVisible:CGRectMake(index * [AZAppUtil getDeviceWidth], 0, [AZAppUtil getDeviceWidth], 10) animated:NO];
}

- (void)updateWinScrollView {
    self.winTableView.scrollsToTop = YES;
    self.allTableView.scrollsToTop = NO;
    
    //    [AZDataManager sharedInstance].winPhotoWrapperArr = self.winContentArr;
    [self.winTableView reloadData];
}

- (void)updateAllScrollView {
    self.winTableView.scrollsToTop = NO;
    self.allTableView.scrollsToTop = YES;
    
    //    [AZDataManager sharedInstance].allPhotoWrapperArr = self.allContentArr;
    [self.allTableView reloadData];
}


#pragma mark - Server Request

- (void)requestWinList {
    __weak typeof (self)weakSelf = self;
    NSString *selfOrderStr = self.winOrderStr;
    [AZNetRequester requestUserAnswerList:AZUserAnswerVCType_Win orderStr:selfOrderStr callBack:^(NSArray *questionWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:weakSelf.winTableView.mj_header footer:weakSelf.winTableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
        if (!error) {
            if ([AZStringUtil isNullString:selfOrderStr]) {
                weakSelf.winContentArr = [[NSArray alloc] init];
            }
            if (![selfOrderStr isEqualToString:orderStr]) {
                weakSelf.winContentArr = [AZArrayUtil mergeArr:weakSelf.winContentArr rearArr:questionWrapperArr];
            }
            weakSelf.winOrderStr = orderStr;
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        weakSelf.winTableView.mj_footer.hidden = weakSelf.winContentArr.count == 0;
    }];
}

- (void)requestAllList {
    __weak typeof (self)weakSelf = self;
    NSString *selfOrderStr = self.allOrderStr;
    [AZNetRequester requestUserAnswerList:AZUserAnswerVCType_All orderStr:selfOrderStr callBack:^(NSArray *questionWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:weakSelf.allTableView.mj_header footer:weakSelf.winTableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
        if (!error) {
            if ([AZStringUtil isNullString:selfOrderStr]) {
                weakSelf.allContentArr = [[NSArray alloc] init];
            }
            if (![selfOrderStr isEqualToString:orderStr]) {
                weakSelf.allContentArr = [AZArrayUtil mergeArr:weakSelf.allContentArr rearArr:questionWrapperArr];
            }
            weakSelf.allOrderStr = orderStr;
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        weakSelf.winTableView.mj_footer.hidden = weakSelf.allContentArr.count == 0;
    }];
}


#pragma mark - AZTabView Delegate

- (void)topTabView:(AZTopTabView *)tabView didSelectIndex:(NSInteger)index {
    [self updateShow];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return ;
    }
    if (self.scrollView == scrollView) {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
        [self.tabView setSelectIndex:index];
        [self topTabView:self.tabView didSelectIndex:index];
        [self.scrollView setContentOffset:CGPointMake(index * [AZAppUtil getDeviceWidth], 0.0f) animated:YES];
    }
}

#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AZQuestionWrapper *wrapper = nil;
    if (tableView == self.allTableView) {
        wrapper = [self.allContentArr objectAtIndex:indexPath.row];
    } else if (tableView == self.winTableView) {
        wrapper = [self.winContentArr objectAtIndex:indexPath.row];
    }
    
    AZQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AZQuestionCell class]) forIndexPath:indexPath];
    [cell updateShowQuestionCell:wrapper];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (nil == cell) {
        return [[UITableViewCell alloc] init];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.allTableView) {
        return self.allContentArr.count;
    } else if (tableView == self.winTableView) {
        return self.winContentArr.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AZQuestionWrapper *wrapper = nil;
    if (tableView == self.allTableView) {
        wrapper = [AZArrayUtil getArrObject:self.allContentArr index:indexPath.row];
    } else if (tableView == self.winTableView) {
        wrapper = [AZArrayUtil getArrObject:self.winContentArr index:indexPath.row];
    }
    [AZSwitcherUtil pushToShowQuestionDetailVC:wrapper];
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
