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
    [self acquireDataFromServe];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[].mutableCopy;
    
    self.navigationItem.title = @"我的银行卡";
    
    UIButton * newClickUpAndInsideBT=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    [newClickUpAndInsideBT setTitle:@"添加银行卡" forState:UIControlStateNormal];
    newClickUpAndInsideBT.titleLabel.font = kFont(14);
    [newClickUpAndInsideBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newClickUpAndInsideBT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    newClickUpAndInsideBT.tag = 11;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:newClickUpAndInsideBT];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYYingHangKaCell" bundle:nil] forCellReuseIdentifier:@"cell"];

 
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];

    
    
}

- (void)acquireDataFromServe {
 
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool getMyBankCardListURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    

    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool deleteMyBankCardURL] parameters:self.dataArray[indexPath.row].bankCardId success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)leftOrRightClickAction:(UIButton *)button {
    QQYYAddYinHangKaVC * vc =[[QQYYAddYinHangKaVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.sendCarBlock != nil) {
        self.sendCarBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
