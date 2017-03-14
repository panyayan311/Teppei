//
//  Session.m
//  Teppei
//
//  Created by levanha711 on 2017/03/13.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "Session.h"

@implementation Session

- (instancetype)initWithUserName:(NSString *)userName
                     andPassword:(NSString *)password {
    self = [super init];
    if (self) {
        @try {
            _userName = userName;
            _password = password;
        } @catch (NSException *exception) {
            //none
        } @finally {
            //none
        }
    }
    return self;
}

- (instancetype)initWithUserId:(NSString *)userId
                      UserName:(NSString *)userName
                     andPassword:(NSString *)password {
    self = [super init];
    if (self) {
        @try {
            _userId = userId;
            _userName = userName;
            _password = password;
        } @catch (NSException *exception) {
            //none
        } @finally {
            //none
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"UserID"];
    [aCoder encodeObject:self.userName forKey:@"UserName"];
    [aCoder encodeBool:self.password forKey:@"Password"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        @try {
            if (![aDecoder isKindOfClass:[NSNull class]]) {
                _userId = [aDecoder decodeObjectForKey:@"UserID"];
                _userName = [aDecoder decodeObjectForKey:@"UserName"];
                _password = [aDecoder decodeObjectForKey:@"Password"];
            }
        } @catch (NSException *exception) {
            //code
        } @finally {
            //code
        }
        
    }
    return self;
}

@end
