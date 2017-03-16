//
//  Question.h
//  Teppei
//
//  Created by levanha711 on 2017/01/26.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (strong, nonatomic) NSString *questionID;
@property (strong, nonatomic) NSString *question;
@property (nonatomic) NSInteger sttQuestion;
@property (nonatomic) NSInteger answerQuestion; // 1: yes, 0: no, -1: not all
@property (strong, nonatomic) NSString *categoryID;
@property (strong, nonatomic) NSString *sheetId;

- (instancetype)initQuestionWithQuestion:(NSString *)question
                                  andStt:(NSInteger)sttQuestion;
- (instancetype)initQuestionWithDictionary:(NSDictionary *)questionDic;
@end
