//
//  QuestionViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/26.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"

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
    Question *question1 = [[Question alloc] initQuestionWithQuestion:@"信念や信条を他人に自信をもって伝えることができる" andStt:1];
    Question *question2 = [[Question alloc] initQuestionWithQuestion:@"人前で話すことは苦手である" andStt:2];
    Question *question3 = [[Question alloc] initQuestionWithQuestion:@"お金を貸してくれる友人・親族が5人以上いる" andStt:3];
    Question *question4 = [[Question alloc] initQuestionWithQuestion:@"知らない業種や知識にについて相談できる友人がいる" andStt:4];
    Question *question5 = [[Question alloc] initQuestionWithQuestion:@"自分のキャリアを一言で表すなら" andStt:5];
    Question *question6 = [[Question alloc] initQuestionWithQuestion:@"月4冊以上ビジネス書を読んでいる" andStt:6];
    Question *question7 = [[Question alloc] initQuestionWithQuestion:@"会社の代表・地域の代表という意識を持ちながら                           行動、発言、仕事をしている" andStt:7];
    Question *question8 = [[Question alloc] initQuestionWithQuestion:@"約束に遅れてくるシンガポール人は信用がならない" andStt:8];
    Question *question9 = [[Question alloc] initQuestionWithQuestion:@"コンビニで働いている外国人の日本語は変だと思う" andStt:9];
    Question *question10 = [[Question alloc] initQuestionWithQuestion:@"話をする時に身振り・手振りを意識する" andStt:10];
    Question *question11 = [[Question alloc] initQuestionWithQuestion:@"貯金をしないで刹那的に生きる人に腹がたつ" andStt:11];
                            Question *question12 = [[Question alloc] initQuestionWithQuestion:@"人と話をする時に意識しているのは視線を合わせる" andStt:12];
    Question *question13 = [[Question alloc] initQuestionWithQuestion:@"食事に行った時、メニューをみていつも選択に迷う" andStt:13];
    Question *question14 = [[Question alloc] initQuestionWithQuestion:@"友人グループの構成は" andStt:14];
    Question *question15 = [[Question alloc] initQuestionWithQuestion:@"人から表情豊かと言われる" andStt:15];
    Question *question16 = [[Question alloc] initQuestionWithQuestion:@"語学は得意である" andStt:16];
    Question *question17 = [[Question alloc] initQuestionWithQuestion:@"観光地にいるマナーがない外国人をみると" andStt:17];
    Question *question18 = [[Question alloc] initQuestionWithQuestion:@"会社の先輩や上司を敬う文化はどこから" andStt:18];
    Question *question19 = [[Question alloc] initQuestionWithQuestion:@"名言に感動し記録したり、人に話したりしたことがある" andStt:19];
    Question *question20 = [[Question alloc] initQuestionWithQuestion:@"人に会うと笑顔で接する" andStt:20];
    Question *question21 = [[Question alloc] initQuestionWithQuestion:@"日本はこれかも競争力を維持できる" andStt:21];
    Question *question22 = [[Question alloc] initQuestionWithQuestion:@"言葉を通じない人には身振り手振り絵などを使ってコミュニケーションをする" andStt:22];
    Question *question23 = [[Question alloc] initQuestionWithQuestion:@"英語以外の現地語を学ぶ必要性" andStt:23];
    Question *question24 = [[Question alloc] initQuestionWithQuestion:@"リスクを取るほうだ" andStt:24];
    Question *question25 = [[Question alloc] initQuestionWithQuestion:@"マーケティングの４Ｐを正しく言える" andStt:25];
    
    [self.listQuestion addObject:question1];
    [self.listQuestion addObject:question2];
    [self.listQuestion addObject:question3];
    [self.listQuestion addObject:question4];
    [self.listQuestion addObject:question5];
    [self.listQuestion addObject:question6];
    [self.listQuestion addObject:question7];
    [self.listQuestion addObject:question8];
    [self.listQuestion addObject:question9];
    [self.listQuestion addObject:question10];
    [self.listQuestion addObject:question11];
    [self.listQuestion addObject:question12];
    [self.listQuestion addObject:question13];
    [self.listQuestion addObject:question14];
    [self.listQuestion addObject:question15];
    [self.listQuestion addObject:question16];
    [self.listQuestion addObject:question17];
    [self.listQuestion addObject:question18];
    [self.listQuestion addObject:question19];
    [self.listQuestion addObject:question20];
    [self.listQuestion addObject:question21];
    [self.listQuestion addObject:question22];
    [self.listQuestion addObject:question23];
    [self.listQuestion addObject:question24];
    [self.listQuestion addObject:question25];

    
    self.indexCurrentQuestion = 0;
}

- (void)updateUI {
    if (self.indexCurrentQuestion < self.listQuestion.count) {
        Question *currentQuestion = self.listQuestion[self.indexCurrentQuestion];
        self.questionTitleLabel.text = [NSString stringWithFormat:@"Q%ld", currentQuestion.sttQuestion];
        self.questionTextView.text = currentQuestion.question;
    } else {
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
