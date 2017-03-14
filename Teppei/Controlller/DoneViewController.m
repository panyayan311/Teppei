//
//  DoneViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "DoneViewController.h"
#import "EvalGraph.h"
#import "DetailScoreViewController.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet EvalGraph *graphView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailScoreButton;

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
    
}

- (void)setupData {
    if (!_listResult) _listResult = [[NSMutableDictionary alloc] init];
    
    for (NSString *categoryID in self.listQuestionCategory.allKeys) {
        if ([self.listAnswerCategory.allKeys containsObject:categoryID]) {
            [self.listResult setObject:@([[self.listAnswerCategory objectForKey:categoryID] doubleValue] / [[self.listQuestionCategory objectForKey:categoryID] doubleValue]) forKey:categoryID];
        } else {
            [self.listResult setObject:@(0.0) forKey:categoryID];
        }
    }
    self.graphView.listResult = self.listResult;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)(self.correctPercent * 100)];//;
    if (self.listQuestionCategory.count == 0) {
        self.graphView.hidden = true;
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)setupUI {
    self.title = @"TEPPEI";
    self.scoreLabel.hidden = !(self.listQuestionCategory.count == 0);
    self.detailScoreButton.hidden = (self.listQuestionCategory.count == 0);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ScoreSegue"]) {
        DetailScoreViewController *detailScoreVC = segue.destinationViewController;
        detailScoreVC.listResult = self.listResult;
    }
}

- (IBAction)showDetailScore:(UIButton *)sender {
    if (self.listQuestionCategory.count > 0) {
        [self performSegueWithIdentifier:@"ScoreSegue" sender:nil];
    }
}


@end
