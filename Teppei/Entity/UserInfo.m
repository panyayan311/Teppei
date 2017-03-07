//
//  UserInfo.m
//  Teppei
//
//  Created by levanha711 on 2017/03/07.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithDictionary:(NSDictionary *)userInfoDic {
    self = [super init];
    if (self) {
        @try {
            if (![userInfoDic isKindOfClass:[NSNull class]]) {
                _userId = [userInfoDic objectForKey:@"objectId"];
                _userName = [userInfoDic objectForKey:@"userName"];
            }
            _email = [userInfoDic objectForKey:@"email"];
        } @catch (NSException *exception) {
            //none
        } @finally {
            //none
        }
    }
    return self;
}

@end
