//
//  AZApiConstant.h
//  LinkCity
//
//  Created by 张宗硕 on 8/26/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef AZApiConstant_h
#define AZApiConstant_h


#pragma mark - Activ

CF_EXPORT NSString * const AZApiUriActivDetail;
CF_EXPORT NSString * const AZApiUriActivInterestAdd;
CF_EXPORT NSString * const AZApiUriActivInterestDel;
CF_EXPORT NSString * const AZApiUriActivCommentList;
CF_EXPORT NSString * const AZApiUriActivInterestList;
CF_EXPORT NSString * const AZApiUriActivInviteList;
CF_EXPORT NSString * const AZApiUriActivPhotoList;
CF_EXPORT NSString * const AZApiUriActivCommentAdd;
CF_EXPORT NSString * const AZApiUriActivJoinList;
CF_EXPORT NSString * const AZApiUriActivQuit;
CF_EXPORT NSString * const AZApiUriActivChatNotify;
CF_EXPORT NSString * const AZApiUriActivChatStatus;
CF_EXPORT NSString * const AZApiUriActivShareAdd;


#pragma mark - App
CF_EXPORT NSString * const AZApiUriAppConfigInit;
CF_EXPORT NSString * const AZApiUriAppConfigSet;
CF_EXPORT NSString * const AZApiUriPlaceBusinessArea;
CF_EXPORT NSString * const AZApiUriAppSearchThemeActiv;
CF_EXPORT NSString * const AZApiUriAppRedDot;
CF_EXPORT NSString * const AZApiUriAppBannerActivList;
CF_EXPORT NSString * const AZApiUriAppSystemUserInfo;
CF_EXPORT NSString * const AZApiUriAppDuckrEval;

#pragma mark - Common

CF_EXPORT NSString * const AZApiUriGetQINIUUploadToken;
CF_EXPORT NSString * const AZApiUriQINIUDomain;
CF_EXPORT NSString * const AZApiUriGetSchoolList;


#pragma mark - Home

CF_EXPORT NSString * const AZApiUriHomeRcmdList;
CF_EXPORT NSString * const AZApiUriHomeInviteList;
CF_EXPORT NSString * const AZApiUriHomeSearchCalendar;
CF_EXPORT NSString * const AZApiUriHomeSearchText;
CF_EXPORT NSString * const AZApiUriHomeSearchActiv;
CF_EXPORT NSString * const AZApiUriHomeRcmdActivMore;
CF_EXPORT NSString * const AZApiUriHomeSearchTextActiv;
CF_EXPORT NSString * const AZApiUriHomeSearchTextInvite;


#pragma mark - Calendar 

CF_EXPORT NSString * const AZApiUriCalendarEventPublish;
CF_EXPORT NSString * const AZApiUriCalendarEventDetail;
CF_EXPORT NSString * const AZApiUriCalendarEventDel;
CF_EXPORT NSString * const AZApiUriCalendarDayDetail;
CF_EXPORT NSString * const AZApiUriCalendarDayList;
CF_EXPORT NSString * const AZApiUriCalendarDayFocusList;
CF_EXPORT NSString * const AZApiUriCalendarSearchList;
CF_EXPORT NSString * const AZApiUriCalendarFreeTimeList;
CF_EXPORT NSString * const AZApiUriCalendarFreeTimeMark;
CF_EXPORT NSString * const AZApiUriCalendarFileAdd;
CF_EXPORT NSString * const AZApiUriCalendarScheduleList;
CF_EXPORT NSString * const AZApiUriCalendarFocusList;
CF_EXPORT NSString * const AZApiUriCalendarRcmdList;

#pragma mark - Match

CF_EXPORT NSString * const AZApiUriMatchActivList;
CF_EXPORT NSString * const AZApiUriMatchActivAdd;
CF_EXPORT NSString * const AZApiUriMatchActivBack;
CF_EXPORT NSString * const AZApiUriMatchMsgActiv;


#pragma mark - Local

CF_EXPORT NSString * const AZApiUriLocalActivBusiness;
CF_EXPORT NSString * const AZApiUriLocalActivList;
CF_EXPORT NSString * const AZApiUriLocalActivTheme;
CF_EXPORT NSString * const AZApiUriLocalInviteList;
CF_EXPORT NSString * const AZApiUriLocalLeisureJoin;
CF_EXPORT NSString * const AZApiUriLocalLeisureList;
CF_EXPORT NSString * const AZApiUriLocalSearchCalendar;
CF_EXPORT NSString * const AZApiUriLocalLeisureScrollList;
CF_EXPORT NSString * const AZApiUriLocalFocusList;
CF_EXPORT NSString * const AZApiUriLocalFocusThemeList;
CF_EXPORT NSString * const AZApiUriLocalFocusRcmdList;


#pragma mark - Invite

CF_EXPORT NSString * const AZApiUriInvitePublish;
CF_EXPORT NSString * const AZApiUriInviteDetail;
CF_EXPORT NSString * const AZApiUriInviteCommentList;
CF_EXPORT NSString * const AZApiUriInviteCommentAdd;
CF_EXPORT NSString * const AZApiUriInviteInterestList;
CF_EXPORT NSString * const AZApiUriInviteInterestAdd;
CF_EXPORT NSString * const AZApiUriInviteInterestDel;
CF_EXPORT NSString * const AZApiUriInviteJoinList;
CF_EXPORT NSString * const AZApiUriInviteJoin;
CF_EXPORT NSString * const AZApiUriInviteQuit;
CF_EXPORT NSString * const AZApiUriInviteChatNotify;
CF_EXPORT NSString * const AZApiUriInviteChatStatus;
CF_EXPORT NSString * const AZApiUriInviteShareAdd;


