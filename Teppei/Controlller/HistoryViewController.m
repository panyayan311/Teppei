//
//  HistoryViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/03/16.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "HistoryViewController.h"
#import <NCMB/NCMB.h>
#import "ManagerSession.h"
#import "QuestionViewController.h"

@interface HistoryViewController ()

@property (strong, nonatomic) NSMutableOrderedSet *listDateTime; // of date time of answers history
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self updateUI];
}

- (NSMutableOrderedSet *)listDateTime {
    if (!_listDateTime) _listDateTime = [[NSMutableOrderedSet alloc] init];
    return _listDateTime;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _dateFormatter;
}

- (void)setupData {
    NCMBQuery *query = [NCMBQuery queryWithClassName:@"AnswerQuestion"];
    [query whereKey:@"userId" equalTo:[ManagerSession shareInstance].currentSession.userId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (NSDictionary *object in objects) {
                NSDate *dateTime = [object objectForKey:@"uploadDateTime"];
                if (![self.listDateTime containsObject:dateTime]) {
                    [self.listDateTime addObject:dateTime];
                }
                
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)updateUI {
    self.title = @"TEPPEI";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDateTime.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
    
    NSDate *dateTime = [self.listDateTime objectAtIndex:indexPath.row];
    if (!cell) cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [self.dateFormatter stringFromDate: dateTime];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"HistorySegue"]) {
        QuestionViewController *questionVC = segue.destinationViewController;
        questionVC.isDisplayHistory = true;
        questionVC.historyDateTime = [self.listDateTime objectAtIndex:self.selectedIndex];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"HistorySegue" sender:nil];
}


@end
