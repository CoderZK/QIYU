//
//  QQYYAddFriendsTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYAddFriendsTVC.h"
#import "QQYYMineFriendsCell.h"
@interface QQYYAddFriendsTVC ()
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)IQTextView *TV;

@end

@implementation QQYYAddFriendsTVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友申请";
    [self.tableView registerClass:[QQYYMineFriendsCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [self initfootV];
    
}

- (void)initfootV {
 
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 240)];
    
    
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(15, 0, ScreenW-30, 150)];
    self.TV.placeholder = @"说点什么吧~";
    self.TV.font = kFont(14);
    self.TV.backgroundColor = RGB(245, 245, 245);
    [self.footView addSubview:self.TV];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 200, ScreenW - 30, 45);
    [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 22.5;
    button.clipsToBounds = YES;
    [self.footView addSubview:button];
    [button addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = self.footView;
}

- (void)send {
    
    EMError *error = [[EMClient sharedClient].contactManager addContact:self.model.userNo message:self.TV.text];
    if (!error) {
        NSLog(@"添加成功");
    }
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"remark"] = [NSString emojiConvert:self.TV.text];
    dict[@"userNo"] = self.model.userNo;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool addNewFriendURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            [SVProgressHUD showSuccessWithStatus:@"添加好友请求成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
            
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYMineFriendsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.guanZhuBt.hidden = cell.typeLB.hidden = cell.xinImgV.hidden = YES;
    self.model.tags = self.model.tagsName;
    cell.model = self.model;
    cell.contentLB.text = [NSString stringWithFormat:@"%@-%@",self.model.provinceName,self.model.cityName];;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
