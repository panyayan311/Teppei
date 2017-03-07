//
//  SignupViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "SignupViewController.h"
#import "NCMB/NCMB.h"

@interface SignupViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *validInfoLabel;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    self.title = @"Teppei";
    self.navigationController.navigationBar.hidden = false;
    self.validInfoLabel.hidden = true;
    
    self.userNameTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
    self.emailTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (IBAction)signupAccount:(UIButton *)sender {
    NCMBObject *userLogin = [NCMBObject objectWithClassName:@"LoginRegister"];
    
    // check valid input
    if ([self isValidInfoRegister]) {
//        [userLogin setObject:self.userNameTextfield.text forKey:@"objectId"];
        [userLogin setObject:self.userNameTextfield.text forKey:@"userName"];
        [userLogin setObject:self.passwordTextfield.text forKey:@"password"];
        [userLogin setObject:self.emailTextField.text forKey:@"email"];
        
        [userLogin saveInBackgroundWithBlock:^(NSError *error) {
            if (error) {
                self.validInfoLabel.hidden = false;
            } else {
                
                [self performSegueWithIdentifier:@"SignupSegue" sender:nil];
            }
        }];
    }
}

- (Boolean)isValidInfoRegister {
    return true;
}

@end
