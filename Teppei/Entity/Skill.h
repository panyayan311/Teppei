//
//  Skill.h
//  Teppei
//
//  Created by levanha711 on 2017/03/14.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Skill : NSObject

@property (strong, nonatomic) NSString *idSkill;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *tutorial;

- (instancetype)initWithSkillDictionary:(NSDictionary *)skillDic;

@end
