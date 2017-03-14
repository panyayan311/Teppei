//
//  Session.h
//  Teppei
//
//  Created by levanha711 on 2017/03/13.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;

- (instancetype)initWithUserName:(NSString *)userName
                     andPassword:(NSString *)password;
- (instancetype)initWithUserId:(NSString *)userId
                  UserName:(NSString *)userName
                     andPassword:(NSString *)password;

@end
