//
//  DoneViewController.h
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoneViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary *listResult;
@property (strong, nonatomic) NSMutableDictionary *listAnswerCategory;
@property (strong, nonatomic) NSMutableDictionary *listQuestionCategory;
@property (nonatomic) double correctPercent;

@end
