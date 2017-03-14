//
//  DetailSkillViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/03/14.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "DetailSkillViewController.h"
#import "TutorialSkillViewController.h"

@interface DetailSkillViewController ()
@property (weak, nonatomic) IBOutlet UITextView *skillTextView;

@end

@implementation DetailSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}


- (void)setupData {
    self.skillTextView.text = self.currentSkill.content;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TutorialSegue"]) {
        TutorialSkillViewController *tutorialSkillVC = segue.destinationViewController;
        tutorialSkillVC.currentSkill = self.currentSkill;
    }
}

@end
