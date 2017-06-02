//
//  AZUserSuggestionVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserSuggestionVC.h"
#import "SZTextView.h"
#import "AZUtil.h"
#import "AZNetRequester.h"

static const NSInteger AZFeedBackTextLenghtMax = 488;

@interface AZUserSuggestionVC () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet SZTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation AZUserSuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > AZFeedBackTextLenghtMax) {
        [AZAlertUtil tipOneMessage:[NSString stringWithFormat:@"最多输入%zd个字哦",AZFeedBackTextLenghtMax]];
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%zd/%zd",textView.text.length,AZFeedBackTextLenghtMax];
}


- (IBAction)commitButtonAction:(id)sender {
    if (self.textView.text.length <= 0) {
        [AZAlertUtil tipOneMessage:@"请输入反馈意见"];
        return;
    }
    
    [AZNetRequester requestAppFeedBackAdd:self.textView.text callBack:^(NSError *error) {
        if (!error) {
            [AZAlertUtil tipOneMessage:@"反馈成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [AZAlertUtil tipOneMessage:error.domain];
        }
    }];
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
