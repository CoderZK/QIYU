//
//  QQYYMineFriendsTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMineFriendsTVC.h"
#import "QQYYMineFriendsCell.h"
@interface QQYYMineFriendsTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,strong)UIButton *searchBt;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
//@property(nonatomic,strong)zkHomelModel *dataModel;
@property(nonatomic,assign)BOOL isSearch;
@end

@implementation QQYYMineFriendsTVC

- (NSMutableArray<zkHomelModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.tableView registerClass:[QQYYMineFriendsCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.type == 0) {
        self.navigationItem.title = @"我的朋友";
        [self createHeadView];
    }else if (self.type ==1) {
        if (![[zkSignleTool shareTool].huanxin isEqualToString:self.userNo]) {
            self.navigationItem.title = @"他/她的关注";
        }else {
             self.navigationItem.title = @"我的关注";
        }
    }else if(self.type == 2){
        if (![[zkSignleTool shareTool].huanxin isEqualToString:self.userNo]) {
           self.navigationItem.title = @"他/她的粉丝";
        }else {
           self.navigationItem.title = @"我的粉丝";
        }
        
    }else if (self.type == 3) {
        self.navigationItem.title = @"谁看过我";
    }else if (self.type == 4) {
        self.navigationItem.title = @"我的黑名单";
    }else if (self.type == 5) {
        self.navigationItem.title = @"添加好友";
        [self createHeadView];
    }
    
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
    dict[@"pageNo"] = @(self.pageNo);
    dict[@"pageSize"] = @(10);
  
    NSString * url = @"";
    if (self.type == 0) {
        url = [QQYYURLDefineTool getMyFriendUserListURL];
    }else if (self.type ==1) {
        url = [QQYYURLDefineTool getMySubscribeUserListURL];
        dict[@"userNo"] = self.userNo;
    }else if(self.type == 2){
        url = [QQYYURLDefineTool getMyFansUserListURL];
        dict[@"userNo"] = self.userNo;
    }else if (self.type == 3) {
        url = [QQYYURLDefineTool getMyVisitorListURL];
    }else if (self.type == 4) {
        url = [QQYYURLDefineTool getMyUserFriendBlackListURL];
    }else if (self.type == 5) {
        return;
    }
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (self.isSearch) {
                [self.dataArray removeAllObjects];
            }
            
            self.isSearch = NO;
            NSArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
            if (self.pageNo == 1 ) {
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


//查找添加好友
- (void)getNewFriendByUserNo {
 
    if (self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入你要找的好友ID"];
        return;
    }
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"userNo"] = self.TF.text;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getNewFriendByUserNoURL] parameters:self.TF.text success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.isSearch = YES;
            zkHomelModel * model  = [zkHomelModel mj_objectWithKeyValues:responseObject[@"object"]];
            [self.dataArray removeAllObjects];
            [self.dataArray addObject:model];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)createHeadView {
 
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 90)];
    self.headView.backgroundColor = WhiteColor;
    
    UIView * grayView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, ScreenW- 30, 50)];
    grayView.backgroundColor = BackgroundColor;
    grayView.layer.cornerRadius = 25;
    grayView.clipsToBounds = YES;
    [self.headView addSubview:grayView];
    
    self.TF = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, ScreenW - 30 - 40 - 40, 30)];
    self.TF.placeholder = @"请输入对方ID";
    self.TF.font = kFont(15);
    self.TF.returnKeyType = UIReturnKeySearch;
    self.TF.delegate = self;
    [self.TF  setTintColor:CharacterRedColor];
    [grayView addSubview:self.TF];
    
    self.searchBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 30 - 40 , 5, 40, 40)];
    [self.searchBt setImage:[UIImage imageNamed:@"53"] forState:UIControlStateNormal];
    [self.searchBt addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [grayView addSubview:self.searchBt];
    
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenW, 10)];
    lineV.backgroundColor =BackgroundColor;
    [self.headView addSubview:lineV];
    
    self.tableView.tableHeaderView = self.headView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYMineFriendsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.headBt.tag = indexPath.row + 100;
    [cell.guanZhuBt addTarget:self action:@selector(cancelGuanZhu:) forControlEvents:UIControlEventTouchUpInside];
    cell.guanZhuBt.tag = indexPath.row + 100;
    zkHomelModel * model = self.dataArray[indexPath.row];
    if (self.type == 3) {
        model.avatar = model.createAvatar;
        model.nickName = model.createNickName;
        model.tags = model.tagsName;
        model.province= model.provinceName;
        model.city = model.cityName;
    }
    cell.type = self.type;
    if (![self.userNo isEqualToString:[zkSignleTool shareTool].huanxin]) {
        if (self.type == 1 || self.type == 2) {
            cell.guanZhuBt.hidden = cell.xinImgV.hidden = cell.typeLB.hidden = YES;
        }
    }
    cell.model = model;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  
        
    zkHomelModel * model = self.dataArray[indexPath.row];
    
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = model.userId;
    [self.navigationController pushViewController:vc animated:YES];
    
