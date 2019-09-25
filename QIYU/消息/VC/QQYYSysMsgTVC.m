//
//  QQYYSysMsgTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/7/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYSysMsgTVC.h"
#import "QQYYSysMsgCell.h"
@interface QQYYSysMsgTVC ()
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@property(nonatomic,assign)NSInteger pageNo;
@end

@implementation QQYYSysMsgTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYSysMsgCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
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
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"pageNo"] = @(self.pageNo);
    requestDict[@"pageSize"] = @(20);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getMySysMsgListURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            NSArray * arr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"][@"rows"]];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYSysMsgCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    QQYYTongYongModel * model = self.dataArray[indexPath.row];
    cell.contentLB.text = model.content;
    if (model.createTime.length > 16) {
        cell.timeLB.text = [model.createTime substringToIndex:16];
    }else {
        cell.timeLB.text = model.createTime;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
}
- (void)buZhiDaoXieShaSuiBianXieLeWithNumber:(int)number {
    
    for ( int i = 0 ; i < number; i++) {
        
        int c = i * 100;
        c = i + c;
        NSLog(@"%ld",c);
    }
    
}

- (void)SuiBianWanWanLe {
    [self buZhiDaoXieShaSuiBianXieLeWithNumber:10];
}


// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteMesgWithIndexPath:indexPath];
    }
    
}

- (void)deleteMesgWithIndexPath:(NSIndexPath *)indexPath {
    
    Weak(weakSelf);
    [self deleteMessageWithMessageId:self.dataArray[indexPath.row].msgId result:^(BOOL isOK) {
        
        if (isOK) {
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView reloadData];
        }
        
    }];
    
}


@end
