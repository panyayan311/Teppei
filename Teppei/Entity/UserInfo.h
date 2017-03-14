//
//  UserInfo.h
//  Teppei
//
//  Created by levanha711 on 2017/03/07.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *email;

// other Info
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *position;

- (instancetype)initWithDictionary:(NSDictionary *)userInfoDic;

@end
