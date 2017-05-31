//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZApiConstant.h"

#pragma mark - App
NSString * const AZApiUriAppConfigInit = @"";
NSString * const AZApiUriAppConfigSet = @"";


#pragma mark - Common

NSString * const AZApiUriGetQINIUUploadToken = @"";
NSString * const AZApiUriQINIUDomain = @"";
NSString * const AZApiUriGetSchoolList = @"";


#pragma mark - User

NSString * const AZApiUriUserPhoneAuthcodeSend = @"v1/user/phone/authcode/send/";
NSString * const AZApiUriUserLogInWechat = @"v1/user/login/wechat/";
NSString * const AZApiUriUserLogInPhone = @"v1/user/login/phone/";
NSString * const AZApiUriUserLogout = @"v1/user/logout/";


NSString * const AZApiUriUserInfoUpdate = @"";
NSString * const AZApiUriUserInfo = @"";


#pragma mark - Question

NSString * const AZApiUriQuestionDetail = @"v1/question/detail/";
NSString * const AZApiUriQuestionPublish = @"v1/question/publish/";

NSString * const AZApiUriQuestionListNearby = @"v1/question/list/nearby/";
NSString * const AZApiUriQuestionListNews = @"v1/question/list/new/";
NSString * const AZApiUriQuestionListHot = @"v1/question/list/hot/";

