//
//  QQYYFriendsSearchTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYFriendsSearchTVC.h"
#import "QQYYMakeFriendsCell.h"
#import "QQYYSearchHeadView.h"
#import "QQYYSerachShowView.h"

@interface QQYYFriendsSearchTVC ()<QQYYSearchHeadViewDelegate,QQYYSerachShowViewDelegate>
@property(nonatomic,strong)QQYYSearchHeadView *searchV;
@property(nonatomic,strong)QQYYSerachShowView *showView;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *qianMingArr;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray *genderArr,*marriageArr,*cityIdArr,*tagsArr,*genderNameArr,*marriagerNameArr,*cityNameArr,*tagsNameArr;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *addressArr;
@property(nonatomic,strong)NSString *proviceId,*proviceName;
@property(nonatomic,strong)UIView *selectView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *clearBt;

@end

@implementation QQYYFriendsSearchTVC

- (UIView *)selectView {
    if (_selectView == nil) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchV.frame), ScreenW, 50)];
//        _selectView.backgroundColor = [UIColor redColor];
        _clearBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 15 - 45   , 7.5, 45, 35)];
        [_clearBt setTitle:@"清空" forState:UIControlStateNormal];
        _clearBt.layer.cornerRadius = 3;
        _clearBt.clipsToBounds = YES;
        _clearBt.layer.borderColor = CharacterBlackColor.CGColor;
        _clearBt.layer.borderWidth = 0.6;
        _clearBt.titleLabel.font = kFont(12);
        [_clearBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        [_selectView addSubview:_clearBt];
        _selectView.hidden = YES;
        [_clearBt addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 75, 50)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
        [_selectView addSubview:_scrollView];
    }
    return _selectView;
}

- (QQYYSerachShowView *)showView {
    if (_showView == nil) {
        _showView = [[QQYYSerachShowView  alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44 + 50 , ScreenW, ScreenH - (sstatusHeight + 44 + 50))];
        _showView.delegate = self;
    }
    return _showView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView:) name:@"DAIBAN" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.showView diss];
    
}

