//
//  QQYYPrivacyTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYPrivacyTVC.h"
#import "QQYYTongYongTwoCell.h"
#import "zkJuBaoView.h"
#import "QQYYPrivacyPassWordVC.h"

@interface QQYYPrivacyTVC ()<zkJuBaoViewDelegate>
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSString *fuJinStr,*hotStr,*manyouStr;
@property(nonatomic,assign)NSInteger fuJin,hot,manyou;
@end

@implementation QQYYPrivacyTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"隐私设置";
    [self.tableView registerClass:[QQYYTongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.titleArr = @[@"附近的人",@"热度榜",@"自动漫游聊天记录",@"设置隐私密码"];
    
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];

    UIButton * clickBt=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    
    //    [clickBt setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [clickBt setTitle:@"完成" forState:UIControlStateNormal];
    clickBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    clickBt.titleLabel.font = kFont(14);
    [clickBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickBt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    clickBt.tag = 11;
    //    [self.view addSubview:clickBt];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clickBt];
    
}

- (void)leftOrRightClickAction:(UIButton *)button {
    
    [self updatePrivacy];
}

- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getUserConfigURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.hot = [[NSString stringWithFormat:@"%@",responseObject[@"object"][@"showHeat"]] integerValue];;
            self.fuJin = [[NSString stringWithFormat:@"%@",responseObject[@"object"][@"showNearby"]] integerValue];;
            
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
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 0;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYTongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.titleArr[indexPath.row];
    cell.clipsToBounds = YES;
    cell.TF.placeholder = @"";
    if (indexPath.row == 3) {
        if ([YWUnlockView haveGesturePassword]) {
            cell.TF.text = @"已开启";
        }else {
            cell.TF.text = @"去设置";
        }
    }else if (indexPath.row == 0) {
        if (self.fuJin) {
            cell.TF.text = @"出现";
        }else {
            cell.TF.text = @"不出现";
        }
    }else if (indexPath.row == 1) {
        if (self.hot) {
            cell.TF.text = @"出现";
        }else {
            cell.TF.text = @"不出现";
        }
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < 2) {
        
        [zkJuBaoView showWithArray:@[@"出现",@"不出现"] withIndexPath:indexPath];
        [zkJuBaoView shareInstance].delegate = self;
        
    }else if (indexPath.row == 2) {
        [zkJuBaoView showWithArray:@[@"加载",@"不加载"] withIndexPath:indexPath];
        [zkJuBaoView shareInstance].delegate = self;
    }else {
        //设置隐私密码
        
        if ([YWUnlockView haveGesturePassword]) {
            [zkJuBaoView showWithArray:@[@"重置",@"关闭"] withIndexPath:indexPath];
            [zkJuBaoView shareInstance].delegate = self;
        }else {
            QQYYPrivacyPassWordVC * vc =[[QQYYPrivacyPassWordVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
       
        
    }
    
    
    
    
}

#pragma mark ----- 点击内容 ----- 
- (void)didSelectAtIndex:(NSInteger )index withIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        if (index == 0) {
            QQYYPrivacyPassWordVC * vc =[[QQYYPrivacyPassWordVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 1){
            [YWUnlockView deleteGesturesPassword];
        }
        
        
    }else if (indexPath.row == 2) {
        
    }else if (indexPath.row == 1) {
        if (index == 0) {
            self.hot = 1;
            self.hotStr = @"出现";
        }else {
            self.hot = 0;
            self.hotStr = @"不出现";
        }
    }else  if (indexPath.row == 0){
        if (index == 0) {
            self.fuJin = 1;
            self.fuJinStr = @"出现";
        }else {
            self.fuJin = 0;
            self.fuJinStr = @"不出现";
        }
        
    }
    
    [self.tableView reloadData];
    
}


- (void)updatePrivacy {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"showHeat"] = @(self.hot);
    dict[@"showNearby"] = @(self.fuJin);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool updateUserConfigURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            [SVProgressHUD showSuccessWithStatus:@"修改隐私成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


@end
