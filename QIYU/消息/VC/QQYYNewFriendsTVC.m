//
//  QQYYNewFriendsTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYNewFriendsTVC.h"
#import "QQYYNewsTwoCell.h"
@interface QQYYNewFriendsTVC ()
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end

@implementation QQYYNewFriendsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    
    [self.tableView registerClass:[QQYYNewsTwoCell class] forCellReuseIdentifier:@"cellTwo"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.title = @"新朋友";
//    UIButton * rightbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 24)];
//    [rightbtn setTitle:@"清空" forState:UIControlStateNormal];
//    [rightbtn setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
//    [rightbtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    rightbtn.tag = 11;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
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

//加好友
- (void)navBtnClick:(UIButton *)button {
    
   
    
}

- (void)getData {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNo);
    dict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getNewFriendMsgListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYNewsTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
    [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.headBt.tag = indexPath.row + 100;
    [cell.cancelBt addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.cancelBt.tag = indexPath.row + 100;
    [cell.typeBt addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.typeBt.tag = indexPath.row + 100;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataArray[indexPath.row].createBy;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelAction:(UIButton *)button {
     [self actionWithIndex:button.tag - 100 withisOk:0];
}
- (void)confirmAction:(UIButton *)button {
 
    [self actionWithIndex:button.tag - 100 withisOk:1];
    
}

- (void)actionWithIndex:(NSInteger)index withisOk:(NSInteger)isOk{
    
    QQYYTongYongModel * model = self.dataArray[index];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"userFriendId"] = model.ID;
    dict[@"agree"] = @(isOk);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool agreeNewFriendApplyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (isOk) {
                model.status = 2;
            }else {
                model.status = 3;
            }
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)gotoZhuYeAction:(UIButton *)button {
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataArray[button.tag - 100].createBy;
    [self.navigationController pushViewController:vc animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
