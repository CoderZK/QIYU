//
//  QQYYMakeFriendsTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMakeFriendsTVC.h"
#import "QQYYMakeFriendsCell.h"
@interface QQYYMakeFriendsTVC ()
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@end

@implementation QQYYMakeFriendsTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView:) name:@"DAIBAN" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[QQYYMakeFriendsCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.dataArray = @[].mutableCopy;
    self.pageNo = 1;
    [self acquireDataFromServe];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self acquireDataFromServe];

    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];
    
    if (!self.isHot) {
        [QQYYpublicFunction updateLatitudeAndLongitude];
    }
    
}

- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"pageNo"] = @(self.pageNo);
    requestDict[@"pageSize"] = @(10);
    NSString * url = [QQYYURLDefineTool nearbyUserListURL];
    if (self.isHot) {
        url = [QQYYURLDefineTool heatUserListURL];
    }else {
        
        if ([QQYYSignleToolNew shareTool].latitude > 0) {
            requestDict[@"latitude"] = @([QQYYSignleToolNew shareTool].latitude);
            requestDict[@"longitude"] = @([QQYYSignleToolNew shareTool].longitude);
        }
    }
    
    [QQYYRequestTool networkingPOST:url parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            NSArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
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

- (void)changeView:(NSNotification *)noti {
    
    NSDictionary * requestDict = noti.userInfo;
    if ([requestDict[@"type"] integerValue] == 1) {
        //点击的热度的筛选
        
    }else {
        //点击的是附近的人的筛选
        
        
    }
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return  self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYMakeFriendsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.headBt addTarget:self action:@selector(goToTheOtherHomePageClickAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.headBt.tag = indexPath.row + 100;
    cell.isHot = self.isHot;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}

- (void)goToTheOtherHomePageClickAction:(UIButton *)button {
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataArray[button.tag - 100].userId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    zkHomelModel * model = self.dataArray[indexPath.row];
    
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = model.userId;
    [self.navigationController pushViewController:vc animated:YES];
    
//    if (model.friends) {
//          [self gotoCharWithOtherHuanXinID:model.huanxin andOtherUserId:model.userId andOtherNickName:model.nickName andOtherImg:model.avatar andVC:self];
//    }else {
//        QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.userId = model.userId;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
  

    
}
@end
