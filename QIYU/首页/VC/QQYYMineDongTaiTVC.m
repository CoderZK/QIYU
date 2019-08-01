//
//  QQYYMineDongTaiTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMineDongTaiTVC.h"
#import "QQYYHomeDongTaiCell.h"
#import "QQYYGongGaoTVC.h"
@interface QQYYMineDongTaiTVC ()<QQYYHomeDongTaiCellDelegate,QQYYYongBaoViewDeletage>
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,strong)UIButton *leftBt;
@property(nonatomic,strong)UIButton *centerBt;
@property(nonatomic,strong)UIButton *rightBt,*desBt,*desTwobt;
@property(nonatomic,strong)UIView *headV,*headTwoView;
@property(nonatomic,strong)UILabel *desLB;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)QQYYYongBaoView *showView;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)BOOL isSubscribed;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong)UIButton *backBt,*editBt;



@end

@implementation QQYYMineDongTaiTVC

- (QQYYYongBaoView *)showView {
    if (_showView == nil) {
        _showView = [[QQYYYongBaoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showView.deletage = self;
    }
    return _showView;
}

- (NSMutableArray<zkHomelModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isMine) {
        [self getDetailData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[QQYYHomeDongTaiCell class] forCellReuseIdentifier:@"cellFour"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView reloadData];
    if (self.isMine) {
        self.navigationItem.title = @"我的动态";
         self.tableView.frame = CGRectMake(0,0, ScreenW, ScreenH);
        
        UIButton * rightbtn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70 - 15,  sstatusHeight + 2,70, 40)];
        
        //    [rightbtn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
        [rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
        [rightbtn setTitle:@"删除" forState:UIControlStateSelected];
        [rightbtn sizeToFit];
        rightbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        rightbtn.titleLabel.font = kFont(14);
        [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightbtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightbtn.tag = 11;
        self.editBt = rightbtn;
        UIButton * rightbtn1=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70 - 15,  sstatusHeight + 2,70, 40)];
        
        //    [rightbtn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
        [rightbtn1 setTitle:@"返回" forState:UIControlStateNormal];
        rightbtn1.hidden = YES;
        rightbtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        rightbtn1.titleLabel.font = kFont(14);
        [rightbtn1 sizeToFit];
        [rightbtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightbtn1 addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightbtn1.tag = 12;
        self.backBt = rightbtn1;
        //    [self.view addSubview:rightbtn];
        self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.editBt],[[UIBarButtonItem alloc] initWithCustomView:self.backBt]];
        
       
    }else {
        
         [self setheadV];
        self.navigationItem.title = self.titleStr;
         self.tableView.frame = CGRectMake(0, 50, ScreenW, ScreenH - 50);
    }
    
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

- (void)navBtnClick:(UIButton *)button {
    
    if  (button.tag == 11) {
        button.selected = !button.selected;
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
    
    

    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool deletePostURL] parameters:[arr componentsJoinedByString:@","] success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)setheadV{
    
    self.headTwoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.1)];
    self.headTwoView.backgroundColor = WhiteColor;
    [self.view addSubview:self.headTwoView];
    
    self.desLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 20)];
    self.desLB.numberOfLines = 0;
    self.desLB.font = kFont(13);
    self.desLB.textColor = CharacterBlackColor;
    [self.headTwoView addSubview:self.desLB];

    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desLB.frame), ScreenW, 50)];
    self.headV.backgroundColor = [UIColor whiteColor];
    [self.headTwoView addSubview:self.headV];
    self.headTwoView.mj_h = CGRectGetMaxY(self.headV.frame);
    
    self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 50, 40)];
    self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.leftBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.leftBt setTitle:@"热门" forState:UIControlStateNormal];
    [self.leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.leftBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.leftBt.titleLabel.font = kFont(15);
    self.leftBt.selected = YES;
    self.leftBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
    [self.headV addSubview:self.leftBt];
    self.leftBt.tag = 0;
    [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.centerBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  55, 0, 50, 40)];
    self.centerBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.centerBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.centerBt setTitle:@"最新" forState:UIControlStateNormal];
    [self.centerBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.centerBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.centerBt.titleLabel.font = kFont(15);
    [self.headV addSubview:self.centerBt];
    self.centerBt.tag = 1;
    [self.centerBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  110 , 0, 50, 40)];
    self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.rightBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.rightBt setTitle:@"关注" forState:UIControlStateNormal];
    [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.rightBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.rightBt.titleLabel.font = kFont(15);
    [self.headV addSubview:self.rightBt];
    self.rightBt.tag = 2;
    [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.desBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [self.desBt setImage: [UIImage imageNamed:@"21"] forState:UIControlStateNormal];
//    self.desBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.desBt.tag = 3;
//    [self.desBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.desTwobt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
//    [self.desTwobt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
//    [self.desTwobt setTitle:@"取消关注" forState:UIControlStateNormal];
//    self.desTwobt.titleLabel.font = kFont(14);
//    self.desTwobt.tag = 4;
//    [self.desTwobt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithCustomView:self.desTwobt];
//    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithCustomView:self.desBt];
//    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
}


- (void)getData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    //    dict[@"tagId"] = @(self.tagId);
    dict[@"pageNo"] = @(self.pageNo);
    dict[@"pageSize"] = @(10);
    if (self.isMine) {
        dict[@"createBy"] = [zkSignleTool shareTool].session_uid;
    }else {
        dict[@"circleId"] = self.circleId;
        if (self.type == 0){
            dict[@"orderBy"] = @(2);
        }else if (self.type == 1) {
            dict[@"orderBy"] = @(1);
        }else if (self.type == 2){
            dict[@"subscribed"] = @(1);
        }
    }
   
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getsearchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
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
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}



