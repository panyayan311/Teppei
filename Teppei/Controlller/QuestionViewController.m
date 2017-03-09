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

@interface QuestionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (strong, nonatomic) NSMutableArray *listQuestion;// of question
@property (nonatomic) NSInteger indexCurrentQuestion; // index current question


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
- (void)setupData {
    NCMBQuery *query = [NCMBQuery queryWithClassName:@"Questions"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // process error
        } else {
            for (NSDictionary * object in objects) {
                [self.listQuestion addObject:[[Question alloc] initQuestionWithDictionary:object]];
            }
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
        [self performSegueWithIdentifier:@"ResultGraph" sender:nil];
    }
    
}

- (IBAction)answerQuestionButton:(UIButton *)sender {
    if (self.indexCurrentQuestion < self.listQuestion.count) {
        Question *currentQuestion = self.listQuestion[self.indexCurrentQuestion++];
        currentQuestion.answerQuestion = sender.tag;
        
        [self updateUI];
    } else {
        [self performSegueWithIdentifier:@"ResultGraph" sender:nil];
    }
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
