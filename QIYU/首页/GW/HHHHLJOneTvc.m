//
//  HHHHLJOneTvc.m
//  QIYU
//
//  Created by zk on 2019/10/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHHHLJOneTvc.h"
#import "HHHHLJOneCell.h"
#import "HHHHLJTwoTvc.h"
@interface HHHHLJOneTvc ()

@end

@implementation HHHHLJOneTvc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"HHHHLJOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHHHLJOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = @"akdji";
    [cell.rightBt setTitle:@"iikik" forState:UIControlStateNormal];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHHHLJTwoTvc * vc =[[HHHHLJTwoTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