- (void)changeView:(NSNotification *)noti {
    
    NSDictionary * dict = noti.userInfo;
    if ([dict[@"type"] integerValue] == 1) {
        //点击的热度的筛选
        
    }else {
        //点击的是附近的人的筛选
        
        
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.qianMingArr =  @[].mutableCopy;
    self.addressArr = @[].mutableCopy;
    self.dataArray = @[].mutableCopy;
    [self.tableView registerClass:[QQYYMakeFriendsCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.frame = CGRectMake(0,  50 , ScreenW, ScreenH - (50));
//    if (self.isHot) {
//        self.navigationItem.title = @"筛选热度榜";
//    }else {
//        self.navigationItem.title = @"筛选附近的人";
//    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.searchV = [[QQYYSearchHeadView alloc] initWithFrame:CGRectMake(15, 0 , ScreenW - 30 , 50)];
    self.searchV.delegate = self;
    [self.view addSubview:self.searchV];
    [self.view addSubview:self.selectView];
    
    [self getQianMingData];
    [self getProvinceListData];
    self.pageNo = 1;
    [self getData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self getData];
        [self getQianMingData];
        [self getProvinceListData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getData];
    }];
    
  
}

- (void)getData {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNo);
    NSString * url = [QQYYURLDefineTool nearbyUserListURL];
    if (self.isHot) {
        url = [QQYYURLDefineTool heatUserListURL];
    }else {
        if ([zkSignleTool shareTool].latitude > 0) {
            dict[@"latitude"] = @([zkSignleTool shareTool].latitude);
            dict[@"longitude"] = @([zkSignleTool shareTool].longitude);
        }
    }
    if (self.genderArr.count > 0) {
         dict[@"gender"] = [self.genderArr componentsJoinedByString:@","];
    }
    if (self.marriageArr.count > 0) {
        dict[@"marriageStatus"] = [self.marriageArr componentsJoinedByString:@","];
    }
    if (self.cityIdArr.count > 0) {
        dict[@"cityId"] = [self.cityIdArr componentsJoinedByString:@","];
    }
    if (self.tagsArr.count > 0) {
        dict[@"tags"] = [self.tagsArr componentsJoinedByString:@","];
    }
    if (self.proviceId) {
        dict[@"provinceId"] = self.proviceId;
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.headBt.tag = indexPath.row + 100;
    cell.isHot = self.isHot;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}

- (void)gotoZhuYeAction:(UIButton *)button {
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
    
//    [self gotoCharWithOtherHuanXinID:model.huanxin andOtherUserId:model.userId andOtherNickName:model.nickName andOtherImg:model.avatar andVC:self];
    
}

#pragma mark ----- 点击上面四个筛选按钮的事件
- (void)didClickIndex:(NSInteger)index withIsShow:(BOOL)isShow{
    
    NSLog(@"%d",isShow);
    if (isShow) {

        self.showView.type = index;
        
        if (index == 0) {
            self.showView.sexSelectArr = self.genderArr;
            self.showView.dataArray = @[@"男",@"女"].mutableCopy;
            
        }else if (index == 1) {
            self.showView.biaoQianSelectArr = self.tagsArr;
            self.showView.dataArray = self.qianMingArr;
            
        }else if (index == 2) {
            self.showView.citySelectArr = self.cityIdArr;
            self.showView.proviceID = self.proviceId;
            
            self.showView.dataArray = self.addressArr;
            
            
        }else if (index == 3) {
            self.showView.marrSelectArr = self.marriageArr;
            self.showView.dataArray = @[@"单身",@"已婚",@"保密"].mutableCopy;
            
        }
        if (self.genderArr.count > 0 || self.cityIdArr.count > 0 || self.proviceId.length > 0 || self.marriageArr.count > 0 || self.tagsArr.count > 0) {
            self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50 + 50 , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
            self.tableView.frame = CGRectMake(0,  50 + 50, ScreenW, ScreenH - (50+50)- (sstatusHeight + 44 ));
            self.selectView.hidden = NO;
        }else {
            self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50  , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
            self.tableView.frame = CGRectMake(0,  50 , ScreenW, ScreenH - (50) - (sstatusHeight + 44 ));
            self.selectView.hidden = YES;
        }
         [self.showView show];
        

    }else {
        [self.showView diss];
    }
    
}


- (void)getQianMingData {
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getLabelsURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            self.qianMingArr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

//获取省份
- (void)getProvinceListData {
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool provinceListURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            
            self.addressArr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

#pragma mark ----- 点击筛选的确定----
- (void)didIsClickConfrimBt:(BOOL)isConfirm withType:(NSInteger)type andSelectArr:(NSArray *)selectArr andSelectNameArr:(nonnull NSArray *)nameArr proviceId:(nonnull NSString *)proviceId proviceName:(nonnull NSString *)proviceName{
    
    if (!isConfirm) {
        [self.searchV cancel];
        return;
    }
    if (type == 0) {
        self.genderArr = selectArr.mutableCopy;
        self.genderNameArr = nameArr.mutableCopy;
    }else if (type == 1) {
        self.tagsArr = selectArr.mutableCopy;
        self.tagsNameArr = nameArr.mutableCopy;
    }else if (type == 2) {
        self.cityIdArr = selectArr.mutableCopy;
        self.cityNameArr = nameArr.mutableCopy;
        self.proviceId = proviceId;
        self.proviceName = proviceName;
    }else if (type == 3) {
        self.marriageArr = selectArr.mutableCopy;
        self.marriagerNameArr = nameArr.mutableCopy;
    }

    if (self.genderArr.count > 0 || self.cityIdArr.count > 0 || self.proviceId.length > 0 || self.marriageArr.count > 0 || self.tagsArr.count > 0) {
        self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50 + 50 , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
        self.tableView.frame = CGRectMake(0,  50 + 50, ScreenW, ScreenH - (50+50)- (sstatusHeight + 44 ));
        self.selectView.hidden = NO;
    }else {
        self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50  , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
        self.tableView.frame = CGRectMake(0,  50 , ScreenW, ScreenH - (50) - (sstatusHeight + 44 ));
        self.selectView.hidden = YES;
    }
    [self.searchV cancel];
    [self addSubView];
    self.pageNo = 1;
    [self getData];
    
}

//点击清空
- (void)clearAction:(UIButton *)button {
    
    self.genderNameArr = self.genderArr = self.tagsNameArr = self.tagsArr = self.cityNameArr = self.cityIdArr = self.marriagerNameArr = self.marriageArr = @[].mutableCopy;
    self.proviceId = nil;
    self.proviceName = nil;
    if (self.genderArr.count > 0 || self.cityIdArr.count > 0 || self.proviceId.length > 0 || self.marriageArr.count > 0 || self.tagsArr.count > 0) {
        self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50 + 50 , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
        self.tableView.frame = CGRectMake(0,  50 + 50, ScreenW, ScreenH - (50+50)- (sstatusHeight + 44 ));
        
        self.selectView.hidden = NO;
    }else {
        self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50  , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
        self.tableView.frame = CGRectMake(0,  50 , ScreenW, ScreenH - (50) - (sstatusHeight + 44 ));
       
        self.selectView.hidden = YES;
    }
    [self.searchV cancel];
    self.pageNo = 1;
    [self getData];
    
    
}


- (void)addSubView {
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat x1 = 0;
    CGFloat space = 8;

    for (int i = 0 ; i < 4 ; i++) {
        UIView * vv = [[UIView alloc] initWithFrame:CGRectMake(x1, 0, 0, 50)];
        vv.tag = 200+i;
        CGFloat xnei = 0;
        NSMutableArray * nameArr = @[].mutableCopy;
        if (i == 0) {
            nameArr = self.genderNameArr;
        }else if (i == 1) {
            nameArr = self.tagsNameArr;
        }else if (i == 2) {
          
            nameArr = self.cityNameArr.mutableCopy;
            if (self.proviceName != nil) {
                [nameArr insertObject:self.proviceName atIndex:0];
            }
        }else {
            nameArr = self.marriagerNameArr;
        }
        
        for (int j = 0 ; j < nameArr.count ; j++) {
            
            CGFloat ww = [nameArr[j] getWidhtWithFontSize:13];
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(xnei, 10, ww+50, 30)];
            [vv addSubview:view];
            view.backgroundColor = [UIColor whiteColor];
            UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ww, 30)];
            [view addSubview:lb];
            lb.textColor = CharacterBlackColor;
            lb.font = kFont(13);
            lb.text = nameArr[j];
            [view addSubview:lb];
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb.frame) + 10, 5, 20, 20)];
            [button addTarget:self action:@selector(colseAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 100+j;
            [view addSubview:button];
            [button setImage:[UIImage imageNamed:@"100"] forState:UIControlStateNormal];
            
            xnei = CGRectGetMaxX(view.frame) + space;
            if (j+1 == [nameArr count]) {
                vv.mj_w = CGRectGetMaxX(view.frame);
                x1 = CGRectGetMaxX(vv.frame) + space;
                NSLog(@"%@",NSStringFromCGRect(vv.frame));

            }
            
        }
        [self.scrollView addSubview:vv];
        
        if (i == 3) {
            _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(vv.frame), 50);
        }
        
    }
    
    
    
    
}

