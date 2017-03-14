//
//  DetailScoreViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/03/14.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "DetailScoreViewController.h"
#import "Constant.h"

@interface DetailScoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *caltureScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *humanScoreLabel;

@end

@implementation DetailScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI {
    self.caltureScoreLabel.text = [NSString stringWithFormat:@"%d%%", (int)([[self.listResult objectForKey:kCategoryIdCalture] doubleValue]* 100)];
    self.businessScoreLabel.text = [NSString stringWithFormat:@"%d%%", (int)([[self.listResult objectForKey:kCategoryIdBusiness] doubleValue]* 100)];
    self.presentScoreLabel.text = [NSString stringWithFormat:@"%d%%", (int)([[self.listResult objectForKey:kCategoryIdPrerent] doubleValue]* 100)];
    self.humanScoreLabel.text = [NSString stringWithFormat:@"%d%%", (int)([[self.listResult objectForKey:kCategoryIdHuman] doubleValue]* 100)];
}


@end
