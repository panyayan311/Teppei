//
//  ManagerSession.h
//  Teppei
//
//  Created by levanha711 on 2017/03/13.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

@interface ManagerSession : NSObject

+ (instancetype)shareInstance;
- (void)saveSession:(Session *)session;
- (void)removeSession:(Session *)session;
- (Session *)currentSession;

@end