- (void)colseAction:(UIButton *)button {
    

    
    UIView * view =[[button superview] superview];
    NSInteger tagSup = view.tag-200;
    NSInteger tagNei = button.tag - 100;
    if (tagSup == 0) {
        [self.genderArr removeObjectAtIndex:tagNei];
        [self.genderNameArr removeObjectAtIndex:tagNei];
    }else if (tagSup == 1) {
        [self.tagsArr removeObjectAtIndex:tagNei];
        [self.tagsNameArr removeObjectAtIndex:tagNei];
    }else if (tagSup == 2) {
        if (tagNei == 0) {
            [self.cityNameArr removeAllObjects];
            [self.cityIdArr removeAllObjects];
            self.proviceName = self.proviceId = nil;
        }else {
            [self.cityIdArr removeObjectAtIndex:tagNei-1];
            [self.cityNameArr removeObjectAtIndex:tagNei-1];
        }

        
    }else if (tagSup == 3) {
        
        [self.marriageArr removeObjectAtIndex:tagNei];
        [self.marriagerNameArr removeObjectAtIndex:tagNei];
    }
    
    if (self.genderArr.count > 0 || self.cityIdArr.count > 0 || self.proviceId.length > 0 || self.marriageArr.count > 0 || self.tagsArr.count > 0) {
        self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50 + 50 , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
        self.tableView.frame = CGRectMake(0,  50 + 50, ScreenW, ScreenH - (50+50)- (sstatusHeight + 44 ));
    
        self.selectView.hidden = NO;
    }else {
        self.showView.frame = CGRectMake(0, sstatusHeight + 44 + 50  , ScreenW, ScreenH - (sstatusHeight + 44 + 50));
        self.tableView.frame = CGRectMake(0,  50 , ScreenW, ScreenH - (50) - (sstatusHeight + 44 ));
      
        self.selectView.hidden = YES;
    }
    [self.showView diss];
    [self.searchV cancel];
    [self addSubView];
    self.pageNo = 1;
    [self getData];
    
}


@end
