//
//  YJGouWuChe.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/12.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "YJGouWuChe.h"
#import "YJHomeModel.h"
#import "kkMyCarCell.h"
#import "kkJieSuanVC.h"
@interface YJGouWuChe ()
/**  */
@property(nonatomic , strong)NSMutableArray<YJHomeModel *> *dataArray;
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)UILabel *allmoneyLB;
@property(nonatomic , strong)UIButton *jieSuanBt;
@property(nonatomic , assign)CGFloat allMoney;
@property(nonatomic , strong)NSMutableArray<YJHomeModel *> *itemArr;
@end

@implementation YJGouWuChe

-(NSMutableArray<YJHomeModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的购物车";
    [self.tableView registerNib:[UINib nibWithNibName:@"kkMyCarCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    
    [self createFootV];
}

- (void)createFootV {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 60 - sstatusHeight - 44, ScreenW, 60)];
    self.footV.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.footV];
    
    self.allmoneyLB =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, ScreenW - 20 - 80, 20)];
    self.allmoneyLB.font = kFont(14);
    self.allmoneyLB.textColor = TabberGreen;
    self.allmoneyLB.text =  [NSString stringWithFormat:@"总共:%@",@"0"];
    [self.footV addSubview:self.allmoneyLB];
    
    
    self.jieSuanBt =[UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBt.backgroundColor = TabberGreen;
    self.jieSuanBt.frame = CGRectMake(ScreenW - 90, 15, 80, 30);
    [self.jieSuanBt setTitle:@"结算" forState:UIControlStateNormal];
    self.jieSuanBt.layer.cornerRadius = 4;
    self.jieSuanBt.clipsToBounds = YES;
    [self.footV addSubview:self.jieSuanBt];
    [self.jieSuanBt addTarget:self action:@selector(qiangdanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)qiangdanAction:(UIButton *)button {
    
    if (self.itemArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"至少要选择一个商品"];
        return;
    }
    
    kkJieSuanVC * vc =[[kkJieSuanVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.itemArr = self.itemArr;
    [self.navigationController pushViewController:vc  animated:YES];
    
}

- (void)getData {
    
    NSString * sql = [NSString stringWithFormat:@"select *from kk_mygoodscar where userName = '%@' and status = 0",[QQYYSignleToolNew shareTool].session_uid];
    
    FMDatabase * db = [AAAAFMDBSignle shareFMDB].fd;
    if ([db open]) {
        FMResultSet * result = [db executeQuery:sql];
        [self.dataArray removeAllObjects];
        while ([result next]) {
            
            YJHomeModel * model = [[YJHomeModel alloc] init];
            model.ID = [result intForColumn:@"ID"];
            model.goodId = [result stringForColumn:@"goodId"];
            model.title = [result stringForColumn:@"des"];
            model.number = [result intForColumn:@"number"];
            model.price = [result doubleForColumn:@"price"];
            model.img = [result stringForColumn:@"shangpinurl"];
            [self.dataArray addObject:model];
        }
    }
    [db close];
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kkMyCarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = self.dataArray[indexPath.row].title;
    cell.contentLB.text = self.dataArray[indexPath.row].des;
    cell.moneyLB.text =  [NSString stringWithFormat:@"￥%.2f",self.dataArray[indexPath.row].price];
    if (self.dataArray[indexPath.row].isSelect) {
        [cell.bt setBackgroundImage:[UIImage imageNamed:@"80"] forState:UIControlStateNormal];
    }else {
        [cell.bt setBackgroundImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
    }
    cell.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row].img]];
    cell.numberLB.text =  [NSString stringWithFormat:@"数量:%ld",self.dataArray[indexPath.row].number];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.dataArray[indexPath.row].isSelect = !self.dataArray[indexPath.row].isSelect;
    [self updateFootV];
    [self.tableView reloadData];
    
}

- (void)updateFootV {
    CGFloat allmoey = 0;
    NSMutableArray<YJHomeModel *> * arr = @[].mutableCopy;
    for (YJHomeModel * model  in self.dataArray) {
        if (model.isSelect) {
            allmoey = allmoey + model.price * model.number;
            [arr addObject:model];
        }
    }
    self.allMoney = allmoey;
    self.itemArr = arr;
    self.allmoneyLB.text =  [NSString stringWithFormat:@"总价:%.2f",self.allMoney];
}

@end
