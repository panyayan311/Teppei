//
//  AnswerQuestion.h
//  Teppei
//
//  Created by levanha711 on 2017/03/16.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerQuestion : NSObject

@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *questionId;
@property (strong, nonatomic) NSString *question;
@property (nonatomic) NSInteger answer;
@property (strong, nonatomic) NSString *sheetId;

- (instancetype)initAnswerQuestionForDictionary:(NSDictionary *)answerQuestionDic;

@end
