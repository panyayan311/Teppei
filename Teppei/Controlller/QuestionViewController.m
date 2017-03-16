//
//  QuestionViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/26.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"
#import "NCMB/NCMB.h"
#import "UserInfo.h"
#import "DoneViewController.h"
#import "Sheet.h"
#import "ManagerSession.h"
#import "AnswerQuestion.h"

@interface QuestionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (strong, nonatomic) NSMutableArray *listQuestion;// of question
@property (nonatomic) NSInteger indexCurrentQuestion; // index current question
@property (strong, nonatomic) NSMutableDictionary *listAnswerCategory;
@property (strong, nonatomic) NSMutableDictionary *listQuestionCategory;
@property (strong, nonatomic) NSMutableDictionary *listtAllAnswers;

@property (nonatomic) NSInteger correctAnswerNumber;

// for display history

@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UIButton *noneButton;


@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.isDisplayHistory) {
        [self setupData];
    } else {
        [self setupDataHistory];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSMutableArray *)listQuestion {
    if (!_listQuestion) {
        _listQuestion = [[NSMutableArray alloc] init];
    }
    return _listQuestion;
}

- (NSMutableDictionary *)listAnswerCategory {
    if (!_listAnswerCategory) _listAnswerCategory = [[NSMutableDictionary alloc] init];
    return _listAnswerCategory;
}

- (NSMutableDictionary *)listQuestionCategory {
    if (!_listQuestionCategory) _listQuestionCategory = [[NSMutableDictionary alloc] init];
    return _listQuestionCategory;
}

- (NSMutableDictionary *)listtAllAnswers {
    if (!_listtAllAnswers) _listtAllAnswers = [[NSMutableDictionary alloc] init];
    return _listtAllAnswers;
}

- (void)setupData {
    // get active sheet
    NCMBQuery *activeSheetQuery = [NCMBQuery queryWithClassName:@"Sheet"];
    [activeSheetQuery whereKey:@"isActive" equalTo:@"true"];
    
    [activeSheetQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
        } else if (objects.count > 0) {
            
            Sheet *activeSheet = [[Sheet alloc] initSheetWithDictionary:objects[0]];
            
            
            NCMBQuery *query = [NCMBQuery queryWithClassName:@"Questions"];
            [query whereKey:@"sheetId" equalTo:activeSheet.sheetId];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error) {
                    // process error
                } else {
                    for (NSDictionary * object in objects) {
                        Question *question = [[Question alloc] initQuestionWithDictionary:object];
                        question.sheetId = activeSheet.sheetId;
                        [self.listQuestion addObject: question];
                        // process for category nil
                        if (question.categoryID) {
                            if ([self.listQuestionCategory.allKeys containsObject:question.categoryID]) {
                                NSInteger count = [[self.listQuestionCategory objectForKey:question.categoryID] integerValue];
                                [self.listQuestionCategory setObject:@(count + 1) forKey:question.categoryID];
                            } else {
                                [self.listQuestionCategory setObject:@(1) forKey:question.categoryID];
                            }
                        }
                        
                    }
                }
                [self updateUI];
            }];
        }
    }];
    
    self.indexCurrentQuestion = 0;
}

- (void)setupDataHistory {
    NCMBQuery *query = [NCMBQuery queryWithClassName:@"AnswerQuestion"];
    [query whereKey:@"userId" equalTo:[ManagerSession shareInstance].currentSession.userId];
    [query whereKey:@"uploadDateTime" equalTo:self.historyDateTime];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // process error
        } else {
            for (NSDictionary * object in objects) {
                AnswerQuestion *answerQuestion = [[AnswerQuestion alloc] initAnswerQuestionForDictionary:object];
                [self.listtAllAnswers setObject:@(answerQuestion.answer) forKey:answerQuestion.questionId];
            }
            if (objects.count > 0) {
                AnswerQuestion *answerQuestion = [[AnswerQuestion alloc] initAnswerQuestionForDictionary:objects[0]];
                NCMBQuery *questionQuery = [NCMBQuery queryWithClassName:@"Questions"];
                [questionQuery whereKey:@"sheetId" equalTo:answerQuestion.sheetId];
                
                [questionQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (error) {
                        // process error
                    } else {
                        for (NSDictionary * object in objects) {
                            Question *question = [[Question alloc] initQuestionWithDictionary:object];
                            [self.listQuestion addObject: question];
                            // process for category nil
                            if (question.categoryID) {
                                if ([self.listQuestionCategory.allKeys containsObject:question.categoryID]) {
                                    NSInteger count = [[self.listQuestionCategory objectForKey:question.categoryID] integerValue];
                                    [self.listQuestionCategory setObject:@(count + 1) forKey:question.categoryID];
                                } else {
                                    [self.listQuestionCategory setObject:@(1) forKey:question.categoryID];
                                }
                            }
                            
                        }
                    }
                    [self updateUI];
                }];
            }
        }
    }];

}


