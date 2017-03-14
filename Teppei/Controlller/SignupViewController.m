//
//  SignupViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "SignupViewController.h"
#import "NCMB/NCMB.h"
#import "ManagerSession.h"
#import "Session.h"
#import "HomeViewController.h"
#import "UserInfo.h"
#import <CommonCrypto/CommonDigest.h>

@interface SignupViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *validInfoLabel;
@property (strong, nonatomic) UserInfo *userInfo;
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
        [userLogin setObject:[self md5HexDigest: self.passwordTextfield.text] forKey:@"password"];
        [userLogin setObject:self.emailTextField.text forKey:@"email"];
        
        [userLogin saveInBackgroundWithBlock:^(NSError *error) {
            if (error) {
                self.validInfoLabel.hidden = false;
            } else {
                if (!self.userInfo) self.userInfo = [[UserInfo alloc] init];
                self.userInfo.userName = self.userNameTextfield.text;
                Session *session = [[Session alloc] initWithUserName:self.userNameTextfield.text andPassword:self.passwordTextfield.text];
                ManagerSession *managerSession = [ManagerSession shareInstance];
                [managerSession saveSession:session];
                [self performSegueWithIdentifier:@"SignupSegue" sender:nil];
            }
        }];
    } else {
        self.validInfoLabel.hidden = false;
    }
}

- (Boolean)isValidEmail {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.emailTextField.text];
}

- (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (unsigned int)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


- (Boolean)isValidInfoRegister {
    if (![self isValidEmail]) return false;
    if ([self.userNameTextfield.text isEqualToString:@""]) return false;
    if ([self.passwordTextfield.text isEqualToString:@""]) return false;
    return true;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SignupSegue"]) {
        HomeViewController *homeVC = segue.destinationViewController;
        homeVC.userInfo = self.userInfo;
        
    }
}

@end
