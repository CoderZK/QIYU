//
//  QQYYXingQuBiaoQianTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYXingQuBiaoQianTVC.h"

@interface QQYYXingQuBiaoQianTVC ()
@property(nonatomic,strong)UIView *headViewNew;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *arrayDataNew;
@end

@implementation QQYYXingQuBiaoQianTVC

- (NSMutableArray<QQYYTongYongModel *> *)arrayDataNew {
    if (_arrayDataNew == nil) {
        _arrayDataNew = [NSMutableArray array];
    }
    return _arrayDataNew;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我感兴趣的标签";
    self.headViewNew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    self.headViewNew.backgroundColor = WhiteColor;
    UILabel * LBLBLBLBLB =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 20)];
    LBLBLBLBLB.textColor = CharacterBlack40;
    LBLBLBLBLB.font = kFont(14);
    LBLBLBLBLB.text = @"选择标签,作为个人兴趣爱好标识";
    UIButton * newClickUpAndInsideBT=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    [newClickUpAndInsideBT setTitle:@"完成" forState:UIControlStateNormal];
    newClickUpAndInsideBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    newClickUpAndInsideBT.titleLabel.font = kFont(14);
    [newClickUpAndInsideBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newClickUpAndInsideBT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    newClickUpAndInsideBT.tag = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:newClickUpAndInsideBT];
    [self acquireDataFromServe];
}




- (void)xiugGAIActionWithTagIds:(NSString *)tagIds withtagsNmae:(NSString *)tags WithArr:(NSArray *)arr{
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"tags"] = tagIds;
    //    requestDict[@""]
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool updateMyInfoURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
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
        UIButton * newProductBTBT = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) , 40  + (spaceY + hh) * (i/4), ww, hh)];
        [newProductBTBT setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        [newProductBTBT setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
        newProductBTBT.tag = i+1000;
        newProductBTBT.titleLabel.font = kFont(14);
        newProductBTBT.layer.cornerRadius = 4;
        newProductBTBT.clipsToBounds = YES;
        [newProductBTBT setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
        [newProductBTBT setTitleColor:WhiteColor forState:UIControlStateSelected];
        [newProductBTBT setTitle:arr[i].name forState:UIControlStateNormal];
        [self.headViewNew addSubview:newProductBTBT];
        [newProductBTBT addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i+1 == arr.count) {
            self.headViewNew.mj_h = 20 + newProductBTBT.mj_y + hh;
        }
        if ([tagsArr containsObject:arr[i].ID]){
            newProductBTBT.selected = YES;
            self.arrayDataNew[i].isSelect = YES;
        }
    }
    self.tableView.tableHeaderView = self.headViewNew;
}

- (void)leftOrRightClickAction:(UIButton *)newProductBTBT {
    NSMutableArray * arr = @[].mutableCopy;
    NSMutableArray * arr1 = @[].mutableCopy;
    NSMutableArray * arr2 = @[].mutableCopy;
    for (int i = 0 ; i < self.arrayDataNew.count; i++) {
        UIButton * newProductBTBT = (UIButton *)[self.headViewNew viewWithTag:1000+i];
        if (newProductBTBT.selected) {
            
            [arr addObject:self.arrayDataNew[i]];
            [arr1 addObject:self.arrayDataNew[i].name];
            [arr2 addObject:self.arrayDataNew[i].ID];
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

- (void)acquireDataFromServe {
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool getLabelsURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            self.arrayDataNew = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self setBiaoQianWithArr:self.arrayDataNew];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)LLJJWithData:(int)index{
    for (int i = 0 ; i < index; i++) {
        int m = i /3 * 38 + arc4random() % 9;
        if (m % 7 == 0) {
            m++;
        }
    }
}

- (void)selectAction:(UIButton *)newProductBTBT  {
    newProductBTBT.selected = !newProductBTBT.selected;
}

- (void)LLLJJJ {
    [self LLJJWithData:63];
}





@end
