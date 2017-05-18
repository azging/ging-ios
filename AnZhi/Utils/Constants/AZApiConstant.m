//
//  AZApiConstant.m
//  LinkCity
//
//  Created by 张宗硕 on 8/26/16.
//  Copyright © 2016 张宗硕. All rights reserved.
//

#import "AZApiConstant.h"


#pragma mark - Activ

NSString * const AZApiUriActivDetail        = @"v6/activ/detail/";
NSString * const AZApiUriActivInterestAdd   = @"v6/activ/interest/add/";
NSString * const AZApiUriActivInterestDel   = @"v6/activ/interest/del/";
NSString * const AZApiUriActivCommentList   = @"v6/activ/comment/list/";
NSString * const AZApiUriActivInterestList  = @"v6/activ/interest/list/";
NSString * const AZApiUriActivInviteList    = @"v6/activ/invite/list/";
NSString * const AZApiUriActivPhotoList     = @"v6/activ/photo/list/";
NSString * const AZApiUriActivCommentAdd    = @"v6/activ/comment/add/";
NSString * const AZApiUriActivJoinList      = @"v6/activ/join/list/";
NSString * const AZApiUriActivQuit          = @"v6/activ/quit/";
NSString * const AZApiUriActivChatNotify    = @"v6/activ/chat/notify/";
NSString * const AZApiUriActivChatStatus    = @"v6/activ/chat/status/";
NSString * const AZApiUriActivShareAdd      = @"v6/activ/share/add/";


#pragma mark - App
NSString * const AZApiUriAppConfigInit          = @"v6/app/config/init/";
NSString * const AZApiUriAppConfigSet           = @"v6/app/config/set/";
NSString * const AZApiUriPlaceBusinessArea      = @"v6/place/business/area/";
NSString * const AZApiUriAppSearchThemeActiv    = @"v6/app/search/theme/activ/";
NSString * const AZApiUriAppRedDot              = @"v6/app/reddot/";
NSString * const AZApiUriAppBannerActivList     = @"v6/app/banner/activ/list/";
NSString * const AZApiUriAppSystemUserInfo      = @"v6/app/system/user/info/";
NSString * const AZApiUriAppDuckrEval           = @"v6/app/duckr/eval/";


#pragma mark - Common

NSString * const AZApiUriGetQINIUUploadToken    = @"v6/photo/qiniu/uptoken/";
NSString * const AZApiUriQINIUDomain            = @"http://download.duckr.cn/";
NSString * const AZApiUriGetSchoolList          = @"v6/app/search/school/";


#pragma mark - Home
NSString * const AZApiUriHomeRcmdList               = @"v6/home/rcmd/list/";
NSString * const AZApiUriHomeInviteList             = @"v6/home/invite/list/";
NSString * const AZApiUriHomeSearchCalendar         = @"v6/home/search/calendar/";
NSString * const AZApiUriHomeSearchText             = @"v6/home/search/text/";
NSString * const AZApiUriHomeSearchActiv            = @"v6/home/search/text/activ/";
NSString * const AZApiUriHomeRcmdActivMore          = @"v6/home/rcmd/activ/more/";
NSString * const AZApiUriHomeSearchTextActiv        = @"v6/home/search/text/activ/";
NSString * const AZApiUriHomeSearchTextInvite       = @"v6/home/search/text/invite/";


#pragma mark - Calendar

NSString * const AZApiUriCalendarEventPublish       = @"v6/calendar/event/publish/";
NSString * const AZApiUriCalendarEventDetail        = @"v6/calendar/event/detail/";
NSString * const AZApiUriCalendarEventDel           = @"v6/calendar/event/del/";
NSString * const AZApiUriCalendarDayDetail          = @"v6/calendar/day/detail/";
NSString * const AZApiUriCalendarDayList            = @"v6/calendar/day/list/";
NSString * const AZApiUriCalendarDayFocusList       = @"v6/calendar/day/focus/list/";
NSString * const AZApiUriCalendarSearchList         = @"v6/calendar/search/list/";
NSString * const AZApiUriCalendarFreeTimeList       = @"v6/calendar/free/time/list/";
NSString * const AZApiUriCalendarFreeTimeMark       = @"v6/calendar/free/time/mark/";
NSString * const AZApiUriCalendarFileAdd            = @"v6/calendar/file/add/";
NSString * const AZApiUriCalendarScheduleList       = @"v6/calendar/schedule/list/";
NSString * const AZApiUriCalendarFocusList          = @"v6/calendar/focus/list/";
NSString * const AZApiUriCalendarRcmdList           = @"v6/calendar/rcmd/list/";


