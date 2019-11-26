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

#import "AAAAModel.h"

@interface QQYYGouWuTVC ()<QQYYGouWuCheCellDelegate>
@property(nonatomic,strong)NSMutableArray<AAAAModel *> *dataArray;
@property(nonatomic,assign)NSInteger pageNo;
@end

@implementation QQYYGouWuTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"疯狂购物";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYGouWuCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getGoodsList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNo++;
        [SVProgressHUD show];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [SVProgressHUD dismiss];
                   [self.tableView.mj_header endRefreshing];
                   [self.tableView.mj_footer endRefreshing];
                   [self.tableView reloadData];
                   
            });
    }];
    
    
}

- (void)getGoodsList {
    
    FMDatabase * db = [AAAAFMDBSignle shareFMDB].fd;
    if ([db open]) {
        
        NSString * sql = @"select * from 'goods_ios' ";
           FMResultSet *result = [db executeQuery:sql];
           while ([result next]) {
               AAAAModel *goodsModel = [AAAAModel new];
               goodsModel.id = [result intForColumn:@"id"];
               goodsModel.desTwo = [result stringForColumn:@"desTwo"];
               goodsModel.name = [result stringForColumn:@"name"];
               goodsModel.imgStr = [result stringForColumn:@"imgStr"];
               goodsModel.des = [result stringForColumn:@"des"];
               goodsModel.price =[result doubleForColumn:@"price"];
               goodsModel.status = [result intForColumn:@"status"];
               [self.dataArray addObject:goodsModel];
           }
           [db close];
           [self.tableView.mj_header endRefreshing];
           [self.tableView.mj_footer endRefreshing];
        
           [self.tableView reloadData];
        
        
    }else {
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count / 2 + self.dataArray.count % 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85 + (ScreenW - 30 )/2.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYGouWuCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    
    
    
    AAAAModel * model1 = self.dataArray[indexPath.row * 2];
    AAAAModel * model2 = nil;
    if (self.dataArray.count >=  (indexPath.row * 2 + 1)) {
        model2 = self.dataArray[indexPath.row * 2 + 1];
    }else {
    }
    cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model1.imgStr]];
    cell.leftMoneyLB.text = [NSString stringWithFormat:@"%0.2f",model1.price];
    cell.leftTitleLB.text = model1.name;
    if (model2 != nil) {
        cell.rightImgV.hidden = cell.rightMoneyLB.hidden = cell.rightTitleLB.hidden = NO;
        cell.rightImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model2.imgStr]];
        cell.rightMoneyLB.text = [NSString stringWithFormat:@"￥%0.2f",model2.price];
                cell.rightTitleLB.text = model2.name;
    }else {
        cell.rightImgV.hidden = cell.rightMoneyLB.hidden = cell.rightTitleLB.hidden = YES;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didIndex:(NSInteger)index withCell:(QQYYGouWuCell *)cell {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QQYYGouWuDetailTVC * vc =[[QQYYGouWuDetailTVC alloc] init];
    vc.model = self.dataArray[indexPath.row *2 + index];
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
