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

CF_EXPORT NSString * const AZServerXmppName;
CF_EXPORT NSString * const AZServerXmppIp;
CF_EXPORT NSInteger const AZServerXmppPort;

CF_EXPORT NSString * const AZUriMobileActivBrief;
CF_EXPORT NSString * const AZUriMobileActivRoute;
CF_EXPORT NSString * const AZUriMobileInvitePublishCoinsExplain;
CF_EXPORT NSString * const AZUriMobileInviteJoinCoinsExplain;
CF_EXPORT NSString * const AZUriMobileActivShareDetail;
CF_EXPORT NSString * const AZUriMobileInviteShareDetaile;
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

typedef enum : NSUInteger {
    OrderPaymentType_Default    = 0,
    OrderPaymentType_Ali        = 1,
    OrderPaymentType_Wx         = 2,
    OrderPaymentType_Coins      = 3,
    OrderPaymentType_Free       = 4,
} OrderPaymentType;

typedef enum : NSInteger {
    AZCommonReportType_Default     = 0,
    AZCommonReportType_Invite      = 1,
    AZCommonReportType_Photo       = 2,
} AZCommonReportType;

typedef enum : NSInteger {
    AZMsgNotifyVCType_AllMsg       = 0,
    AZMsgNotifyVCType_Photo        = 1,
} AZMsgNotifyVCType;

typedef enum : NSInteger {
    AZUserSearchType_Default            = 0,    // 搜索全部duckr用户
    AZUserSearchType_Contact            = 1,    // 搜索用户的通讯录
    AZUserSearchType_Focus              = 2,    // 搜索用户关注的人
    AZUserSearchType_Fans               = 3,    // 搜索用户的粉丝
    AZUserSearchType_PhoneContact       = 4,    // 搜索用户的手机通讯录
} AZUserSearchType;

#endif /* AZConstant_h */
