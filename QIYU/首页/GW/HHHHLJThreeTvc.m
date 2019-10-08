//
//  HHHHLJThreeTvc.m
//  QIYU
//
//  Created by zk on 2019/10/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHHHLJThreeTvc.h"
#import "HHHHLJThreeCell.h"
#import "HHHHLJFourTvc.h"
@interface HHHHLJThreeTvc ()

@end

@implementation HHHHLJThreeTvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第三";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHHHLJThreeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 36;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHHHLJThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.LB1.text = @"LB1";
    cell.LB2.text = @"juk";
    cell.LB4.text = @"lajihueu";
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHHHLJFourTvc * vc =[[HHHHLJFourTvc alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];  
}


@end
