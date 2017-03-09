//
//  Question.m
//  Teppei
//
//  Created by levanha711 on 2017/01/26.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "Question.h"

@implementation Question

- (instancetype)initQuestionWithQuestion:(NSString *)question
                                  andStt:(NSInteger)sttQuestion {
    self = [super init];
    if (self) {
        _question = question;
        _sttQuestion = sttQuestion;
    }
    return self;
}

- (instancetype)initQuestionWithDictionary:(NSDictionary *)questionDic {
    self = [super init];
    if (self) {
        @try {
            _questionID = [questionDic objectForKey:@"objectId"];
            _categoryID = [questionDic objectForKey:@"categoryID"];
            _question = [questionDic objectForKey:@"question"];
            
        } @catch (NSException *exception) {
            //none
        } @finally {
            //none
        }
        
    }
    return self;
}

@end