- (void)clickAction:(UIButton *)button {
    
    if (button.tag != 2) {
      self.type = button.tag;
    }
    if (button.tag == 0) {
        
        self.leftBt.selected = YES;
        self.leftBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.rightBt.selected = NO;
        self.rightBt.titleLabel.font = kFont(15);
        
        
    }else if (button.tag == 1) {
        self.centerBt.selected = YES;
        self.centerBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
        self.rightBt.selected = NO;
        self.rightBt.titleLabel.font = kFont(15);
    }else if (button.tag == 2) {
        
        if (![zkSignleTool shareTool].isLogin){
            [self gotoLoginVC];
            return ;
        }
        self.type = button.tag;
        self.rightBt.selected = YES;
        self.rightBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
    }else if (button.tag == 3) {
       //介绍
        QQYYGongGaoTVC * vc =[[QQYYGongGaoTVC alloc] init];
        vc.cricleID = self.circleId;
        vc.cricleName = self.titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }else if (button.tag == 4) {
        //关注
        if (![zkSignleTool shareTool].isLogin){
            [self gotoLoginVC];
            return ;
        }
        [self guanZhuAction];
        return;
        
    }
    self.pageNo = 1;
    [self getData];
    
}

- (void)guanZhuAction{
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"2";
    dict[@"userId"] = self.circleId;
    NSString * url = [QQYYURLDefineTool addUserSubscribeURL];
    if (self.isSubscribed) {
        url = [QQYYURLDefineTool deleteUserSubscribeURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.isSubscribed = !self.isSubscribed;
            if (self.isSubscribed) {
                [self.desTwobt setTitle:@"取消关注" forState:UIControlStateNormal];
                self.desTwobt.mj_w = 60;
            }else {
                [self.desTwobt setTitle:@"关注" forState:UIControlStateNormal];
                self.desTwobt.mj_w = 30;
            }
            
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
    cell.delegate = self;
    
    if (self.isMine) {
        cell.isDelete = self.isEdit;
    }
    
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
//0 头像 1 查看,2 评论 3 赞 ,4送花,5分享 6 点击查看原文
-(void)didClickButtonWithCell:(QQYYHomeDongTaiCell *)cell andIndex:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (index == 0) {
        QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = self.dataArray[indexPath.row].createBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1) {
        
    }else if (index == 2) {
        
        
        
    }else if (index == 3) {
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self zanActionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
        
    }else if (index == 4) {
        
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        if ([[zkSignleTool shareTool].session_uid isEqualToString:self.dataArray[indexPath.row].createBy]) {
            [SVProgressHUD showErrorWithStatus:@"自己不能给自己送爱豆"];
            return;
        }
        [self.showView showWithIndexPath:indexPath];
        
    }else if (index == 5) {
        
        [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)] withUrl:@"123" shareModel:nil];
        
    }else if (index == 6) {
        
    }else if (index == 7) {
        
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self collectionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
    }
    
    
    
    
}

- (void)zanActionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{

    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"postId"] = model.postId;
    dict[@"type"] = @"1";
    NSString * url = [QQYYURLDefineTool getlikeURL];
    if (model.currentUserLike) {
        url = [QQYYURLDefineTool notlikeURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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

//收藏或者取消操作
- (void)collectionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"targetId"] = self.dataArray[indexPath.row].postId;
    dict[@"type"] = @"2";
    NSString * url = [QQYYURLDefineTool addMyCollectionURL];
    if (model.currentUserCollect) {
        url = [QQYYURLDefineTool deleteMyCollectionURL];
        [zkRequestTool networkingPOST:url parameters:self.dataArray[indexPath.row].postId success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }else {
        [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }
    
    
    
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

- (void)getDetailData {
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getSysSocialCircleDetailURL] parameters:self.circleId success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            NSString * str  = [NSString stringWithFormat:@"%@",responseObject[@"object"][@"subscribed"]];
            NSString *profile =  [NSString stringWithFormat:@"圈子说明: %@",responseObject[@"object"][@"profile"]];
            self.desLB.attributedText = [profile getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterBlackColor];
            self.desLB.mj_h = [profile getHeigtWithFontSize:13 lineSpace:3 width:ScreenW- 30];
            self.headV.mj_y = CGRectGetMaxY(self.desLB.frame);
            self.headTwoView.mj_h = CGRectGetMaxY(self.headV.frame);
            
             self.tableView.frame = CGRectMake(0, self.headTwoView.mj_h , ScreenW, ScreenH - self.headTwoView.mj_h - (sstatusHeight +44));
            
//            if ([str isEqualToString:@"0"]) {
//                self.isSubscribed = NO;
//            }else {
//                self.isSubscribed = YES;
//            }
//
//            if (self.isSubscribed) {
//                [self.desTwobt setTitle:@"取消关注" forState:UIControlStateNormal];
//                self.desTwobt.mj_w = 60;
//            }else {
//                [self.desTwobt setTitle:@"关注" forState:UIControlStateNormal];
//                self.desTwobt.mj_w = 30;
//            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}



@end

