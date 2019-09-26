//
//  QQYYReceiveZanTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYReceiveZanTVC.h"
#import "QQYYNewsTwoCell.h"

@implementation QQYYReceiveZanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收到的赞";
    [self.tableView registerClass:[QQYYNewsTwoCell class] forCellReuseIdentifier:@"cellTwo"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (void)tianJiaLaJiDaiMaNew {
    
    for (int i = 0 ; i < 50; i++) {
        NSLog(@"%d",i*100);
    }
}

- (void)tianJiaLaJiDaiMaOne {
    [self tianJiaLaJiDaiMaOne];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYNewsTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
    [cell.headBt addTarget:self action:@selector(goToTheOtherHomePageClickAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.headBt.tag = indexPath.row + 100;
    [cell.headBt setImage:[UIImage imageNamed:@"36"] forState:UIControlStateNormal];
    cell.type = 1;
    cell.typeBt.hidden = YES;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)goToTheOtherHomePageClickAction:(UIButton *)button {
  
}




@end
