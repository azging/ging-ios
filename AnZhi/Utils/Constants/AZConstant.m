//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZConstant.h"
#import <UIKit/UIKit.h>


#pragma mark - Server


NSString * const AZServerDomain = @"http://www.azging.com/dev/";
NSString * const AZServerApiPrefix = @"http://www.azging.com/dev/api/";
NSString * const AZServerMobilePrefix = @"http://www.azging.com/dev/mobile/";


//NSString * const AZServerDomain = @"http://www.azging.com/ging/";
//NSString * const AZServerApiPrefix = @"http://www.azging.com/ging/api/";
//NSString * const AZServerMobilePrefix = @"http://www.azging.com/ging/mobile/";


//NSString * const AZServerDomain = @"http://47.93.28.215/ging/";
//NSString * const AZServerApiPrefix = @"http://47.93.28.215/ging/api/";
//NSString * const AZServerMobilePrefix = @"http://47.93.28.215/ging/mobile/";


NSString * const AZUriMobileUserPolicy = @"user/policy/";
NSString * const AZUriMobileReportUserPolicy = @"report/user/policy/";


#pragma mark - Common

float const AZConstantMarginDefault = 12.0f;
float const AZConstantTabRefreshMinSec = 120.0f;

#pragma mark - DeviceScreen

float const AZDeviceHeight4Or4S = 480.0f;
float const AZDeviceHeight5Or5S = 568.0f;
float const AZDeviceHeight6Or6SOr7 = 667.0f;
float const AZDeviceHeight6POr6PSOr7P = 736.0f;

float const AZDeviceWidth4Or4S = 320.0f;
float const AZDeviceWidth5Or5S = 320.0f;
float const AZDeviceWidth6Or6SOr7 = 375.0f;
float const AZDeviceWidth6POr6PSOr7P = 414.0f;


#pragma mark - Top Tab

// 上方选项卡的高度
float const AZTopTabHeightDefault = 44.0f;


#pragma mark - Navigation

// 导航栏的高度
float const AZNavigationHeight = 44.0f;
float const AZNaviStatusBarHeight = 20.0f;


#pragma mark - Keyboard

// 文字键盘的高度
float const AZKeyboardTextHeight = 250.0f;
// 数字键盘的高度
float const AZKeyboardNumHeight = 216.0f;


#pragma mark - Font

// 文字的字体
NSString * const AZFontNameDefault = @"FZLanTingHeiS-R-GB";
// 文字的字体默认大小
float const AZFontSizeDefault = 17.0f;

NSInteger const AZSearchMaxRecordNum = 10;


#pragma mark - UserEditing

NSInteger const AZUserNickMaxLength         = 20;
NSInteger const AZUserSignatureMaxLength    = 30;



#pragma mark - Notification

NSString *const NotificationRefreshReasonViewWillAppear = @"NotificationRefreshReasonViewWillAppear";
// 登录的通知
NSString *const NotificationUserJustLogin = @"NotificationUserJustLogin";
// 位置更新的通知
NSString *const NotificationJustUpdateLocation = @"NotificationJustUpdateLocation";
// 定位失败的通知
NSString *const NotificationJustFailUpdateLocation = @"NotificationJustFailUpdateLocation";
// 重置密码的通知
NSString *const NotificationUserJustResetPassword = @"NotificationUserJustResetPassword";
NSString *const NotificationJustRegisterGexinClientID = @"NotificationJustRegisterGexinClientID";

NSString * const NotificationCommonPhotoShowVCQuit = @"NotificationCommonPhotoShowVCQuit";

// 微信支付回调的通知
NSString *const NotificationWxPay = @"NotificationWxPay";
NSString *const NotificationWxPayResultKey = @"NotificationWxPayResultKey";
NSString *const NotificationAliPay = @"NotificationAliPay";
NSString *const NotificationAliPayResultKey = @"NotificationAliPayResultKey";

// 无关注
NSString *const BlankContentIconNotify = @"BlankContentIconNotify";

// 基于商品的邀约详情中，购票入局的通知
NSString *const NotificationCommonRelatedActivCellBuyButtonAction = @"NotificationCommonRelatedActivCellBuyButtonAction";

NSString *const NotificationReceiveChatMessageAPN = @"NotificationReceiveChatMessage";
NSString *const NotificationReceiveChatMessageAddContact = @"NotificationReceiveChatMessageAddContact";
NSString *const NotificationReceiveXMPPConnected = @"NotificationReceiveXMPPConnected";
NSString *const NotificationDidReceiveXMPPMessage = @"NotificationDidReceiveXMPPMessage";
NSString *const NotificationDidReceiveXMPPChatMessage = @"NotificationDidReceiveXMPPChatMessage";
NSString *const NotificationDidReceiveXMPPGroupMessage = @"NotificationDidReceiveXMPPGroupMessage";
NSString *const NotificationDidSendXMPPMessage = @"NotificationDidSendXMPPMessage";
NSString *const XMPPMessageKey = @"XMPPMessageKey";
NSString *const BareJidStringKey = @"BareJidStringKey";
NSString *const XMPPPrivacyListName = @"public";
NSString *const NotificationUnreadNumDidChange = @"NotificationUnreadNumDidChange";
NSString *const NotificationRedDotNumDidChange = @"NotificationRedDotNumDidChange";
NSString *const AZChatSendMessageFailToast = @"发送消息失败，请检查网络连接";

// 3DTouch的通知
NSString *const Notification3DTouchInvitePublish        = @"Notification3DTouchInvitePublish";
NSString *const Notification3DTouchPhotoPublish         = @"Notification3DTouchPhotoPublish";
NSString *const Notification3DTouchHotPhoto             = @"Notification3DTouchHotPhoto";

// RecordAudio 播放状态变更通知
NSString *const NotificationRecordAudioPlayStatusChanged    = @"NotificationRecordAudioPlayStatusChanged";
float const RecordAudioMaxTime = 10.5;
float const RecordAudioMinTime = 1.0;

#pragma mark - Invite

NSString * const AZInviteActivityCastMe     = @"我请客";
NSString * const AZInviteActivityCastAA     = @"AA";


// 阴影遮罩的透明度
float const AZAlertViewMaskAlpha = 0.7;
NSInteger const AZInvitePublishMinAssureCoins = 20;
float const AZInvitePublishMaxRequireCoinsCoef = 0.5;
NSInteger const AZInvitePublishMaxPhotoNum = 3;

//BlankContent
NSInteger const BlankContentMarginTop = 100;
NSString *const BlankContentImageA = @"BlankContentIconA";

NSString *const AZConstantAppDownloadUrl = @"https://itunes.apple.com/cn/app/da-ke/id916449492?l=en&mt=8";

NSString *const AZConstantPayAliScheme = @"com.baiying.LinkCity.alipay";

NSString *const AZConstantAvatarDefault = @"http://download.duckr.cn/DuckrDefaultPhoto.png";