//    if (model.friends) {
//        
//        [self gotoCharWithOtherHuanXinID:model.huanxin andOtherUserId:model.userId andOtherNickName:model.nickName andOtherImg:model.avatar andVC:self];
//        
//
//    }else {
//        QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.userId = model.userId;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    
  
    


}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (self.type == 0 || self.type == 4) {
        return YES;
    }
    return NO;

}

//// 定义编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        UITableViewRowAction * action1 = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除好友" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self deleteMesgWithIndexPath:indexPath withIsDeletefriends:1];
        }];
        action1.backgroundColor =[UIColor redColor];
        
        UITableViewRowAction * action2 = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"拉黑好友" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            [self deleteMesgWithIndexPath:indexPath withIsDeletefriends:2];
            
        }];
        action2.backgroundColor =[UIColor grayColor];
        
        return @[action1,action2];
    }else {
        UITableViewRowAction * action2 = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"解除黑名单" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            [self deleteMesgWithIndexPath:indexPath withIsDeletefriends:3];
            
        }];
        action2.backgroundColor =[UIColor grayColor];
        return @[action2];
    }
    return nil;
    
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (self.type == 0) {
//        return @"解除好友";
//    }
//    return @"删除好友";
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self deleteMesgWithIndexPath:indexPath];
//    }
//
//}

- (void)deleteMesgWithIndexPath:(NSIndexPath *)indexPath withIsDeletefriends:(NSInteger )type {
    // type 1 删除 2 拉黑 3 解除
    Weak(weakSelf);

    
    NSString * url = @"";
    
    if (type == 1) {
        url = [QQYYURLDefineTool deleteFriendURL];
    }else if (type == 2) {
        url = [QQYYURLDefineTool addUserFriendBlackURL];
    } else if (type == 3) {
        url = [QQYYURLDefineTool deleteUserFriendBlackURL];
    }
   
    zkHomelModel * model = self.dataArray[indexPath.row];
    
    [zkRequestTool networkingPOST:url parameters:model.userId success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (type == 3) {
                
                [[EMClient sharedClient].contactManager removeUserFromBlackList:model.huanxin];
                
            }else {
                [[EMClient sharedClient].contactManager addUserToBlackList:model.huanxin relationshipBoth:YES];
                
            }
            
            
            [self.dataArray removeObject:model];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}


//去主页
- (void)gotoZhuYeAction:(UIButton *)button {
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataArray[button.tag - 100].userId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)cancelGuanZhu:(UIButton *)button {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"1";
    dict[@"userId"] = self.dataArray[button.tag - 100].userId;
    NSString * url = [QQYYURLDefineTool deleteUserSubscribeURL];
    if (self.type == 2) {
        if (!self.dataArray[button.tag - 100].subscribed) {
            url =  [QQYYURLDefineTool addUserSubscribeURL];
        }
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            
            if (self.type ==1) {
                // @"关注";
                [self.dataArray removeObjectAtIndex:button.tag-100];
                [self.tableView reloadData];
            }else if(self.type == 2){
                // @"粉丝";
                self.dataArray[button.tag - 100].subscribed = !self.dataArray[button.tag - 100].subscribed;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag - 100 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
            }else if (self.type == 3) {
                // @"谁看过我";
                self.dataArray[button.tag - 100].subscribed = !self.dataArray[button.tag - 100].subscribed;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag - 100 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
            }else if (self.type == 4) {
                // @"我的黑名单";
            }else if (self.type == 5) {
                ///@"添加好友";
            
            }
         
           
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

//点击搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self getNewFriendByUserNo];
    return YES;
}

- (void)searchAction {
    [self getNewFriendByUserNo];
}


@end
