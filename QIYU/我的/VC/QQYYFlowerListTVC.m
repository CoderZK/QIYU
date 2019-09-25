//
//  QQYYFlowerListTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYFlowerListTVC.h"
#import "QQYYFlowerListCell.h"
@interface QQYYFlowerListTVC ()
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@property(nonatomic,assign)NSInteger pageNo;
@end

@implementation QQYYFlowerListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"爱豆记录";
    self.dataArray = @[].mutableCopy;
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYFlowerListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pageNo = 1;
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self acquireDataFromServe];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];
}

- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    //    dict[@"tagId"] = @(self.tagId);
    dict[@"pageNo"] = @(self.pageNo);
    dict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getMyFlowerOrderListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            NSArray * arr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
            if (self.pageNo == 1) {
                [self.dataArray removeAllObjects];
            }
            
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            self.pageNo++;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYFlowerListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    QQYYTongYongModel * model = self.dataArray[indexPath.row];
    cell.titleLB.text = self.dataArray[indexPath.row].title;
    cell.timeLB.text = [NSString stringWithTime:self.dataArray[indexPath.row].createTime];
    if ([model.orderType isEqualToString:@"3"] ||[model.orderType isEqualToString:@"5"]){
        cell.numberLB.text = [NSString stringWithFormat:@"-%@",model.orderFee];
    }else {
        cell.numberLB.text = [NSString stringWithFormat:@"+%@",model.orderFee];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
