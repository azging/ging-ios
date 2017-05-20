//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZHttpApi.h"
#import "AZUtil.h"
#import "AZConstant.h"
#import "AZDataManager.h"
#import "NSString+Additions.h"

// 接口返回的正确状态值
static const NSInteger AZHttpStatusSuccess = 0;
// 接口默认返回的错误状态值
static const NSInteger AZHttpStatusFail = -1;
// 访问后台标记设备类型
static const NSString *AZHttpDeviceType = @"1";
// 访问后台的代理设置
NSString * const AZHttpUserAgentKey = @"User-Agent";

@interface AZHttpApi()

// 接口访问的Session管理器
@property (strong, nonatomic) AFHTTPSessionManager *manager;
// 接口访问返回的状态值
@property (assign, nonatomic) NSInteger status;
// 接口访问返回的数据字典
@property (strong, nonatomic) NSDictionary *dataDic;
// 接口访问返回的提示语句
@property (strong, nonatomic) NSString *msg;

@end

@implementation AZHttpApi


#pragma mark - Life Cycle

- (id)init {
    self = [super init];
    if (self) {
        self.status = AZHttpStatusFail;
    }
    return self;
}

//+ (AFHTTPSessionManager *)sharedHttpSessionManager {
//    static AFHTTPSessionManager *instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [AFHTTPSessionManager manager];
//        instance.requestSerializer.timeoutInterval = 10.0;
//    });
//    
//    return instance;
//}

#pragma mark - Public Func

// 用GET方法请求后台
- (void)doGet:(NSString *)uriStr params:(NSArray *)params requestCallBack:(requestCallBack)callBack {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [AZDataManager sharedInstance].netWorkingStatus = status;
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    NSString *url = [AZStringUtil getServerFullUrl:AZServerApiPrefix suffix:uriStr];
    url = [self addGetQueryString:url withArray:params];
    AFHTTPSessionManager *manager = [AZHttpApi managerWithBaseURL:nil sessionConfiguration:NO];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject];
        NSError *error = nil;
        if (AZHttpStatusSuccess != self.status) {
            error = [NSError errorWithDomain:self.msg code:self.status userInfo:nil];
        }
        if (callBack) {
            callBack(self.status, self.dataDic, self.msg, [self replaceEnglishErrorMsg:error]);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:uriStr object:nil];
        [manager.session finishTasksAndInvalidate];
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([[error.userInfo allKeys] containsObject:NSLocalizedDescriptionKey]) {
            error = [NSError errorWithDomain:[error.userInfo objectForKey:NSLocalizedDescriptionKey] code:error.code userInfo:error.userInfo];
        }
        if (callBack) {
            callBack(self.status, nil, nil, [self replaceEnglishErrorMsg:error]);
        }
        [manager.session finishTasksAndInvalidate];
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }];
}

// 用POST方法请求后台
- (void)doPost:(NSString *)uriStr params:(NSDictionary *)params requestCallBack:(requestCallBack)callBack {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [AZDataManager sharedInstance].netWorkingStatus = status;
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    NSString *url = [AZStringUtil getServerFullUrl:AZServerApiPrefix suffix:uriStr];
    AFHTTPSessionManager *manager = [AZHttpApi managerWithBaseURL:nil sessionConfiguration:NO];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponseObject:responseObject];
        NSError *error = nil;
        if (AZHttpStatusSuccess != self.status) {
            error = [NSError errorWithDomain:self.msg code:self.status userInfo:nil];
        }
        if (callBack) {
            callBack(self.status, self.dataDic, self.msg, [self replaceEnglishErrorMsg:error]);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:uriStr object:nil];
        [manager.session finishTasksAndInvalidate];
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([[error.userInfo allKeys] containsObject:NSLocalizedDescriptionKey]) {
            error = [NSError errorWithDomain:[error.userInfo objectForKey:NSLocalizedDescriptionKey] code:error.code userInfo:error.userInfo];
        }
        if (callBack) {
            callBack(self.status, nil, nil, [self replaceEnglishErrorMsg:error]);
        }
        [manager.session finishTasksAndInvalidate];
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }];
}


#pragma mark - Private Func

