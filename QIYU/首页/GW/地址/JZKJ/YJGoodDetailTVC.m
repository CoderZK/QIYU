//
//  YJGoodDetailTVC.m
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/13.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "YJGoodDetailTVC.h"

@interface YJGoodDetailTVC ()
@property(nonatomic,strong)UIView *headV,*footV;
@property(nonatomic,strong)UILabel *numberLB;
@end

@implementation YJGoodDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /2)];
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /2)];
    [self.headV addSubview:imgV];
    imgV.image =[UIImage imageNamed: [NSString stringWithFormat:@"k%ld",_index+1]];
    self.tableView.tableHeaderView = self.headV;
    
    [self setFootV];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (void)setFootV {
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 60 - sstatusHeight -44, ScreenW, 60)];
    self.footV.backgroundColor = [UIColor whiteColor];

    
    UIButton * bt1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
    [bt1 setImage:[UIImage imageNamed:@"yjjian"] forState:UIControlStateNormal];
    bt1.tag = 100;
    [bt1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footV addSubview:bt1];
    
    self.numberLB = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 60, 20)];
    self.numberLB.text = @"1";
    self.numberLB.textAlignment = NSTextAlignmentCenter;
    self.numberLB.font = [UIFont systemFontOfSize:14];
    [self.footV addSubview:self.numberLB];
    
    UIButton * bt2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 40, 40)];
    [bt2 setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    bt2.tag = 101;
    [bt2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footV addSubview:bt2];
    
    UIButton * bt3 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 85 , 10, 75, 40)];
    [bt3 setBackgroundColor:[UIColor redColor]];
    bt3.layer.cornerRadius = 4;
    bt3.clipsToBounds = YES;
    [bt3 setTitle:@"加入购物车" forState:UIControlStateNormal];
    bt3.titleLabel.font = [UIFont systemFontOfSize:14];
    bt3.tag = 102;
    [bt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt3 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footV addSubview:bt3];
    [self.view addSubview: self.footV];
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    
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
        cell.textLabel.text =  [NSString stringWithFormat:@"￥%.2f",_model.price];
        cell.textLabel.textColor = [UIColor redColor];
    }else {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = _model.desTwo;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)clickAction:(UIButton *)button {
    NSInteger number = [self.numberLB.text integerValue];
    if (button.tag == 100) {
        if (number > 1) {
            number--;
        }
        
        
    }else if (button.tag == 101) {
        number++;
    }else {
        if (![QQYYSignleToolNew shareTool].isLogin) {
            zkLoginVC * vc = [[zkLoginVC alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
            return;
        }
        NSString * sql = [NSString stringWithFormat:@"insert into kk_mygoodscar (userName,des,price,number,shangpinurl,goodId,desTwo) values ('%@','%@','%f','%ld','%@','%ld','%@')",[QQYYSignleToolNew shareTool].session_uid,self.model.des,self.model.price,(long)number,self.model.img,(long)self.model.ID,self.model.desTwo];
        FMDatabase * db =[AAAAFMDBSignle shareFMDB].fd;
        BOOL isOpen = [db open];
        if (isOpen) {
            BOOL insert = [db executeUpdate:sql];
            if (insert) {
                [SVProgressHUD showSuccessWithStatus:@"加入购物车成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
        }else {
            [SVProgressHUD showErrorWithStatus:@"数据库异常"];
        }
        
        [db close];
        
    }
    self.numberLB.text = [NSString stringWithFormat:@"%ld",(long)number];
    
}


@end
