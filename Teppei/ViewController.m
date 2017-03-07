//
//  ViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "ViewController.h"
#import "NCMB/NCMB.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UILabel *validLabel;

@end

@implementation ViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self updateUI];
}

- (void)updateUI {
    self.navigationController.navigationBar.hidden = true;
    self.validLabel.hidden = true;
    
    self.userNameTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
}

- (IBAction)login:(UIButton *)sender {
    NCMBQuery *getUserQuery = [NCMBQuery queryWithClassName:@"LoginRegister"];
    
    
    [getUserQuery whereKey:@"password" equalTo:self.passwordTextfield.text];
    [getUserQuery whereKey:@"userName" equalTo:self.userNameTextfield.text];
    [getUserQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 0 || error) {
            self.validLabel.hidden = false;
        } else {
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
            [self updateUI];
        }
    }];
}

- (Boolean)isValidLoginInfo {
    
    
    
    return false;
}



@end
