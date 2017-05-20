//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZOrderWrapper.h"
#import "AZOrderTicketWrapper.h"

@class AZPayHelper;

@protocol AZPayHelperDelegate <NSObject>
@optional
- (void)paymentHelper:(AZPayHelper *)paymentHelper didPaySucceed:(BOOL)issucceed order:(AZOrderModel *)model error:(NSError *)error;

@end

@interface AZPayHelper : NSObject

- (instancetype)initWithDelegate:(id<AZPayHelperDelegate>)delegate;
//- (void)callWxPay:(AZOrderTicketWrapper *)orderTicketWrapper;
- (void)callFreePay:(AZOrderTicketWrapper *)orderTicketWrapper;
- (void)callWxPay:(AZOrderTicketWrapper *)orderTicketWrapper addrUid:(NSString *)addrUid contact:(NSArray *)contactArr;
- (void)callAliPay:(AZOrderTicketWrapper *)orderTicketWrapper addrUid:(NSString *)addrUid contact:(NSArray *)contactArr;

- (void)clientDidPaySucceed;

@property (strong, nonatomic) AZOrderWrapper *orderWrapper;

@property (weak, nonatomic) id<AZPayHelperDelegate> delegate;

@end
