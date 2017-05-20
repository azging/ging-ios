//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZConstant.h"
//#import "AZUtil.h"
//#import "AZNetRequester.h"

@interface AZBaseVC : UIViewController

+ (instancetype)createInstance;
- (void)initVariable;

@property (assign, nonatomic) BOOL isStatByMob;             // 是否进行友盟统计
@property (assign, nonatomic) BOOL isAppearing;             // 是否在viewWillAppear和viewWillDisappear之间的状态

@end
