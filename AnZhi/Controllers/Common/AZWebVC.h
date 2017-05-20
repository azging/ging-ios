//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZBaseVC.h"

@interface AZWebVC : AZBaseVC

@property (copy, nonatomic) NSString *webUrlStr;

@property (assign, nonatomic) BOOL isShowForUserPolicy;
@property (copy, nonatomic) NSString *titleForUserPolicy;

@end
