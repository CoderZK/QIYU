//
//  QQYYXingQuBiaoQianTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYXingQuBiaoQianTVC.h"

@interface QQYYXingQuBiaoQianTVC ()
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end

@implementation QQYYXingQuBiaoQianTVC

- (NSMutableArray<QQYYTongYongModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我感兴趣的标签";
    
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    self.headV.backgroundColor = WhiteColor;
    
    UILabel * LB =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 20)];
    LB.textColor = CharacterBlack40;
    LB.font = kFont(14);
    LB.text = @"选择标签,作为个人兴趣爱好标识";
    
    UIButton * clickBt=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    [clickBt setTitle:@"完成" forState:UIControlStateNormal];
    clickBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    clickBt.titleLabel.font = kFont(14);
    [clickBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickBt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    clickBt.tag = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clickBt];
    
    
    [self acquireDataFromServe];
}


- (void)leftOrRightClickAction:(UIButton *)button {
    
    NSMutableArray * arr = @[].mutableCopy;
    NSMutableArray * arr1 = @[].mutableCopy;
    NSMutableArray * arr2 = @[].mutableCopy;
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        UIButton * button = (UIButton *)[self.headV viewWithTag:1000+i];
        if (button.selected) {
            
            [arr addObject:self.dataArray[i]];
            [arr1 addObject:self.dataArray[i].name];
            [arr2 addObject:self.dataArray[i].ID];
        }
    }

    if (arr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择至少一个标签"];
        return;
    }
    
    
    if (self.isZhuYe) {
         [self xiugGAIActionWithTagIds:[arr2 componentsJoinedByString:@","] withtagsNmae:[arr1 componentsJoinedByString:@","] WithArr:arr];
    }else {
        if (self.sendBiaoQianBlock != nil) {
            self.sendBiaoQianBlock(arr, [arr1 componentsJoinedByString:@","], [arr2 componentsJoinedByString:@","]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
   
    
   
    
    
}

- (void)xiugGAIActionWithTagIds:(NSString *)tagIds withtagsNmae:(NSString *)tags WithArr:(NSArray *)arr{
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"tags"] = tagIds;
    //    dict[@""]
    [zkRequestTool networkingPOST:[QQYYURLDefineTool updateMyInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (self.sendBiaoQianBlock != nil) {
                self.sendBiaoQianBlock(arr, tags, tagIds);
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


- (void)setBiaoQianWithArr:(NSArray<QQYYTongYongModel *> *)arr {

    
    NSArray * tagsArr = [self.tagsID componentsSeparatedByString:@","];
    
    
    CGFloat spaceX  = 10;
    CGFloat spaceY  = 15;
    CGFloat ww = (ScreenW - 30 - 3 * spaceX) / 4;
    CGFloat hh = 35;
    for (int i = 0;i< arr.count; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) , 40  + (spaceY + hh) * (i/4), ww, hh)];
        [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
        button.tag = i+1000;
        button.titleLabel.font = kFont(14);
        button.layer.cornerRadius = 4;
        button.clipsToBounds = YES;
        [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
        [button setTitleColor:WhiteColor forState:UIControlStateSelected];
        [button setTitle:arr[i].name forState:UIControlStateNormal];
        [self.headV addSubview:button];
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i+1 == arr.count) {
            self.headV.mj_h = 20 + button.mj_y + hh;
        }
        if ([tagsArr containsObject:arr[i].ID]){
            button.selected = YES;
            self.dataArray[i].isSelect = YES;
        }
        
        
    }
    
    
    self.tableView.tableHeaderView = self.headV;
}


- (void)acquireDataFromServe {
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getLabelsURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            self.dataArray = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self setBiaoQianWithArr:self.dataArray];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}


- (void)selectAction:(UIButton *)button  {
    button.selected = !button.selected;
}


@end
