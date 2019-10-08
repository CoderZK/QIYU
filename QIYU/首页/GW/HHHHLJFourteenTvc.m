//
//  HHHHLJFourteenTvc.m
//  QIYU
//
//  Created by zk on 2019/10/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHHHLJFourteenTvc.h"
#import "HHHHLJFourteenCell.h"
@interface HHHHLJFourteenTvc ()

@end

@implementation HHHHLJFourteenTvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第十四";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHHHLJFourteenCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHHHLJFourteenCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = @"sjjsj";
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
