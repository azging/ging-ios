//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AZApiConstant.h"
#import "AZStoryboardConstant.h"
#import "AZColorConstant.h"
#import "AZImageConstant.h"

#ifndef AZConstant_h
#define AZConstant_h


#pragma mark - Server

CF_EXPORT NSString * const AZServerDomain;
CF_EXPORT NSString * const AZServerApiPrefix;
CF_EXPORT NSString * const AZServerMobilePrefix;

CF_EXPORT NSString * const AZUriMobileUserPolicy;
CF_EXPORT NSString * const AZUriMobileReportUserPolicy;

#pragma mark - Common

CF_EXPORT float const AZConstantMarginDefault;
CF_EXPORT float const AZConstantTabRefreshMinSec;

#pragma mark - DeviceScreen

CF_EXPORT float const AZDeviceHeight4Or4S;
CF_EXPORT float const AZDeviceHeight5Or5S;
CF_EXPORT float const AZDeviceHeight6Or6SOr7;
CF_EXPORT float const AZDeviceHeight6POr6PSOr7P;

CF_EXPORT float const AZDeviceWidth4Or4S;
CF_EXPORT float const AZDeviceWidth5Or5S;
CF_EXPORT float const AZDeviceWidth6Or6SOr7;
CF_EXPORT float const AZDeviceWidth6POr6PSOr7P;


#pragma mark - Top Tab

// 上方选项卡的高度
CF_EXPORT float const AZTopTabHeightDefault;


#pragma mark - Navigation

// 导航栏的高度
CF_EXPORT float const AZNavigationHeight;
CF_EXPORT float const AZNaviStatusBarHeight;


#pragma mark - Keyboard

// 文字键盘的高度
CF_EXPORT float const AZKeyboardTextHeight;
// 数字键盘的高度
CF_EXPORT float const AZKeyboardNumHeight;


#pragma mark - Font

// 文字的字体
CF_EXPORT NSString * const AZFontNameDefault;
// 文字的字体默认大小
CF_EXPORT float const AZFontSizeDefault;

CF_EXPORT NSInteger const AZSearchMaxRecordNum;

#pragma mark - UserEditing

CF_EXPORT NSInteger const AZUserNickMaxLength;
CF_EXPORT NSInteger const AZUserSignatureMaxLength;


#pragma mark - Notification

CF_EXPORT NSString *const NotificationRefreshReasonViewWillAppear;
// 登录的通知
CF_EXPORT NSString *const NotificationUserJustLogin;
// 位置更新的通知
CF_EXPORT NSString *const NotificationJustUpdateLocation;
// 定位失败的通知
CF_EXPORT NSString *const NotificationJustFailUpdateLocation;
// 重置密码的通知
CF_EXPORT NSString *const NotificationUserJustResetPassword;
extern NSString *const NotificationJustRegisterGexinClientID;

CF_EXPORT NSString * const NotificationCommonPhotoShowVCQuit;

// 微信支付回调的通知
CF_EXPORT NSString *const NotificationWxPay;
CF_EXPORT NSString *const NotificationWxPayResultKey;
CF_EXPORT NSString *const NotificationAliPay;
CF_EXPORT NSString *const NotificationAliPayResultKey;

CF_EXPORT NSString *const BlankContentIconNotify;

// 基于商品的邀约详情中，购票入局的通知
CF_EXPORT NSString *const NotificationCommonRelatedActivCellBuyButtonAction;

CF_EXPORT NSString *const NotificationReceiveChatMessageAPN;
CF_EXPORT NSString *const NotificationReceiveChatMessageAddContact;
CF_EXPORT NSString *const NotificationReceiveXMPPConnected;
CF_EXPORT NSString *const NotificationDidReceiveXMPPMessage;
CF_EXPORT NSString *const NotificationDidReceiveXMPPChatMessage;
CF_EXPORT NSString *const NotificationDidReceiveXMPPGroupMessage;
CF_EXPORT NSString *const NotificationDidSendXMPPMessage;
CF_EXPORT NSString *const XMPPMessageKey;
CF_EXPORT NSString *const BareJidStringKey;
CF_EXPORT NSString *const XMPPPrivacyListName;
CF_EXPORT NSString *const NotificationUnreadNumDidChange;
CF_EXPORT NSString *const NotificationRedDotNumDidChange;
CF_EXPORT NSString *const AZChatSendMessageFailToast;

// 3DTouch的通知
CF_EXPORT NSString *const Notification3DTouchInvitePublish;
CF_EXPORT NSString *const Notification3DTouchPhotoPublish;
CF_EXPORT NSString *const Notification3DTouchHotPhoto;

// RecordAudio 播放状态变更通知
CF_EXPORT NSString *const NotificationRecordAudioPlayStatusChanged;
CF_EXPORT float const RecordAudioMaxTime;
CF_EXPORT float const RecordAudioMinTime;

#pragma mark - Invite

CF_EXPORT NSString *const AZInviteActivityCastMe;
CF_EXPORT NSString *const AZInviteActivityCastAA;

// 阴影遮罩的透明度
CF_EXPORT float const AZAlertViewMaskAlpha;

CF_EXPORT NSInteger const AZInvitePublishMinAssureCoins;
CF_EXPORT float const AZInvitePublishMaxRequireCoinsCoef;
CF_EXPORT NSInteger const AZInvitePublishMaxPhotoNum;


//BlankContent
CF_EXPORT NSInteger const BlankContentMarginTop;
CF_EXPORT NSString *const BlankContentImageA;

// App下载页面
CF_EXPORT NSString *const AZConstantAppDownloadUrl;
CF_EXPORT NSString *const AZConstantPayAliScheme;

CF_EXPORT NSString *const AZConstantAvatarDefault;

typedef enum : NSUInteger {
    UserGender_Default  = 0,
    UserGender_Male     = 1,
    UserGender_Female   = 2,
} UserGender;


typedef enum : NSInteger {
    AZHomeVCTabType_Nearby          = 0,  // 附近
    AZHomeVCTabType_News            = 1,  // 最新
    AZHomeVCTabType_Hot             = 2,  // 最热
} AZHomeVCTabType;

typedef enum : NSUInteger {
    AZUserQuestionVCType_All            = 0,  // 全部
    AZUserQuestionVCType_UnFinish       = 1,  // 未解决
} AZUserQuestionVCType;

typedef enum : NSUInteger {
    AZUserAnswerVCType_All              = 0,   // 全部
    AZUserAnswerVCType_Win              = 1,   // 获得红包
} AZUserAnswerVCType;


typedef enum : NSInteger {
    AZOrderPaymentType_Unknown          = 0, // 未知
    AZOrderPaymentType_Wallet           = 1, // 余额
    AZOrderPaymentType_Wx               = 2, // 微信
} AZOrderPaymentType;

typedef enum : NSInteger {
    AZOrderTradeType_Unknown                = 0, // 未知
    AZOrderTradeType_QuestionPublish        = 1, // 提问
    AZOrderTradeType_AnswerAdopt            = 2, // 采纳答案
    AZOrderTradeType_ToCash                 = 3, // 提现
} AZOrderTradeType;




#endif /* AZConstant_h */
