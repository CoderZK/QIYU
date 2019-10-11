//
//  QQYYGouWuDetailTVC.m
//  QIYU
//
//  Created by zk on 2019/9/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYGouWuDetailTVC.h"
@interface QQYYGouWuDetailTVC ()
@property(nonatomic,strong)UIView *headV,*footV;
@property(nonatomic,strong)UILabel *numberLB;
@end

@implementation QQYYGouWuDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /2)];
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /2)];
    [self.headV addSubview:imgV];
        imgV.image =[UIImage imageNamed: [NSString stringWithFormat:@"%@",self.model.imgStr]];
    self.tableView.tableHeaderView = self.headV;

    self.tableView.estimatedRowHeight = 100;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setFootVNew];
    
    
    
}

- (void)setFootVNew {
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 60 - sstatusHeight -44, ScreenW, 60)];
    self.footV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 60)];
    [button1 setTitle:@"微信" forState:UIControlStateNormal];
    [button1 setTitleColor:CharacterBlack40 forState: UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"zhifu_1"] forState:UIControlStateNormal];
    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    button1.tag =100;
    [button1 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2, 0, ScreenW/2, 60)];
    [button2 setTitle:@"支付宝" forState:UIControlStateNormal];
    [button2 setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"zhifu_0"] forState:UIControlStateNormal];
    [button2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    button2.tag =101;
    [button2 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.footV addSubview:button1];
    [self.footV addSubview:button2];
    
    [self.view addSubview:self.footV];
    
    
}

- (void)action:(UIButton *)button {
    
    UIAlertController * alerVC =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"本产品是预付款的线上付款,线下交易,您付钱后将会有专门的人员联系您,进行商品确认和发货" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alerVC addAction:action1];
    [alerVC addAction:action2];
    
    [self presentViewController:alerVC animated:YES completion:nil];
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

        if (indexPath.row == 0) {
            cell.textLabel.text =  [NSString stringWithFormat:@"￥%.2f",self.model.price];
            cell.textLabel.textColor = [UIColor redColor];
        }else {
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = self.model.desTwo;
        }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





@end