+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseUrl sessionConfiguration:(BOOL)isconfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = nil;
    
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    if (isconfiguration) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    } else {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    [securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy = securityPolicy;
    
    //DeviceType: "0"     // 设备类型，0表示未知，1表示iOS，2表示Android，3代表浏览器
    //AppVer: "3.0"     // 前台应用版本
    //CID: "4e551767655d62c57263987b64a7087a"    // 私密的用户身份标示
    //UUID: "23aee904e21f74b36aef669d46a07613"     // 公开的用户身份标示
    //DeviceUUID: "fjawoetufqwoeapr"    // 机器的唯一标示
    //IDFA: "6E71A09D-A9F7-4408-A8DD-DD5EACBEC982"    // 广告标示
    //CityId: "110000"    // 常在地城市ID
    //LocLng:
    //LocLat:
    
    NSString *cookieStr = [NSString stringWithFormat:@"DeviceType=%@;AppVer=%@", AZHttpDeviceType, [AZAppUtil getAppLocalShortVersion]];
    
    NSString *deviceUuid = [AZStringUtil getNotNullStr:[AZDataManager sharedInstance].deviceUuid];
    NSString *cidStr = @"";
    NSString *uuidStr = @"";
    
    if ([AZDataManager sharedInstance].userModel) {
        cidStr = [AZStringUtil getNotNullStr:[AZDataManager sharedInstance].userModel.cid];
        uuidStr = [AZStringUtil getNotNullStr:[AZDataManager sharedInstance].userModel.uuid];
    }
    //    cookieStr = [cookieStr stringByAppendingFormat:@";CID=%@", @"6c3d90c8f1bc3f22e4e1688adf6935d7"];
    //    cookieStr = [cookieStr stringByAppendingFormat:@";UUID=%@", @"e5544bc88777d001802c8a8344822ec8"];
    cookieStr = [cookieStr stringByAppendingFormat:@";CID=%@", cidStr];
    cookieStr = [cookieStr stringByAppendingFormat:@";UUID=%@", uuidStr];
    cookieStr = [cookieStr stringByAppendingFormat:@";DeviceUUID=%@",deviceUuid];
    
    NSString *tokenStr = [[AZDateUtil getUnixTimeStamp] md5];
    // TODO:上线需要修改成duckr_win
    NSString *vUIDStr = [[NSString stringWithFormat:@"duckr_win%@%@", tokenStr, cidStr] md5];
    //    NSString *vUIDStr = [[NSString stringWithFormat:@"test%@%@", tokenStr, cidStr] md5];
    cookieStr = [cookieStr stringByAppendingFormat:@";Token=%@;VUID=%@", tokenStr, vUIDStr];
    
    NSString *idfaStr = [AZStringUtil getNotNullStr:[AZAppUtil getIdfa]];
    cookieStr = [cookieStr stringByAppendingFormat:@";IDFA=%@", idfaStr];
    
//    NSString *cityId = @"";
//    if (nil != [AZDataManager sharedInstance].currentCityModel) {
//        cityId = [AZStringUtil integerToStr:[AZDataManager sharedInstance].currentCityModel.cityId];
//    }
//    cookieStr = [cookieStr stringByAppendingFormat:@";CityId=%@", cityId];
    CLLocation *location = [AZDataManager sharedInstance].userLocation;
    CGFloat lng = 0.0f;
    CGFloat lat = 0.0f;
    if (nil != location) {
        lng = location.coordinate.longitude;
        lat = location.coordinate.latitude;
    }
    cookieStr = [cookieStr stringByAppendingString:[NSString stringWithFormat:@";LocLng=%f", lng]];
    cookieStr = [cookieStr stringByAppendingString:[NSString stringWithFormat:@";LocLat=%f", lat]];
    [requestSerializer setValue:cookieStr forHTTPHeaderField:@"cookie"];
    
    NSString *userAgentStr = [requestSerializer valueForHTTPHeaderField:AZHttpUserAgentKey];
    NSString *channel = [AZAppUtil getAppChannel];
    NSString *deviceName = [AZAppUtil getDevicePlatform];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersionStr = [infoDictionary objectForKey:@"CFBundleVersion"];
    UIViewController *controller = [AZAppUtil getTopMostViewController];
    NSString *controllerName = NSStringFromClass([controller class]);
    controllerName = [AZStringUtil getNotNullStr:controllerName];
    userAgentStr = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;%@;%@", userAgentStr, channel, deviceName, appVersionStr, deviceUuid, controllerName, [NSString stringWithFormat:@"%f", lng], [NSString stringWithFormat:@"%f", lat]];
    [requestSerializer setValue:userAgentStr forHTTPHeaderField:AZHttpUserAgentKey];
    
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager.reachabilityManager startMonitoring];
    
    return manager;
}

- (void)parseResponseObject:(id)responseObject {
    //    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *jsonDic = (NSDictionary *)responseObject;
    self.status = [AZStringUtil idToNSInteger:[jsonDic objectForKey:@"Status"]];
    self.msg = [AZStringUtil getNotNullStr:[jsonDic objectForKey:@"Msg"]];
    id obj = [jsonDic objectForKey:@"Data"];
    if ([obj isKindOfClass:[NSArray class]]) {
        self.dataDic = [[NSDictionary alloc] init];
    } else if ([obj isKindOfClass:[NSDictionary class]]) {
        self.dataDic = (NSDictionary *)obj;
    }
}

- (NSError *)replaceEnglishErrorMsg:(NSError *)err {
    NSError *ret = err;
    if (err && [AZStringUtil isNotNullString:err.domain] && [err.domain hasPrefix:@"Request failed"]) {
        ret = [NSError errorWithDomain:@"网络错误" code:err.code userInfo:err.userInfo];
    }
    return ret;
}

- (NSString*)addGetQueryString:(NSString *)urlString withArray:(NSArray *)arr {
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    NSInteger index = 0;
    for (NSString *valueStr in arr) {
        if (0 == index) {
            [urlWithQuerystring appendFormat:@"%@", [self urlEncode:valueStr]];
        } else {
            [urlWithQuerystring appendFormat:@"/%@", [self urlEncode:valueStr]];
        }
        index++;
    }
    return urlWithQuerystring;
}

- (NSString*)urlEncode:(id)object {
    NSString *string = [NSString stringWithFormat: @"%@", object];
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@end
