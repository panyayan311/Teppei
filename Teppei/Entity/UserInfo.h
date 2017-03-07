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

- (instancetype)initWithDictionary:(NSDictionary *)userInfoDic;

@end
