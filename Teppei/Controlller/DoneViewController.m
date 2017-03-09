//
//  DoneViewController.m
//  Teppei
//
//  Created by levanha711 on 2017/01/10.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "DoneViewController.h"
#import "EvalGraph.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet EvalGraph *graphView;

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
    
}

- (void)setupData {
    if (!_listResult) _listResult = [[NSMutableDictionary alloc] init];
    [_listResult setObject:@(0.3) forKey:@"異文化理解"];
    [_listResult setObject:@(0.1) forKey:@"人間的魅力"];
    [_listResult setObject:@(0.44) forKey:@"プレゼンス"];
    [_listResult setObject:@(0.5) forKey:@"ビジネス"];
    self.graphView.listResult = self.listResult;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)setupUI {
    self.title = @"TEPPEI";
}



@end
