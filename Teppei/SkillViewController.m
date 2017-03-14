//
//  SkillViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/26.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "SkillViewController.h"
#import "Skill.h"
#import "NCMB/NCMB.h"
#import "DetailSkillViewController.h"

@interface SkillViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *listAllSkill; // of skill
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation SkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupData];
}


- (void)setupData {
    NCMBQuery *skillQuery = [NCMBQuery queryWithClassName:@"Skill"];
    [skillQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (NSDictionary *object in objects) {
                Skill *currentSkill = [[Skill alloc] initWithSkillDictionary:object];
                [self.listAllSkill addObject:currentSkill];
                [self.tableView reloadData];
            }
        }
    }];
}

- (NSMutableArray *)listAllSkill {
    if (!_listAllSkill) _listAllSkill = [[NSMutableArray alloc] init];
    return _listAllSkill;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listAllSkill.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkillCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    Skill *currentSkill = self.listAllSkill.count > 0? self.listAllSkill[indexPath.row]: nil;
    
    cell.textLabel.text = currentSkill.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"SkillSegue" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SkillSegue"]) {
        DetailSkillViewController *skillVC = segue.destinationViewController;
        skillVC.currentSkill = self.listAllSkill[self.selectedIndex];
    }
    
}


@end
