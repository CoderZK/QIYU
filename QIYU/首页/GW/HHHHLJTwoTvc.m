//
//  HHHHLJTwoTvc.m
//  QIYU
//
//  Created by zk on 2019/10/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHHHLJTwoTvc.h"
#import "HHHHLJTwoCell.h"
#import "HHHHLJThreeTvc.h"
@interface HHHHLJTwoTvc ()

@end

@implementation HHHHLJTwoTvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"dhaijdi";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHHHLJTwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHHHLJTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = @"left";
    cell.centerLB.text = @"center";
    cell.rightLB.text = @"right";
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HHHHLJThreeTvc * vc =[[HHHHLJThreeTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
