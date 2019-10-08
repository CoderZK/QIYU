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


#import "HHHHLJOneTvc.h"
#import "HHHHLJFourteenTvc.h"
#import "HHHHLJElevenTvc.h"
#import "HHHHLJEightTvc.h"
#import "HHHHLJNineTvc.h"
#import "HHHHLJTenTvc.h"
#import "HHHHLJElevenTvc.h"
#import "HHHHLJTwelveTvc.h"
#import "HHHHLJThirteenTvc.h"
#import "HHHHLJFourteenTvc.h"


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

- (void)pushOne {
    HHHHLJOneTvc * vc =[[HHHHLJOneTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushTwoTVC {
    HHHHLJFourteenTvc * vc =[[HHHHLJFourteenTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushElevenVC {
    HHHHLJElevenTvc * vc =[[HHHHLJElevenTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushLJ {
    HHHHLJThirteenTvc * vc =[[HHHHLJThirteenTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushEight {
    HHHHLJEightTvc * vc =[[HHHHLJEightTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushNine {
    HHHHLJNineTvc * vc =[[HHHHLJNineTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushTen {
    HHHHLJTenTvc * vc =[[HHHHLJTenTvc alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushAll {
    [self pushLJ];
    [self pushOne];
    [self pushEight];
    [self pushTwoTVC];
    [self pushElevenVC];
    [self pushNine];
    [self pushTen];
}


@end
