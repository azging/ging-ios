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


#pragma mark - Common

CF_EXPORT NSString * const AZApiUriGetQINIUUploadToken;
CF_EXPORT NSString * const AZApiUriQINIUDomain;
CF_EXPORT NSString * const AZApiUriGetSchoolList;


#pragma mark - User

CF_EXPORT NSString * const AZApiUriUserPhoneAuthcodeSend;
CF_EXPORT NSString * const AZApiUriUserLogInWechat;
CF_EXPORT NSString * const AZApiUriUserLogInPhone;
CF_EXPORT NSString * const AZApiUriUserLogout;



CF_EXPORT NSString * const AZApiUriUserInfoUpdate;
CF_EXPORT NSString * const AZApiUriUserInfo;



#pragma mark - Question

CF_EXPORT NSString * const AZApiUriQuestionDetail;
CF_EXPORT NSString * const AZApiUriQuestionPublish;

CF_EXPORT NSString * const AZApiUriQuestionListNearby;
CF_EXPORT NSString * const AZApiUriQuestionListNews;
CF_EXPORT NSString * const AZApiUriQuestionListHot;


#endif /* AZApiConstant_h */
