//
//  TutorialSkillViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/03/14.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "TutorialSkillViewController.h"

@interface TutorialSkillViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tutorialTextView;

@end

@implementation TutorialSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)setupUI {
    self.tutorialTextView.text = self.currentSkill.tutorial;
}


@end
