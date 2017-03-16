//
//  AnswerQuestion.m
//  Teppei
//
//  Created by levanha711 on 2017/03/16.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "AnswerQuestion.h"

@implementation AnswerQuestion

- (instancetype)initAnswerQuestionForDictionary:(NSDictionary *)answerQuestionDic {
    self = [super init];
    if (self) {
        @try {
            _objectId = [answerQuestionDic objectForKey:@"objectId"];
            _questionId = [answerQuestionDic objectForKey:@"questionId"];
            _answer = [[answerQuestionDic objectForKey:@"answer"] integerValue];
            _sheetId = [answerQuestionDic objectForKey:@"sheetId"];
            
//            _question = [answerQuestionDic objectForKey:@"question"];
//            _categoryId = [answerQuestionDic objectForKey:@"categoryID"];
            

        } @catch (NSException *exception) {
            //none
        } @finally {
            //none
        }
    }
    return self;
}
@end
