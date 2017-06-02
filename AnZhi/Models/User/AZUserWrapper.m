//
//  AZUserWrapper.m
//  AnZhi
//
//  Created by LHJ on 2017/5/22.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZUserWrapper.h"

@implementation AZUserWrapper

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userModel":@"User",
             };
}



//+ (NSDictionary *)modeAZontainerPropertyGenericClass {
//    return @{@"orderTicketArr":[AZOrderTicketWrapper class],
//             };
//}

@end