#pragma mark - Match

NSString * const AZApiUriMatchActivList             = @"v6/activ/match/list/";
NSString * const AZApiUriMatchActivAdd              = @"v6/activ/match/add/";
NSString * const AZApiUriMatchActivBack             = @"v6/activ/match/back/";
NSString * const AZApiUriMatchMsgActiv              = @"v6/msg/activ/match/";


#pragma mark - Local

NSString * const AZApiUriLocalActivBusiness     = @"v6/local/activ/business/";
NSString * const AZApiUriLocalActivList         = @"v61/local/activ/list/";
NSString * const AZApiUriLocalActivTheme        = @"v6/local/activ/theme/";
NSString * const AZApiUriLocalInviteList        = @"v6/local/invite/list/";
NSString * const AZApiUriLocalLeisureJoin       = @"v6/local/leisure/join/";
NSString * const AZApiUriLocalLeisureList       = @"v6/local/leisure/list/";
NSString * const AZApiUriLocalSearchCalendar    = @"v6/local/search/calendar/";
NSString * const AZApiUriLocalLeisureScrollList = @"v6/local/leisure/scroll/list/";
NSString * const AZApiUriLocalFocusList         = @"v6/local/focus/list/";
NSString * const AZApiUriLocalFocusThemeList    = @"v6/local/focus/theme/list/";
NSString * const AZApiUriLocalFocusRcmdList     = @"v6/local/focus/rcmd/list/";


#pragma mark - Invite

NSString * const AZApiUriInvitePublish       = @"v6/invite/publish/";
NSString * const AZApiUriInviteDetail        = @"v6/invite/detail/";
NSString * const AZApiUriInviteCommentList   = @"v6/invite/comment/list/";
NSString * const AZApiUriInviteCommentAdd    = @"v6/invite/comment/add/";
NSString * const AZApiUriInviteInterestList  = @"v6/invite/interest/list/";
NSString * const AZApiUriInviteInterestAdd   = @"v6/invite/interest/add/";
NSString * const AZApiUriInviteInterestDel   = @"v6/invite/interest/del/";
NSString * const AZApiUriInviteJoinList      = @"v6/invite/join/list/";
NSString * const AZApiUriInviteJoin          = @"v6/invite/join/";
NSString * const AZApiUriInviteQuit          = @"v6/invite/quit/";
NSString * const AZApiUriInviteChatNotify    = @"v6/invite/chat/notify/";
NSString * const AZApiUriInviteChatStatus    = @"v6/invite/chat/status/";
NSString * const AZApiUriInviteShareAdd      = @"v6/invite/share/add/";

#pragma mark - Photo

NSString * const AZApiUriPhotoPublish        = @"v6/photo/publish/";
NSString * const AZApiUriPhotoDetail         = @"v6/photo/detail/";
NSString * const AZApiUriPhotoDel            = @"v6/photo/del/";
NSString * const AZApiUriPhotoListHot        = @"v6/photo/list/hot/";
NSString * const AZApiUriPhotoListFlow       = @"v6/photo/list/flow/";
NSString * const AZApiUriPhotoListLocal      = @"v6/photo/list/local/";
NSString * const AZApiUriPhotoLikeDel        = @"v6/photo/like/del/";
NSString * const AZApiUriPhotoLikeAdd        = @"v6/photo/like/add/";
NSString * const AZApiUriPhotoLikeList       = @"v6/photo/like/list/";
NSString * const AZApiUriPhotoCommentList    = @"v6/photo/comment/list/";
NSString * const AZApiUriPhotoCommentAdd     = @"v6/photo/comment/add/";
NSString * const AZApiUriPhotoSearchTextList = @"v6/photo/search/text/";
NSString * const AZApiUriPhotoShareAdd       = @"v6/photo/share/add/";


#pragma mark - Msg

NSString * const AZApiUriMsgContactRecentList       = @"v6/msg/contact/recent/list/";
NSString * const AZApiUriMsgRcmdDuckrList           = @"v6/msg/rcmd/duckr/list/";
NSString * const AZApiUriMsgRcmdSearchList          = @"v6/msg/rcmd/search/list/";
NSString * const AZApiUriMsgRcmdContactList         = @"v6/msg/rcmd/contact/list/";
NSString * const AZApiUriMsgRcmdNearbyList          = @"v6/msg/rcmd/nearby/list/";
NSString * const AZApiUriMsgNotifyList              = @"v6/msg/notify/list/";
NSString * const AZApiUriMsgNotifyPhotoList         = @"v6/msg/notify/photo/list/";
NSString * const AZApiUriMsgFocusList               = @"v6/msg/focus/list/";
NSString * const AZApiUriMsgPhoneFileAdd            = @"v6/msg/phone/file/add/";
NSString * const AZApiUriMsgInviteSend              = @"v6/msg/invite/send/";


