//
//  AZHomeVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//



#import "AZHomeVC.h"
#import "AZUtil.h"
#import "AZTopTabView.h"
#import "AZQuestionCell.h"
#import "AZRefreshNormalHeader.h"
#import "AZRefreshAutoNormalFooter.h"
#import "AZNetRequester+Question.h"


@interface AZHomeVC () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, AZTopTabViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tabContainerView;
@property (strong, nonatomic) AZTopTabView *tabView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *nearbyTableView;
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (weak, nonatomic) IBOutlet UITableView *hotTableView;


@property (copy, nonatomic) NSString *nearbyOrderStr;
@property (strong, nonatomic) NSArray *nearbyContentArr;
@property (copy, nonatomic) NSString *newsOrderStr;
@property (strong, nonatomic) NSArray *newsContentArr;
@property (copy, nonatomic) NSString *hotOrderStr;
@property (strong, nonatomic) NSArray *hotContentArr;

@end

@implementation AZHomeVC

+ (instancetype)createInstance {
    return (AZHomeVC *)[AZStoryboardUtil getViewController:SBNameHome identifier:VCIDHomeVC];
}

- (void)initVariable {
    [super initVariable];
  
    self.nearbyOrderStr = @"";
    self.newsOrderStr = @"";
    self.hotOrderStr = @"";

//    self.hotContentArr = [LCDataManager sharedInstance].hotPhotoWrapperArr;
//    self.squareContentArr = [LCDataManager sharedInstance].squarePhotoWrapperArr;
//    self.localContentArr = [LCDataManager sharedInstance].localPhotoWrapperArr;
    
}

- (void)initObserverNotification {

}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTopTabView];

    [self initScrollView];
    [self initNearbyTableView];
    [self initNewsTableView];
    [self initHotTableView];

    
}


- (void)initScrollView {
    self.scrollView.scrollsToTop = NO;
}

- (void)initTopTabView {
    AZTopTabView *topTabView = [AZTopTabView createInstance];
    topTabView.frame = CGRectMake(0, 0, [AZAppUtil getDeviceWidth], AZTopTabHeightDefault);
    [topTabView updateTitles:@[@"附近", @"最新", @"热门"] withMargin:0];
    topTabView.delegate = self;
    topTabView.selectIndex = AZHomeVCTabType_Nearby;
    self.tabView = topTabView;
    [self.tabContainerView addSubview:self.tabView];
}

