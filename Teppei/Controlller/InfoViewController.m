//
//  InfoViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/03/13.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "InfoViewController.h"
#import "NCMB/NCMB.h"
#import "ManagerSession.h"
#import "UserInfo.h"
#import "FSMediaPicker.h"

@interface InfoViewController ()<FSMediaPickerDelegate>

@property (strong, nonatomic) UserInfo *userInfo;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *changeImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self updateUI];
}

- (void)setupData {
    ManagerSession *managerSession = [ManagerSession shareInstance];
    NCMBQuery *userQuery = [NCMBQuery queryWithClassName:@"LoginRegister"];
    [userQuery whereKey:@"objectId" equalTo:managerSession.currentSession.userId];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            
        } else {
            if (objects.count > 0) {
                self.userInfo = [[UserInfo alloc] initWithDictionary:objects[0]];
                self.companyTextField.text = self.userInfo.company;
                self.positionTextField.text = self.userInfo.position;
                self.nameLabel.text = self.userInfo.userName;
            }
            
        }
    }];
}

- (void)updateUI {
    self.companyTextField.enabled = self.isUpdate;
    self.positionTextField.enabled = self.isUpdate;
    self.historyButton.hidden = self.isUpdate;
    self.changeImageButton.enabled = self.isUpdate;
    UIImage *avatarImage = [self loadImageFromLocalFile];
    if (avatarImage) self.profileImageView.image = avatarImage;
    [self.editButton setTitle:(self.isUpdate ? @"Done": @"Edit") forState:UIControlStateNormal];
   
}

- (UIImage *)loadImageFromLocalFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"avatar.png"];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}


- (IBAction)isAllowUpdateInfo:(UIButton *)sender {
    if (self.isUpdate) {
        [self updateInfoToServer];
    }
    
    self.isUpdate = !self.isUpdate;
    [self updateUI];
}

- (void)updateInfoToServer {
    NCMBObject *userObject = [NCMBObject objectWithClassName:@"LoginRegister"];
    userObject.objectId =  [ManagerSession shareInstance].currentSession.userId;
    
    [userObject fetchInBackgroundWithBlock:^(NSError *error) {
        if (!error) {
            [userObject setObject:self.companyTextField.text forKey:@"company"];
            [userObject setObject:self.positionTextField.text forKey:@"position"];
            [userObject saveInBackgroundWithBlock:^(NSError *error) {
                if (!error) {
                    
                }
            }];
        }
    }];
    
    
     
}

- (IBAction)changeImage:(UIButton *)sender {
    if (self.isUpdate) {
        FSMediaPicker *picker = [[FSMediaPicker alloc] init];
        picker.delegate = self;
        picker.editMode = FSEditModeCircular;
        [picker showFromView:sender];
    }
}

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo {
    self.profileImageView.image = mediaInfo.circularEditedImage;;
    
    // save image to local file
    [self saveImageToLocalFile: mediaInfo.circularEditedImage];
    
}

- (void)saveImageToLocalFile:(UIImage *)image {
    if (image != nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent: @"avatar.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}




@end
