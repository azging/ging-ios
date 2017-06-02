//
//  AZUserAboutVC.m
//  AnZhi
//
//  Created by LHJ on 2017/5/31.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserAboutVC.h"
#import "AZUtil.h"


@interface AZUserAboutVC ()

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *copyrightLabel;

@end

@implementation AZUserAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.versionLabel.text = [NSString stringWithFormat:@"Version %@", [AZAppUtil getAppLocalShortVersion]];
    self.copyrightLabel.text = [NSString stringWithFormat:@"Copyright©%@ azging.com 保留所有权利", [AZDateUtil getCurrentYearStr]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
