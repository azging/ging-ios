//
//  AZQuestionPublishFinishVC.m
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/20.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZQuestionPublishFinishVC.h"
#import "AZStoryboardUtil.h"

@interface AZQuestionPublishFinishVC ()

@end

@implementation AZQuestionPublishFinishVC

+ (instancetype)createInstance {
    return (AZQuestionPublishFinishVC *)[AZStoryboardUtil getViewController:SBNameQuestion identifier:VCIDQuestionPublishFinishVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
