//
//  QQYYQuanZiGuiZeListTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYQuanZiGuiZeListTVC.h"
#import "QQYYTongYongTwoCell.h"
@interface QQYYQuanZiGuiZeListTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end

@implementation QQYYQuanZiGuiZeListTVC

- (NSMutableArray<QQYYTongYongModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"圈子列表";
    self.titleArr = @[@"我的动态",@"交友日志",@"故事分享",@"互动问答",@"图片社",@"型男学院",@"闺蜜圈",@"版务"];
    [self.tableView registerClass:[QQYYTongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];
}

- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getSysSocialCircleListURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArray = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];

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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYTongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.TF.placeholder = @"";
    cell.leftLB.text = self.dataArray[indexPath.row].name;
    cell.moreImgV.hidden = self.isFaTie;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isFaTie) {
        if (self.typeBlock != nil) {
            self.typeBlock(self.dataArray[indexPath.row].ID ,self.dataArray[indexPath.row].name);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }
    
}


@end
