//
//  QQYYHuaTiTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHuaTiTVC.h"

@interface QQYYHuaTiTVC ()
@property(nonatomic,strong)UIView *whiteView,*headV;
@property(nonatomic,strong)NSMutableArray *selectArr;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end

@implementation QQYYHuaTiTVC

- (NSMutableArray<QQYYTongYongModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectArr = @[].mutableCopy;

    UIButton * rightbtn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    
    //    [rightbtn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [rightbtn setTitle:@"完成" forState:UIControlStateNormal];
    rightbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightbtn.titleLabel.font = kFont(14);
    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.tag = 11;
    //    [self.view addSubview:rightbtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    self.navigationItem.title = @"话题";
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.headV.backgroundColor = WhiteColor;
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 20)];
    lb.font = kFont(13);
    lb.text = @"请选择和您话题相关的话题, 若无相关科选自其它分类";
    [self.headV addSubview:lb];
    self.whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lb.frame) + 10 , ScreenW, 20)];

    [self.headV addSubview:self.whiteView];
    
//    [self setHuaTiWithArr:@[@"女王范",@"参赛活动",@"实力了",@"道具",@"自拍",@"玩法",@"故事",@"运动",@"面积",@"其它"]];
    
 
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];

    
    
}

- (void)getData {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getTopicListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArray = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self setHuaTiWithArr:self.dataArray];
            [self.selectArr removeAllObjects];

            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    

    
    
}

- (void)navBtnClick:(UIButton *)button {
    
    if (self.htBlock != nil) {
        self.htBlock(self.selectArr);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)setHuaTiWithArr:(NSArray<QQYYTongYongModel *> *)arr {
  
    
    CGFloat XX = 15;
    CGFloat totalW = XX;
    NSInteger number = 1;
    CGFloat btH = 30;
    CGFloat spaceW = 10;
    CGFloat spaceH = 10;
    CGFloat btY0 = 0;
    
    [self.whiteView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0 ; i < arr.count; i++) {
        
        UIButton * button = (UIButton *)[self.whiteView viewWithTag:100+i];
        
        if (button==nil) {
            button =[UIButton new];
        }
        
        // button.hidden = YES;
        button.tag = 100+i;
        [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];

        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        
        [button addTarget:self action:@selector(clickNameAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString * str = [NSString stringWithFormat:@"%@",arr[i].name];
        [button setTitleColor:WhiteColor forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        [button setTitle:str forState:UIControlStateNormal];
        CGFloat width =[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
        
        button.x = totalW;
        button.y = btY0+(number-1) *(btH+spaceH);
        button.height =btH;
        button.width = width+30;
        totalW = button.x + button.width + spaceW;
        
        if(totalW  > ScreenW - 30) {
            totalW = XX;
            number +=1;
            button.x =totalW;
            button.y =btY0+ (number-1) *(btH + spaceH);
            button.height = btH;
            button.width = width+30;
            totalW = button.x + button.width + spaceW;
        }
        if (i+1 == arr.count ) {
            self.whiteView.height = CGRectGetMaxY(button.frame);
        }
        [self.whiteView addSubview:button];
        
    }
    self.headV.mj_h = self.whiteView.mj_h + 60;
    
    self.tableView.tableHeaderView = self.headV;
    
}

- (void)clickNameAction:(UIButton *)button {
    
    if (button.selected) {
        button.selected = NO;
        for (QQYYTongYongModel * model   in self.selectArr) {
            if (model.ID == self.dataArray[button.tag - 100].ID) {
                [self.selectArr removeObject:self.dataArray[button.tag - 100]];
                return;
            }
        }
       
    }else {
        if (self.selectArr.count >=3) {
            [SVProgressHUD showErrorWithStatus:@"最多只能选择三个"];
            return;
        }else {
            button.selected = YES;
            if (![self.selectArr containsObject:self.dataArray[button.tag - 100]]) {
                 [self.selectArr addObject:self.dataArray[button.tag - 100]];
            }
        }
       
        
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
