//
//  ViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "ViewController.h"
#import "NCMB/NCMB.h"
#import "HomeViewController.h"
#import "UserInfo.h"
#import "Session.h"
#import "ManagerSession.h"
#import <CommonCrypto/CommonDigest.h> // for hash password

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UILabel *validLabel;
@property (strong, nonatomic) UserInfo *userInfo;

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
    
    [getUserQuery whereKey:@"password" equalTo:[self md5HexDigest: self.passwordTextfield.text]];
    [getUserQuery whereKey:@"userName" equalTo:self.userNameTextfield.text];
    [getUserQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 0 || error) {
            self.validLabel.hidden = false;
        } else {
            NSDictionary *estimateData = (NSDictionary *)[objects objectAtIndex:0];
            self.userInfo = [[UserInfo alloc] initWithDictionary:estimateData];
            
            Session *session = [[Session alloc] initWithUserId:self.userInfo.userId UserName:self.userNameTextfield.text andPassword:self.passwordTextfield.text];
            ManagerSession *managerSession = [ManagerSession shareInstance];
            [managerSession saveSession:session];
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
            [self updateUI];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LoginSegue"]) {
        HomeViewController *homeVC = (HomeViewController *)segue.destinationViewController;
        homeVC.userInfo = self.userInfo;
    }
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


@end
