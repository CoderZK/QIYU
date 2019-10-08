//
//  HHHHLJTwelveTvc.m
//  QIYU
//
//  Created by zk on 2019/10/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHHHLJTwelveTvc.h"
#import "HHHHLJTwelveCell.h"
#import "HHHHLJFourteenTvc.h"
@interface HHHHLJTwelveTvc ()

@end

@implementation HHHHLJTwelveTvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"中华天元区";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHHHLJTwelveCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 41;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHHHLJTwelveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftImgV.backgroundColor = [UIColor greenColor];
    [cell.rightBT setTitle:@"jjjh" forState:UIControlStateNormal];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHHHLJFourteenTvc * vc =[[HHHHLJFourteenTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
