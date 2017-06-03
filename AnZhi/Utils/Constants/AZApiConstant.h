//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef AZApiConstant_h
#define AZApiConstant_h


#pragma mark - App
CF_EXPORT NSString * const AZApiUriAppConfigInit;
CF_EXPORT NSString * const AZApiUriAppConfigSet;
CF_EXPORT NSString * const AZApiUriAppFeedbackAdd;


#pragma mark - Common

CF_EXPORT NSString * const AZApiUriGetQINIUUploadToken;
CF_EXPORT NSString * const AZApiUriQINIUDomain;


#pragma mark - User

CF_EXPORT NSString * const AZApiUriUserPhoneAuthcodeSend;
CF_EXPORT NSString * const AZApiUriUserLogInWechat;
CF_EXPORT NSString * const AZApiUriUserLogInPhone;
CF_EXPORT NSString * const AZApiUriUserLogout;


CF_EXPORT NSString * const AZApiUriUserInfoUpdate;
CF_EXPORT NSString * const AZApiUriUserInfo;

CF_EXPORT NSString * const AZApiUriUserQuestionList;
CF_EXPORT NSString * const AZApiUriUserAnswerList;



#pragma mark - Question

CF_EXPORT NSString * const AZApiUriQuestionDetail;
CF_EXPORT NSString * const AZApiUriQuestionPublish;

CF_EXPORT NSString * const AZApiUriQuestionListNearby;
CF_EXPORT NSString * const AZApiUriQuestionListNews;
CF_EXPORT NSString * const AZApiUriQuestionListHot;

CF_EXPORT NSString * const AZApiUriQuestionAnswerList;
CF_EXPORT NSString * const AZApiUriQuestionAnswerAdd;

CF_EXPORT NSString * const AZApiUriQuestionAnswerAdopt;


#pragma mark - Order 

CF_EXPORT NSString * const AZApiUriOrderAdd;
CF_EXPORT NSString * const AZApiUriOrderDetail;

CF_EXPORT NSString * const AZApiUriWalletBalance;
CF_EXPORT NSString * const AZApiUriWalletBalanceToCash;


#endif /* AZApiConstant_h */
