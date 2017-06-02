//
//  AZHomeVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZOrderWrapper.h"

@class AZPayHelper;

@protocol AZPayHelperDelegate <NSObject>
@optional
- (void)paymentHelper:(AZPayHelper *)paymentHelper didPaySucceed:(BOOL)issucceed order:(AZOrderWrapper *)orderWrapper error:(NSError *)error;

@end

@interface AZPayHelper : NSObject

- (instancetype)initWithDelegate:(id<AZPayHelperDelegate>)delegate;
- (void)callWxPay:(NSString *)quid
             auid:(NSString *)auid
           amount:(CGFloat)amount
      paymentType:(AZOrderPaymentType)paymentType
        tradeType:(AZOrderTradeType)tradeType;

- (void)clientDidPaySucceed;

@property (strong, nonatomic) AZOrderWrapper *orderWrapper;

@property (weak, nonatomic) id<AZPayHelperDelegate> delegate;

@end
