//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUMengHelper.h"
#import "AZAppUtil.h"
#import "UMMobClick/MobClick.h"
//#import "UMSocial.h"
//#import "UMSocialWechatHandler.h"
//#import "UMSocialSinaSSOHandler.h"
//#import "UMSocialQQHandler.h"
#import "WXApi.h"

static NSString * const AZUMengAppKey = @"591bb126c62dca1799000801"; // azgign


static NSString * const AZWechatSecret = @"90a8a9d411282c10d502766360093f8f";  // azging

@implementation AZUMengHelper


#pragma mark - Life Cycle

// 获取友盟单例
+ (instancetype)sharedInstance {
    static AZUMengHelper *umengHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        umengHelper = [[AZUMengHelper alloc] init];
    });
    return umengHelper;
}


#pragma mark - Public Func

// 启动友盟统计
- (void)startStatistic {
    [self startUMengStatistic];
    [self startUMengTrackStatistic];

#if DEBUG
    [MobClick setCrashReportEnabled:NO];
#else
    [MobClick setCrashReportEnabled:YES];
#endif
}

// 初始化友盟社交分享
- (void)initUMengSocialSDK {
    [[UMSocialManager defaultManager] setUmSocialAppkey:AZUMengAppKey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:AZWechatKey appSecret:AZWechatSecret redirectURL:@"http://mobile.umeng.com/social"];
        [WXApi registerApp:AZWechatKey];
}


#pragma mark - Private Func

- (void)startUMengStatistic {
    UMConfigInstance.appKey = AZUMengAppKey;
    [MobClick setAppVersion:[AZAppUtil getAppLocalShortVersion]];
    [MobClick startWithConfigure:UMConfigInstance];
}

- (void)startUMengTrackStatistic {
    NSString * appKey = AZUMengAppKey;
    NSString * deviceName = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * mac = [self macString];
    NSString * idfa = [self idfaString];
    NSString * idfv = [self idfvString];
    NSString * urlString = [NSString stringWithFormat:@"http://log.umtrack.com/ping/%@/?devicename=%@&mac=%@&idfa=%@&idfv=%@", appKey, deviceName, mac, idfa, idfv];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:urlString]] delegate:nil];
}

- (NSString * )macString {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
//        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
//        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

- (NSString *)idfaString {
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (nil == adSupportBundle) {
        return @"";
    } else {
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if (nil == asIdentifierMClass) {
            return @"";
        } else {
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            if (nil == asIM) {
                return @"";
            } else {
                if (asIM.advertisingTrackingEnabled) {
                    return [asIM.advertisingIdentifier UUIDString];
                } else {
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

- (NSString *)idfvString {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return @"";
}

@end
