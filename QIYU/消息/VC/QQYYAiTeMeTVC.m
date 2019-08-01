//
//  QQYYAiTeMeTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYAiTeMeTVC.h"
#import "QQYYAiTeMeCell.h"
#import "QQYYZanOrAiTeMineCell.h"
@interface QQYYAiTeMeTVC ()
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end

@implementation QQYYAiTeMeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    if (self.type == 1) {
        self.navigationItem.title = @"收到的赞";
    }else {
        self.navigationItem.title = @"@我的消息";
    }
    
    [self.tableView registerClass:[QQYYAiTeMeCell class] forCellReuseIdentifier:@"cellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYZanOrAiTeMineCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pageNo = 1;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getData];
    }];
    

}

- (void)getData {
    
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNo);
    dict[@"pageSize"] = @(10);
    NSString * str = [QQYYURLDefineTool getPostLikeListForMyPostURL] ;
    if (self.type == 0) {
        str = [QQYYURLDefineTool getAtMeMsgListURL] ;
    }
    
    [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYZanOrAiTeMineCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.headBt.tag = indexPath.row + 100;
    cell.type = self.type;
    if (self.type == 0) {
        self.dataArray[indexPath.row].avatar = self.dataArray[indexPath.row].createByAvatar;
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QQYYDetailTVC * vc =[[QQYYDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[indexPath.row].postId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)gotoZhuYeAction:(UIButton *)button {
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataArray[button.tag - 100].createBy;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
