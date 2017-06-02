//
//  AZUserQuestionVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserQuestionVC.h"
#import "AZUtil.h"
#import "AZTopTabView.h"
#import "AZQuestionCell.h"
#import "AZRefreshNormalHeader.h"
#import "AZRefreshAutoNormalFooter.h"
#import "AZNetRequester+User.h"

@interface AZUserQuestionVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, AZTopTabViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tabContainerView;
@property (strong, nonatomic) AZTopTabView *tabView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *allTableView;
@property (weak, nonatomic) IBOutlet UITableView *unFinishTableView;


@property (copy, nonatomic) NSString *allOrderStr;
@property (strong, nonatomic) NSArray *allContentArr;
@property (copy, nonatomic) NSString *unFinishOrderStr;
@property (strong, nonatomic) NSArray *unFinishContentArr;

@end

@implementation AZUserQuestionVC

+ (instancetype)createInstance {
    return (AZUserQuestionVC *)[AZStoryboardUtil getViewController:SBNameUser identifier:VCIDUserQuestionVC];
}

- (void)initVariable {
    [super initVariable];
    
    self.allOrderStr = @"";
    self.unFinishOrderStr = @"";
}

- (void)initObserverNotification {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTopTabView];
    
    [self initScrollView];
    [self initAllTableView];
    [self initUnFinishTableView];
    
    [self headerRefreshAction];
    [self requestUnFinishList];
}

- (void)initScrollView {
    self.scrollView.scrollsToTop = NO;
}

- (void)initTopTabView {
    AZTopTabView *topTabView = [AZTopTabView createInstance];
    topTabView.frame = CGRectMake(0, 0, [AZAppUtil getDeviceWidth], AZTopTabHeightDefault);
    [topTabView updateTitles:@[@"全部", @"未解答"] withMargin:0];
    topTabView.delegate = self;
    topTabView.selectIndex = AZUserQuestionVCType_All;
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

- (void)initUnFinishTableView {
    self.unFinishTableView.estimatedRowHeight = 180;
    self.unFinishTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.unFinishTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
    self.unFinishTableView.mj_header = [AZRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    self.unFinishTableView.mj_footer = [AZRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    self.unFinishTableView.mj_footer.hidden = YES;
}

//- (void)initBlankContentView {
//    self.hotBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.hotTableView insertSubview:self.hotBlankView atIndex:0];
//    self.unFinishBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.unFinishTableView insertSubview:self.unFinishBlankView atIndex:0];
//    self.allBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.unFinishTableView insertSubview:self.allBlankView atIndex:0];
//}

- (void)refreshData {
    //    if ([AZApiUriPhotoDel isEqualToString:self.refreshDataReason] || [AZApiUriPhotoPublish isEqualToString:self.refreshDataReason]) {
    //        [self headerRefreshAction];
    //        return;
    //    }
    //    self.hotContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.hotContentArr];
    //    self.unFinishContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.unFinishContentArr];
    //    self.allContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.allContentArr];
    
    if ([NotificationRefreshReasonViewWillAppear isEqualToString:self.refreshDataReason]) {
        [self updateShow];
    } else {
        [self headerRefreshAction];
    }
}


- (void)headerRefreshAction {
    switch (self.tabView.selectIndex) {
        case AZUserQuestionVCType_All:
            self.allOrderStr = @"";
            break;
        case AZUserQuestionVCType_UnFinish:
            self.unFinishOrderStr = @"";
            break;
    }
    [self requestContentDatas];
}

- (void)footerRefreshAction {
    [self requestContentDatas];
}

- (void)requestContentDatas {
    switch (self.tabView.selectIndex) {
        case AZUserQuestionVCType_All:
            [self requestAllList];
            break;
        case AZUserQuestionVCType_UnFinish:
            [self requestUnFinishList];
            break;
        default:
            break;
    }
}

- (void)updateShow {
    NSInteger index = self.tabView.selectIndex;
    [self scrollViewScrollToIndex:index];
    switch (index) {
        case AZUserQuestionVCType_All:
            [self updateAllScrollView];
            break;
        case AZUserQuestionVCType_UnFinish:
            [self updateUnFinishScrollView];
            break;
    }
}

- (void)scrollViewScrollToIndex:(AZHomeVCTabType)index {
    [self.scrollView scrollRectToVisible:CGRectMake(index * [AZAppUtil getDeviceWidth], 0, [AZAppUtil getDeviceWidth], 10) animated:NO];
}

- (void)updateUnFinishScrollView {
    self.unFinishTableView.scrollsToTop = YES;
    self.allTableView.scrollsToTop = NO;
    
    //    [AZDataManager sharedInstance].unFinishPhotoWrapperArr = self.unFinishContentArr;
    [self.unFinishTableView reloadData];
}

- (void)updateAllScrollView {
    self.unFinishTableView.scrollsToTop = NO;
    self.allTableView.scrollsToTop = YES;
    
    //    [AZDataManager sharedInstance].allPhotoWrapperArr = self.allContentArr;
    [self.allTableView reloadData];
}


#pragma mark - Server Request

- (void)requestUnFinishList {
    __weak typeof (self)weakSelf = self;
    NSString *selfOrderStr = self.unFinishOrderStr;
    [AZNetRequester requestUserQuestionList:AZUserQuestionVCType_UnFinish orderStr:selfOrderStr callBack:^(NSArray *questionWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:weakSelf.unFinishTableView.mj_header footer:weakSelf.unFinishTableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
        if (!error) {
            if ([AZStringUtil isNullString:selfOrderStr]) {
                weakSelf.unFinishContentArr = [[NSArray alloc] init];
            }
            if (![selfOrderStr isEqualToString:orderStr]) {
                weakSelf.unFinishContentArr = [AZArrayUtil mergeArr:weakSelf.unFinishContentArr rearArr:questionWrapperArr];
            }
            weakSelf.unFinishOrderStr = orderStr;
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        weakSelf.unFinishTableView.mj_footer.hidden = weakSelf.unFinishContentArr.count == 0;
    }];
}

- (void)requestAllList {
    __weak typeof (self)weakSelf = self;
    NSString *selfOrderStr = self.allOrderStr;
    [AZNetRequester requestUserQuestionList:AZUserQuestionVCType_All orderStr:selfOrderStr callBack:^(NSArray *questionWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:weakSelf.allTableView.mj_header footer:weakSelf.unFinishTableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
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
        weakSelf.unFinishTableView.mj_footer.hidden = weakSelf.allContentArr.count == 0;
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
    } else if (tableView == self.unFinishTableView) {
        wrapper = [self.unFinishContentArr objectAtIndex:indexPath.row];
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
    } else if (tableView == self.unFinishTableView) {
        return self.unFinishContentArr.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AZQuestionWrapper *wrapper = nil;
    if (tableView == self.allTableView) {
        wrapper = [AZArrayUtil getArrObject:self.allContentArr index:indexPath.row];
    } else if (tableView == self.unFinishTableView) {
        wrapper = [AZArrayUtil getArrObject:self.unFinishContentArr index:indexPath.row];
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
