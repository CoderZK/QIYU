//
//  QQYYMineCollectTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMineCollectTVC.h"
#import "QQYYHomeDongTaiCell.h"
#import "QQYYYongBaoView.h"
@interface QQYYMineCollectTVC ()<QQYYHomeDongTaiCellDelegate,QQYYYongBaoViewDeletage>
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)QQYYYongBaoView *showView;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong)UIButton *backBt,*editBt;
@end

@implementation QQYYMineCollectTVC
- (NSMutableArray<zkHomelModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (QQYYYongBaoView *)showView {
    if (_showView == nil) {
        _showView = [[QQYYYongBaoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showView.deletage = self;
    }
    return _showView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [self.tableView registerClass:[QQYYHomeDongTaiCell class] forCellReuseIdentifier:@"cellFour"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    self.pageNo = 1;
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self acquireDataFromServe];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];
    
    
    UIButton * newClickUpAndInsideBT=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70 - 15,  sstatusHeight + 2,70, 40)];
    
    //    [newClickUpAndInsideBT setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [newClickUpAndInsideBT setTitle:@"编辑" forState:UIControlStateNormal];
    [newClickUpAndInsideBT setTitle:@"取消收藏" forState:UIControlStateSelected];
    [newClickUpAndInsideBT sizeToFit];
    newClickUpAndInsideBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    newClickUpAndInsideBT.titleLabel.font = kFont(14);
    [newClickUpAndInsideBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newClickUpAndInsideBT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    newClickUpAndInsideBT.tag = 11;
    self.editBt = newClickUpAndInsideBT;
    UIButton * clickBt1=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70 - 15,  sstatusHeight + 2,70, 40)];
    
    //    [newClickUpAndInsideBT setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [clickBt1 setTitle:@"返回" forState:UIControlStateNormal];
    clickBt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    clickBt1.titleLabel.font = kFont(14);
    [clickBt1 sizeToFit];
    [clickBt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickBt1 addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    clickBt1.tag = 12;
    self.backBt = clickBt1;
    self.backBt.hidden = YES;
    //    [self.view addSubview:newClickUpAndInsideBT];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.editBt],[[UIBarButtonItem alloc] initWithCustomView:self.backBt]];
    
}



- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    //    requestDict[@"tagId"] = @(self.tagId);
    requestDict[@"pageNo"] = @(self.pageNo);
    requestDict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getMyCollectionListURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
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
                self.editBt.hidden = YES;
            }else {
                self.editBt.hidden = NO;
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

- (void)leftOrRightClickAction:(UIButton *)button {
    
    if  (button.tag == 11) {
        button.selected = !button.selected;
        [self.editBt sizeToFit];
        self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.editBt],[[UIBarButtonItem alloc] initWithCustomView:self.backBt]];
        self.isEdit = button.selected;
        self.backBt.hidden = !button.selected;
        if (!button.selected) {
            //删除
            NSMutableArray * arr = @[].mutableCopy;
            for (zkHomelModel * model  in self.dataArray) {
                if (model.isSelect) {
                    
                    [arr addObject:model.postId];
                    
                }
            }
            
            if (arr.count > 0) {
                [self deleteWithIds:arr];
            }
            
        }
    }else {
        
        for (zkHomelModel * model  in self.dataArray) {
            model.isSelect = NO;
        }
        self.backBt.hidden = YES;
        self.isEdit = NO;
        self.editBt.selected = NO;
        
    }
    
    [self.tableView reloadData];
    
}

- (void)deleteWithIds:(NSArray *)arr{
    

    [zkRequestTool networkingPOST:[QQYYURLDefineTool deleteMyCollectionURL] parameters:[arr componentsJoinedByString:@","] success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            NSMutableArray * arrTwo = @[].mutableCopy;
            for (zkHomelModel * model  in self.dataArray) {
                if (!model.isSelect) {
                    [arrTwo addObject:model];
                }
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:arrTwo];
            if (self.dataArray.count == 0 ) {
                self.editBt.hidden = YES;
            }else {
                self.editBt.hidden = NO;
            }
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
    
    return self.dataArray[indexPath.row].cellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    QQYYHomeDongTaiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellFour" forIndexPath:indexPath];
    cell.cancelBt.hidden  = NO;
    cell.delegate = self;

    cell.isDelete = self.isEdit;
    
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QQYYDetailTVC * vc =[[QQYYDetailTVC alloc] init];
    vc.ID = self.dataArray[indexPath.row].postId;
    Weak(weakSelf);
    vc.sendZanYesOrNoBlock = ^(BOOL isZan, NSInteger number) {
        weakSelf.dataArray[indexPath.row].currentUserLike = isZan;
        weakSelf.dataArray[indexPath.row].likeNum = number;
        [weakSelf.tableView reloadData];
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark ------ 点击cell 内部的按钮 ----
//0 头像 1 查看,2 评论 3 赞 ,4喜欢,5分享 6 点击查看原文 7 取消收藏(或删除)
-(void)didClickButtonWithCell:(QQYYHomeDongTaiCell *)cell andIndex:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (index == 3) {
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self zanActionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
    }else if (index == 4) {
        if ([[zkSignleTool shareTool].session_uid isEqualToString:self.dataArray[indexPath.row].createBy]) {
            
            [SVProgressHUD showErrorWithStatus:@"自己不能对自己的帖子送爱豆"];
            return;
            
        }else {
            if (![zkSignleTool shareTool].isLogin) {
                [self gotoLoginVC];
                return;
            }
            if ([[zkSignleTool shareTool].session_uid isEqualToString:self.dataArray[indexPath.row].createBy]) {
                [SVProgressHUD showErrorWithStatus:@"自己不能给自己送爱豆"];
                return;
            }
            [self.showView showWithIndexPath:indexPath];
        }

    }else if (index == 5) {
        
    }else if (index == 0){
        QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = self.dataArray[indexPath.row].createBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 7) {
        
        [self collectionWithModel:nil  WithIndePath:indexPath];
    }
    
    
    
    
}

//收藏或者取消操作
- (void)collectionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool deleteMyCollectionURL] parameters:self.dataArray[indexPath.row].postId success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (model.currentUserCollect) {
                [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
            }
    
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
    
}


- (void)zanActionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    
  
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"postId"] = model.postId;
    requestDict[@"type"] = @"1";
    NSString * url = [QQYYURLDefineTool getlikeURL];
    if (model.currentUserLike) {
        url = [QQYYURLDefineTool notlikeURL];
    }
    [zkRequestTool networkingPOST:url parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            model.currentUserLike = !model.currentUserLike;
            if (model.currentUserLike) {
                model.likeNum = model.likeNum + 1;
            }else {
                model.likeNum = model.likeNum  - 1;
            }
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


#pragma  mark ---- 点击 抱一抱 的内容 ----
- (void)didClcikIndex:(NSInteger)index withIndexPath:(NSIndexPath *)indexPath WithNumber:(nonnull NSString *)str{
    
    if (index == 4) {
        [self.showView diss];
        QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        Weak(weakSelf);
        [self sendFlowerWithNumber:str andLinkId:self.dataArray[indexPath.row].postId andIsGiveUser:NO result:^(BOOL isOK) {
            if (isOK) {
                [SVProgressHUD showSuccessWithStatus:@"送爱豆成功!"];
                weakSelf.dataArray[indexPath.row].heat += [str integerValue];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            }
            
            
        }];
    }
    
}




@end
