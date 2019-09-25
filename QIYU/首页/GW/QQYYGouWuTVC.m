//
//  QQYYGouWuTVC.m
//  QIYU
//
//  Created by zk on 2019/9/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYGouWuTVC.h"
#import "QQYYGouWuCell.h"
#import "QQYYGouWuDetailTVC.h"
@interface QQYYGouWuTVC ()<QQYYGouWuCheCellDelegate>

@end

@implementation QQYYGouWuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"疯狂购物";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYGouWuCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85 + (ScreenW - 30 )/2.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYGouWuCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didIndex:(NSInteger)index withCell:(QQYYGouWuCell *)cell {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    
    QQYYGouWuDetailTVC * vc =[[QQYYGouWuDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
