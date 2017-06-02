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
NSString * const AZApiUriAppConfigSet = @"v1/app/config/set/";

NSString * const AZApiUriAppFeedbackAdd = @"v1/app/feedback/add/";


#pragma mark - Common

NSString * const AZApiUriGetQINIUUploadToken = @"v1/util/qiniu/uptoken/";
NSString * const AZApiUriQINIUDomain = @"http://download.duckr.cn/";


#pragma mark - User

NSString * const AZApiUriUserPhoneAuthcodeSend = @"v1/user/phone/authcode/send/";
NSString * const AZApiUriUserLogInWechat = @"v1/user/login/wechat/";
NSString * const AZApiUriUserLogInPhone = @"v1/user/login/phone/";
NSString * const AZApiUriUserLogout = @"v1/user/logout/";


NSString * const AZApiUriUserInfoUpdate = @"v1/user/info/update/";
NSString * const AZApiUriUserInfo = @"v1/user/info/";

NSString * const AZApiUriUserQuestionList = @"v1/user/question/list/";
NSString * const AZApiUriUserAnswerList = @"v1/user/answer/list/";




#pragma mark - Question

NSString * const AZApiUriQuestionDetail = @"v1/question/detail/";
NSString * const AZApiUriQuestionPublish = @"v1/question/publish/";

NSString * const AZApiUriQuestionListNearby = @"v1/question/list/nearby/";
NSString * const AZApiUriQuestionListNews = @"v1/question/list/new/";
NSString * const AZApiUriQuestionListHot = @"v1/question/list/hot/";

NSString * const AZApiUriQuestionAnswerList  = @"v1/question/answer/list/";
NSString * const AZApiUriQuestionAnswerAdd = @"v1/question/answer/add/";


#pragma mark - Order

NSString * const AZApiUriOrderAdd = @"v1/wallet/order/add/";
NSString * const AZApiUriOrderDetail = @"v1/wallet/order/detail/";