- (void)initNearbyTableView {
    self.nearbyTableView.estimatedRowHeight = 180;
    self.nearbyTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.nearbyTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
    self.nearbyTableView.mj_header = [AZRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    self.nearbyTableView.mj_footer = [AZRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    self.nearbyTableView.mj_footer.hidden = YES;
}

- (void)initNewsTableView {
    self.newsTableView.estimatedRowHeight = 180;
    self.newsTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.newsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
    self.newsTableView.mj_header = [AZRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    self.newsTableView.mj_footer = [AZRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    self.newsTableView.mj_footer.hidden = YES;
}


- (void)initHotTableView {
    self.hotTableView.estimatedRowHeight = 180;
    self.hotTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.hotTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
    self.hotTableView.mj_header = [AZRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    self.hotTableView.mj_footer = [AZRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
    self.hotTableView.mj_footer.hidden = YES;
}





//- (void)initBlankContentView {
//    self.hotBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.hotTableView insertSubview:self.hotBlankView atIndex:0];
//    self.newsBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.newsTableView insertSubview:self.newsBlankView atIndex:0];
//    self.nearbyBlankView = [[AZBlankContentView alloc] initWithTitle:@"暂时还没有玩乐记录，右上角发一个吧！"];
//    [self.newsTableView insertSubview:self.nearbyBlankView atIndex:0];
//}

- (void)refreshData {
//    if ([AZApiUriPhotoDel isEqualToString:self.refreshDataReason] || [AZApiUriPhotoPublish isEqualToString:self.refreshDataReason]) {
//        [self headerRefreshAction];
//        return;
//    }
//    self.hotContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.hotContentArr];
//    self.newsContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.newsContentArr];
//    self.nearbyContentArr = [[AZDataBufferManager sharedInstance] refreshPhotoWrapperArr:self.nearbyContentArr];
    [self updateShow];
}


- (void)headerRefreshAction {
    switch (self.tabView.selectIndex) {
        case AZHomeVCTabType_Nearby:
            self.nearbyOrderStr = @"";
            break;
        case AZHomeVCTabType_News:
            self.newsOrderStr = @"";
            break;
        case AZHomeVCTabType_Hot:
            self.hotOrderStr = @"";
            break;
    }
    [self requestContentDatas];
}

- (void)footerRefreshAction {
    [self requestContentDatas];
}

- (void)requestContentDatas {
    switch (self.tabView.selectIndex) {
        case AZHomeVCTabType_Nearby:
            [self requestNearbyList];
            break;
        case AZHomeVCTabType_News:
            [self requestNewsList];
            break;
        case AZHomeVCTabType_Hot:
            [self requestHotList];
            break;
        default:
            break;
    }
}

- (void)updateShow {
    NSInteger index = self.tabView.selectIndex;
    [self scrollViewScrollToIndex:index];
    switch (index) {
        case AZHomeVCTabType_Nearby:
            [self updateNearbyScrollView];
            break;
        case AZHomeVCTabType_News:
            [self updateNewsScrollView];
            break;
        case AZHomeVCTabType_Hot:
            [self updateHotScrollView];
            break;
    }
}

- (void)scrollViewScrollToIndex:(AZHomeVCTabType)index {
    [self.scrollView scrollRectToVisible:CGRectMake(index * [AZAppUtil getDeviceWidth], 0, [AZAppUtil getDeviceWidth], 10) animated:NO];
}

- (void)updateHotScrollView {
    self.hotTableView.scrollsToTop = YES;
    self.newsTableView.scrollsToTop = NO;
    self.nearbyTableView.scrollsToTop = NO;
    
//    [AZDataManager sharedInstance].hotPhotoWrapperArr = self.hotContentArr;
    [self.hotTableView reloadData];
}

- (void)updateNewsScrollView {
    self.hotTableView.scrollsToTop = NO;
    self.newsTableView.scrollsToTop = YES;
    self.nearbyTableView.scrollsToTop = NO;
    
//    [AZDataManager sharedInstance].newsPhotoWrapperArr = self.newsContentArr;
    [self.newsTableView reloadData];
}

- (void)updateNearbyScrollView {
    self.hotTableView.scrollsToTop = NO;
    self.newsTableView.scrollsToTop = NO;
    self.nearbyTableView.scrollsToTop = YES;
    
//    [AZDataManager sharedInstance].nearbyPhotoWrapperArr = self.nearbyContentArr;
    [self.nearbyTableView reloadData];
}


#pragma mark - Server Request

- (void)requestHotList {
    __weak typeof (self)weakSelf = self;
    NSString *selfOrderStr = self.hotOrderStr;
    [AZNetRequester requestQuestionList:AZHomeVCTabType_Hot orderStr:selfOrderStr callBack:^(NSArray *questionWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:weakSelf.hotTableView.mj_header footer:weakSelf.hotTableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
        if (!error) {
            if ([AZStringUtil isNullString:selfOrderStr]) {
                weakSelf.hotContentArr = [[NSArray alloc] init];
            }
            if (![selfOrderStr isEqualToString:orderStr]) {
                weakSelf.hotContentArr = [AZArrayUtil mergeArr:weakSelf.hotContentArr rearArr:questionWrapperArr];
            }
            weakSelf.hotOrderStr = orderStr;
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        weakSelf.hotTableView.mj_footer.hidden = weakSelf.hotContentArr.count == 0;
    }];
}

- (void)requestNewsList {
    __weak typeof (self)weakSelf = self;
    NSString *selfOrderStr = self.newsOrderStr;
    [AZNetRequester requestQuestionList:AZHomeVCTabType_News orderStr:selfOrderStr callBack:^(NSArray *questionWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:weakSelf.newsTableView.mj_header footer:weakSelf.newsTableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
        if (!error) {
            if ([AZStringUtil isNullString:selfOrderStr]) {
                weakSelf.newsContentArr = [[NSArray alloc] init];
            }
            if (![selfOrderStr isEqualToString:orderStr]) {
                weakSelf.newsContentArr = [AZArrayUtil mergeArr:weakSelf.newsContentArr rearArr:questionWrapperArr];
            }
            weakSelf.newsOrderStr = orderStr;
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        weakSelf.newsTableView.mj_footer.hidden = weakSelf.newsContentArr.count == 0;
    }];
}

- (void)requestNearbyList {
    __weak typeof (self)weakSelf = self;
    NSString *selfOrderStr = self.nearbyOrderStr;
    [AZNetRequester requestQuestionList:AZHomeVCTabType_Nearby orderStr:selfOrderStr callBack:^(NSArray *questionWrapperArr, NSString *orderStr, NSError *error) {
        [AZViewUtil updateShowMJRefresh:weakSelf.nearbyTableView.mj_header footer:weakSelf.newsTableView.mj_footer selfOrderStr:selfOrderStr orderStr:orderStr error:error];
        if (!error) {
            if ([AZStringUtil isNullString:selfOrderStr]) {
                weakSelf.nearbyContentArr = [[NSArray alloc] init];
            }
            if (![selfOrderStr isEqualToString:orderStr]) {
                weakSelf.nearbyContentArr = [AZArrayUtil mergeArr:weakSelf.nearbyContentArr rearArr:questionWrapperArr];
            }
            weakSelf.nearbyOrderStr = orderStr;
            [weakSelf updateShow];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
        weakSelf.newsTableView.mj_footer.hidden = weakSelf.nearbyContentArr.count == 0;
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
    if (tableView == self.nearbyTableView) {
        wrapper = [self.nearbyContentArr objectAtIndex:indexPath.row];
    } else if (tableView == self.newsTableView) {
        wrapper = [self.newsContentArr objectAtIndex:indexPath.row];
    } else if (tableView == self.hotTableView) {
        wrapper = [self.hotContentArr objectAtIndex:indexPath.row];
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
    if (tableView == self.nearbyTableView) {
        return self.nearbyContentArr.count;
    } else if (tableView == self.newsTableView) {
        return self.newsContentArr.count;
    } else if (tableView == self.hotTableView) {
        return self.hotContentArr.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AZQuestionWrapper *wrapper = nil;
    if (tableView == self.nearbyTableView) {
        wrapper = [AZArrayUtil getArrObject:self.nearbyContentArr index:indexPath.row];
    } else if (tableView == self.newsTableView) {
        wrapper = [AZArrayUtil getArrObject:self.newsContentArr index:indexPath.row];
    } else if (tableView == self.hotTableView) {
        wrapper = [AZArrayUtil getArrObject:self.hotContentArr index:indexPath.row];
    }
    [AZSwitcherUtil pushToShowQuestionDetailVC:wrapper];
}



#pragma mark - Button Actions

- (IBAction)userButtonAction:(id)sender {
}

- (IBAction)questionButtonAction:(id)sender {
    [AZSwitcherUtil pushToShowQuestionPublishVC];
}

- (IBAction)moreButtonAction:(id)sender {
    
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
