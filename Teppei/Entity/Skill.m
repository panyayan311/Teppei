//
//  Skill.m
//  Teppei
//
//  Created by levanha711 on 2017/03/14.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "Skill.h"

@implementation Skill

- (instancetype)initWithSkillDictionary:(NSDictionary *)skillDic {
    self = [super init];
    if (self) {
        @try {
            _idSkill = [skillDic objectForKey:@"objectId"];
            _name = [skillDic objectForKey:@"name"];
            _content = [skillDic objectForKey:@"content"];
            _tutorial = [skillDic objectForKey:@"tutorial"];
        } @catch (NSException *exception) {
            //none
        } @finally {
            //none
        }
    }
    return self;
}
@end
