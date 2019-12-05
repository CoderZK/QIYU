//
//  kkMineGouWuListTVC.m
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/20.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "kkMineGouWuListTVC.h"
#import "YJHomeModel.h"
#import "kkMyCarCell.h"
#import "YJGoodDetailTVC.h"
#import "QQYYGouWuDetailTVC.h"
#import "AAAAModel.h"
@interface kkMineGouWuListTVC ()
@property(nonatomic , strong)NSMutableArray<YJHomeModel *> *dataArray;
@end

@implementation kkMineGouWuListTVC

-(NSMutableArray<YJHomeModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的购物记录";
    [self.tableView registerNib:[UINib nibWithNibName:@"kkMyCarCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
   
    [self getData];
}

- (void)getData {
    
    NSString * sql = [NSString stringWithFormat:@"select *from kk_mygoodscar where userName = '%@' and status = 1",[QQYYSignleToolNew shareTool].session_uid];
    
    FMDatabase * db = [AAAAFMDBSignle shareFMDB].fd;
    if ([db open]) {
        FMResultSet * result = [db executeQuery:sql];
        [self.dataArray removeAllObjects];
        while ([result next]) {
            
            YJHomeModel * model = [[YJHomeModel alloc] init];
            model.ID = [result intForColumn:@"ID"];
            model.goodId = [result stringForColumn:@"goodId"];
            model.desTwo = [result stringForColumn:@"desTwo"];
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
    cell.btW.constant = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = self.dataArray[indexPath.row].title;
    cell.contentLB.text = self.dataArray[indexPath.row].des;
    cell.moneyLB.text =  [NSString stringWithFormat:@"￥%.2f",self.dataArray[indexPath.row].price];
    if (self.dataArray[indexPath.row].isSelect) {
        [cell.bt setBackgroundImage:[UIImage imageNamed:@"kk_xuanzhong"] forState:UIControlStateNormal];
    }else {
        [cell.bt setBackgroundImage:[UIImage imageNamed:@"kk_weixuanzhong"] forState:UIControlStateNormal];
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
    
    YJHomeModel * model = self.dataArray[indexPath.row];
    
    QQYYGouWuDetailTVC * vc =[[QQYYGouWuDetailTVC alloc] init];
    AAAAModel * modelTwo = [[AAAAModel alloc] init];
    
    modelTwo.id = model.ID;
    modelTwo.price = model.price;
    modelTwo.imgStr = model.img;
    modelTwo.status = model.status;
    modelTwo.des = model.des;
    modelTwo.desTwo = model.desTwo;
    vc.model = modelTwo;
    [self.navigationController pushViewController:vc animated:YES];
    

    
    
}



@end
