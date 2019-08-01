//
//  QQYYYinHangKaTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYYinHangKaTVC.h"
#import "QQYYAddYinHangKaVC.h"
#import "QQYYYingHangKaCell.h"
@interface QQYYYinHangKaTVC ()
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end

@implementation QQYYYinHangKaTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[].mutableCopy;
    
    self.navigationItem.title = @"我的银行卡";
    
    UIButton * rightbtn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    [rightbtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    rightbtn.titleLabel.font = kFont(14);
    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.tag = 11;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYYingHangKaCell" bundle:nil] forCellReuseIdentifier:@"cell"];

 
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];

    
    
}

- (void)getData {
 
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getMyBankCardListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArray = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
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
    

    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool deleteMyBankCardURL] parameters:self.dataArray[indexPath.row].bankCardId success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            
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


- (void)navBtnClick:(UIButton *)button {
    QQYYAddYinHangKaVC * vc =[[QQYYAddYinHangKaVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYYingHangKaCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    QQYYTongYongModel * model = self.dataArray[indexPath.row];
    NSString * str = model.cardNo;
    if (model.cardNo.length > 4) {
        str = [model.cardNo substringWithRange:NSMakeRange(model.cardNo.length - 4, 4)];
    }
    cell.titleLB.text = [NSString stringWithFormat:@"%@   尾号%@",model.bankName,str];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.sendCarBlock != nil) {
        self.sendCarBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
        
    
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
