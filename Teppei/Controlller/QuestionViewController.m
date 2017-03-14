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

@interface QuestionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (strong, nonatomic) NSMutableArray *listQuestion;// of question
@property (nonatomic) NSInteger indexCurrentQuestion; // index current question
@property (strong, nonatomic) NSMutableDictionary *listAnswerCategory;
@property (strong, nonatomic) NSMutableDictionary *listQuestionCategory;
@property (strong, nonatomic) NSMutableDictionary *listtAllAnswers;

@property (nonatomic) NSInteger correctAnswerNumber;


@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
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
            [query whereKey:@"sheetId" equalTo:activeSheet.id];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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
            }];
        }
    }];
    
    self.indexCurrentQuestion = 0;
}


- (void)updateUI {
    if (self.indexCurrentQuestion < self.listQuestion.count) {
        Question *currentQuestion = self.listQuestion[self.indexCurrentQuestion];
        self.questionTitleLabel.text = [NSString stringWithFormat:@"Q%ld", self.indexCurrentQuestion + 1];
        self.questionTextView.text = currentQuestion.question;
    } else if (self.listQuestion.count > 0) {
        [self uploadAnswersToServer];
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
    for (NSString *key in self.listtAllAnswers.allKeys) {
        NCMBObject *answerObject = [NCMBObject objectWithClassName:@"AnswerQuestion"];
        [answerObject setObject:key forKey:@"questionId"];
        [answerObject setObject:[self.listtAllAnswers objectForKey:key]  forKey:@"answer"];
        [answerObject setObject:[ManagerSession shareInstance].currentSession.userId forKey:@"userId"];
        [allAnswers addObject:answerObject];
    }
    [NCMBObject saveAllInBackground:allAnswers withBlock:^(NSArray *results, NSError *error) {
        if (error) {
            
        }
    }];
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
