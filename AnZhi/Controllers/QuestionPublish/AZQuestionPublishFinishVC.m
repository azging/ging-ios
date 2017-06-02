//
//  AZQuestionPublishFinishVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/20.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionPublishFinishVC.h"
#import "AZStoryboardUtil.h"
#import "AZQuestionCell.h"

@interface AZQuestionPublishFinishVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@end

@implementation AZQuestionPublishFinishVC

+ (instancetype)createInstance {
    return (AZQuestionPublishFinishVC *)[AZStoryboardUtil getViewController:SBNameQuestion identifier:VCIDQuestionPublishFinishVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.hidesBackButton = YES;
    [self initTableView];
}

- (void)initTableView {
    self.tableView.estimatedRowHeight = 180;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AZQuestionCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AZQuestionCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionWrapper ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AZQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AZQuestionCell class]) forIndexPath:indexPath];
    [cell updateShowQuestionCell:self.questionWrapper];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
    if (nil == cell) {
        return [[UITableViewCell alloc] init];
    }
    return cell;
}

- (IBAction)finishButtonAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