#pragma mark - Photo

CF_EXPORT NSString * const AZApiUriPhotoPublish;
CF_EXPORT NSString * const AZApiUriPhotoDetail;
CF_EXPORT NSString * const AZApiUriPhotoDel;
CF_EXPORT NSString * const AZApiUriPhotoListHot;
CF_EXPORT NSString * const AZApiUriPhotoListFlow;
CF_EXPORT NSString * const AZApiUriPhotoListLocal;
CF_EXPORT NSString * const AZApiUriPhotoLikeDel;
CF_EXPORT NSString * const AZApiUriPhotoLikeAdd;
CF_EXPORT NSString * const AZApiUriPhotoLikeList;
CF_EXPORT NSString * const AZApiUriPhotoCommentList;
CF_EXPORT NSString * const AZApiUriPhotoCommentAdd;
CF_EXPORT NSString * const AZApiUriPhotoSearchTextList;
CF_EXPORT NSString * const AZApiUriPhotoShareAdd;


#pragma mark - Msg

CF_EXPORT NSString * const AZApiUriMsgContactRecentList;
CF_EXPORT NSString * const AZApiUriMsgRcmdDuckrList;
CF_EXPORT NSString * const AZApiUriMsgRcmdSearchList;
CF_EXPORT NSString * const AZApiUriMsgRcmdContactList; //通讯录列表，可搜索
CF_EXPORT NSString * const AZApiUriMsgRcmdNearbyList;
CF_EXPORT NSString * const AZApiUriMsgNotifyList;
CF_EXPORT NSString * const AZApiUriMsgNotifyPhotoList;
CF_EXPORT NSString * const AZApiUriMsgFocusList;
CF_EXPORT NSString * const AZApiUriMsgPhoneFileAdd;
CF_EXPORT NSString * const AZApiUriMsgInviteSend;

#pragma mark - Order
CF_EXPORT NSString * const AZApiUriUserSalesOrderAdd;
CF_EXPORT NSString * const AZApiUriUserSalesOrderDetail;
CF_EXPORT NSString * const AZApiUriUserSalesOrderRefund;
CF_EXPORT NSString * const AZApiUriUserSalesOrderDel;
CF_EXPORT NSString * const AZApiUriUserSalesOrderAddComment;
CF_EXPORT NSString * const AZApiUriUserOrderAllList;
CF_EXPORT NSString * const AZApiUriUserOrderUnusedList;
CF_EXPORT NSString * const AZApiUriUserOrderUnevalList;
CF_EXPORT NSString * const AZApiUriUserOrderRefundList;
CF_EXPORT NSString * const AZApiUriUserOrderElecList;
CF_EXPORT NSString * const AZApiUriPayAliNotify;


#pragma mark - User
CF_EXPORT NSString * const AZApiUriRegister;
CF_EXPORT NSString * const AZApiUriLogin;
CF_EXPORT NSString * const AZApiUriSendAuthcode;
CF_EXPORT NSString * const AZApiUriCheckAuthcode;
CF_EXPORT NSString * const AZApiUriRestPassword;
CF_EXPORT NSString * const AZApiUriUserInfoUpdate;
CF_EXPORT NSString * const AZApiUriUserInfo;
CF_EXPORT NSString * const AZApiUriPlaceProvinceCityList;
CF_EXPORT NSString * const AZApiUriLocateCity;
CF_EXPORT NSString * const AZApiUriUserFocusAdd;
CF_EXPORT NSString * const AZApiUriUserFocusDel;
CF_EXPORT NSString * const AZApiUriUserFocusList;
CF_EXPORT NSString * const AZApiUriUserFocusMerchList;
CF_EXPORT NSString * const AZApiUriUserFocusRemark;
CF_EXPORT NSString * const AZApiUriUserFansList;
CF_EXPORT NSString * const AZApiUriUserPhotoList;
CF_EXPORT NSString * const AZApiUriUserJoinActivList;
CF_EXPORT NSString * const AZApiUriUserInterestActivList;
CF_EXPORT NSString * const AZCpiUriUesrActivRelateList;
CF_EXPORT NSString * const AZApiUriUserInviteJoinList;
CF_EXPORT NSString * const AZApiUriUserInviteInterestList;
CF_EXPORT NSString * const AZApiUriUserInvitePublishList;
CF_EXPORT NSString * const AZApiUriUserInviteReseivedList;
CF_EXPORT NSString * const AZApiUriUserRecentVisitList;
CF_EXPORT NSString * const AZApiUriUserRecentVisitAdd;

CF_EXPORT NSString * const AZApiUriUserLogout;
CF_EXPORT NSString * const AZApiUriUserActivInterestList;
CF_EXPORT NSString * const AZApiUriUserAddressAdd;
CF_EXPORT NSString * const AZApiUriUserAddressDel;
CF_EXPORT NSString * const AZApiUriUserAddressList;
CF_EXPORT NSString * const AZApiUriUserAddressSetDefault;
CF_EXPORT NSString * const AZApiUriUserNotifyUpdate;
CF_EXPORT NSString * const AZApiUriUserCoinsList;
CF_EXPORT NSString * const AZApiUriUserReport;
CF_EXPORT NSString * const AZApiUriUserQuietAdd;
CF_EXPORT NSString * const AZApiUriUserQuietCancel;
CF_EXPORT NSString * const AZApiUriUserQuietStatus;

#endif /* AZApiConstant_h */
