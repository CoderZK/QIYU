//
//  HHHHLJThirteenTvc.m
//  QIYU
//
//  Created by zk on 2019/10/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHHHLJThirteenTvc.h"
#import "HHHHLJThirteenCell.h"
@interface HHHHLJThirteenTvc ()

@end

@implementation HHHHLJThirteenTvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"13";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHHHLJThirteenCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHHHLJThirteenCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.imgV1.backgroundColor = [UIColor redColor];
    cell.imgV2.backgroundColor = [UIColor greenColor];
    cell.imgV3.backgroundColor = [UIColor purpleColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
