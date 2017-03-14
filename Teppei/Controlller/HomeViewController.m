//
//  HomeViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    self.title = @"TEPPEI";
    self.navigationController.navigationBar.hidden = false;
    self.navigationItem.hidesBackButton = true;
    
    self.userNameLabel.text = self.userInfo.userName;
    UIImage *avatarImage = [self loadImageFromLocalFile];
    if (avatarImage) self.avatarImageView.image = avatarImage;
}


- (IBAction)backToHomeUI:(UIStoryboardSegue *)unwindSegue {
    // nothing to do
}


- (UIImage *)loadImageFromLocalFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"avatar.png"];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}




@end
