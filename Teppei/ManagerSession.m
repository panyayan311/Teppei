//
//  ManagerSession.m
//  Teppei
//
//  Created by levanha711 on 2017/03/13.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "ManagerSession.h"

@implementation ManagerSession

+ (instancetype)shareInstance {
    static ManagerSession *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ManagerSession alloc] init];
    });
    return _sharedInstance;
}

#define kSessionKey @"CurrentSession"

- (void)saveSession:(Session *)session {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:session];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kSessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeSession:(Session *)session {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kSessionKey];
}
- (Session *)currentSession {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionKey];
    return (Session *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