#pragma mark - Order
NSString * const AZApiUriUserSalesOrderAdd              = @"v6/sales/order/add/";
NSString * const AZApiUriUserSalesOrderDetail           = @"v6/sales/order/detail/";
NSString * const AZApiUriUserSalesOrderRefund           = @"v6/sales/order/refund/";
NSString * const AZApiUriUserSalesOrderDel              = @"v6/sales/order/del/";
NSString * const AZApiUriUserSalesOrderAddComment       = @"v6/sales/comment/add/";
NSString * const AZApiUriUserOrderAllList               = @"v6/user/order/all/list/";
NSString * const AZApiUriUserOrderUnusedList            = @"v6/user/order/unused/list/";
NSString * const AZApiUriUserOrderUnevalList            = @"v6/user/order/uneval/list/";
NSString * const AZApiUriUserOrderRefundList            = @"v6/user/order/refund/list/";
NSString * const AZApiUriUserOrderElecList              = @"v6/user/order/elec/list/";
NSString * const AZApiUriPayAliNotify                   = @"v6/pay/ali/notify/";

#pragma mark - User

NSString * const AZApiUriRegister               = @"v6/user/register/";
NSString * const AZApiUriLogin                  = @"v6/user/login/";
NSString * const AZApiUriSendAuthcode           = @"v6/msg/phone/authcode/send/";
NSString * const AZApiUriCheckAuthcode          = @"v6/msg/phone/authcode/check/";
NSString * const AZApiUriRestPassword           = @"v6/user/pwd/update/";
NSString * const AZApiUriUserInfoUpdate         = @"v6/user/info/update/";
NSString * const AZApiUriUserInfo               = @"v6/user/info/";
NSString * const AZApiUriPlaceProvinceCityList  = @"v6/place/province/city/list/";
NSString * const AZApiUriLocateCity             = @"v6/place/locate/city/";
NSString * const AZApiUriUserFocusAdd           = @"v6/user/focus/add/";
NSString * const AZApiUriUserFocusDel           = @"v6/user/focus/del/";
NSString * const AZApiUriUserFocusList          = @"v6/user/focus/list/";
NSString * const AZApiUriUserFocusMerchList     = @"v6/user/focus/merch/list/";
NSString * const AZApiUriUserFocusRemark        = @"v6/user/focus/remark/";
NSString * const AZApiUriUserFansList           = @"v6/user/fans/list/";
NSString * const AZApiUriUserPhotoList          = @"v6/user/photo/list/";
NSString * const AZApiUriUserJoinActivList      = @"v6/user/activ/join/list/";
NSString * const AZApiUriUserInterestActivList  = @"v6/user/activ/interest/list/";
NSString * const AZCpiUriUesrActivRelateList    = @"v6/user/activ/relate/list/";
NSString * const AZApiUriUserInviteJoinList     = @"v6/user/invite/join/list/";
NSString * const AZApiUriUserInviteInterestList = @"v6/user/invite/interest/list/";
NSString * const AZApiUriUserInvitePublishList  = @"v6/user/invite/publish/list/";
NSString * const AZApiUriUserInviteReseivedList = @"v6/user/invite/reseived/list/";
NSString * const AZApiUriUserRecentVisitList    = @"v6/user/recent/visit/list/";
NSString * const AZApiUriUserRecentVisitAdd     = @"v6/user/recent/visit/add/";

NSString * const AZApiUriUserLogout             = @"v6/user/logout";
NSString * const AZApiUriUserActivInterestList  = @"v6/user/activ/interest/list/";
NSString * const AZApiUriUserAddressAdd         = @"v6/user/address/add/";
NSString * const AZApiUriUserAddressDel         = @"v6/user/address/del/";
NSString * const AZApiUriUserAddressList        = @"v6/user/address/list/";
NSString * const AZApiUriUserAddressSetDefault  = @"v6/user/address/default/";
NSString * const AZApiUriUserNotifyUpdate       = @"v6/user/notify/update/";
NSString * const AZApiUriUserCoinsList          = @"v6/user/coins/list/";
NSString * const AZApiUriUserReport             = @"v6/user/report/";
NSString * const AZApiUriUserQuietAdd           = @"v6/user/quiet/add/";
NSString * const AZApiUriUserQuietCancel        = @"v6/user/quiet/cancel/";
NSString * const AZApiUriUserQuietStatus        = @"v6/user/quiet/status/";