- (void)updateUI {
    if (self.isDisplayHistory) {
        self.yesButton.enabled = false;
        self.noButton.enabled = false;
        self.noneButton.enabled = false;
    }
    if (self.indexCurrentQuestion < self.listQuestion.count) {
        Question *currentQuestion = self.listQuestion[self.indexCurrentQuestion];
        self.questionTitleLabel.text = [NSString stringWithFormat:@"Q%ld", self.indexCurrentQuestion + 1];
        self.questionTextView.text = currentQuestion.question;
        
        if (self.isDisplayHistory) {
            NSInteger answer = [[self.listtAllAnswers objectForKey:currentQuestion.questionID] integerValue];
            if (answer == 1) {
                self.yesButton.enabled = true;
            } else if (answer == 0) {
                self.noneButton.enabled = true;
            } else if (answer == -1) {
                self.noButton.enabled = true;
            }
        }
        
    } else if (self.listQuestion.count > 0) {
        if (!self.isDisplayHistory) [self uploadAnswersToServer];
        [self performSegueWithIdentifier:@"ResultGraph" sender:nil];
    }
    
}

- (IBAction)answerQuestionButton:(UIButton *)sender {
    if (self.indexCurrentQuestion < self.listQuestion.count) {
        Question *currentQuestion = self.listQuestion[self.indexCurrentQuestion++];
        currentQuestion.answerQuestion = sender.tag;
        
        // process for category nil
        if (self.listQuestionCategory.count > 0) {
            // update for list answer, category
            if ([self.listAnswerCategory.allKeys containsObject:currentQuestion.categoryID]) {
                if (sender.tag == 1) {
                    NSInteger count = [[self.listAnswerCategory objectForKey:currentQuestion.categoryID] integerValue];
                    [self.listAnswerCategory setObject:@(count + 1) forKey:currentQuestion.categoryID];
                }
            } else {
                [self.listAnswerCategory setObject:@(0) forKey:currentQuestion.categoryID];
            }
        } else if (sender.tag == 1) {
            self.correctAnswerNumber++;
        }
        
        [self.listtAllAnswers setObject:@(sender.tag) forKey:currentQuestion.questionID];// 1 for yes -1 for no, 0 for other
        [self updateUI];
    } else {
        if (self.listtAllAnswers.count > 0) [self uploadAnswersToServer];
        [self performSegueWithIdentifier:@"ResultGraph" sender:nil];
    }
}

- (void)uploadAnswersToServer {
    NSMutableArray *allAnswers = [[NSMutableArray alloc] init];
    NSDate *uploadDate = [NSDate date];
    for (NSString *key in self.listtAllAnswers.allKeys) {
        NCMBObject *answerObject = [NCMBObject objectWithClassName:@"AnswerQuestion"];
        Question *question = [self getQuestionById:key];
        
        [answerObject setObject:key forKey:@"questionId"];
        [answerObject setObject:[self.listtAllAnswers objectForKey:key]  forKey:@"answer"];
        [answerObject setObject:[ManagerSession shareInstance].currentSession.userId forKey:@"userId"];
        [answerObject setObject:uploadDate forKey:@"uploadDateTime"];
        [answerObject setObject:question.sheetId forKey:@"sheetId"];
        [allAnswers addObject:answerObject];
    }
    [NCMBObject saveAllInBackground:allAnswers withBlock:^(NSArray *results, NSError *error) {
        if (error) {
            
        }
    }];
}

- (Question *)getQuestionById:(NSString *)questionId {
    for (Question *question in self.listQuestion) {
        if ([question.questionID isEqualToString:questionId]) return question;
    }
    return nil;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultGraph"]) {
        
        DoneViewController *doneVC = segue.destinationViewController;
        doneVC.listQuestionCategory = self.listQuestionCategory;
        doneVC.listAnswerCategory = self.listAnswerCategory;
        doneVC.correctPercent = self.listQuestion.count > 0? ((double)self.correctAnswerNumber / self.listQuestion.count) : 0.0;
    }
}

@end
