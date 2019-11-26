//
//  QQYYGouWuDetailTVC.m
//  QIYU
//
//  Created by zk on 2019/9/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYGouWuDetailTVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface QQYYGouWuDetailTVC ()
@property(nonatomic,strong)UIView *headV,*footV;
@property(nonatomic,strong)UILabel *numberLB;
@property (nonatomic,strong)NSDictionary *payDic;
@end

@implementation QQYYGouWuDetailTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXWXWXWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBZFBZFBZFB:) name:@"ZFBPAY" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.payDic = @{};
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
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"购买" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSMutableDictionary * requestDict = @{}.mutableCopy;
        if (button.tag == 101) {
            requestDict[@"payType"] = @(4);
        }else {
            requestDict[@"payType"] = @(3);
        }
        requestDict[@"amount"] = @(self.model.price);
        requestDict[@"title"] = self.model.name;
        [SVProgressHUD show];
        [QQYYRequestTool networkingPOST:[QQYYURLDefineTool cccOrderURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD dismiss];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (button.tag == 101) {
                    //支付宝
                    self.payDic = responseObject[@"object"];
                    [self goZFB];
                    
                }else {
                    //微信
                    self.payDic = responseObject[@"object"];
                    [self goWXpay];
                }
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
        
        
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


#pragma mark -微信、支付宝支付
- (void)goWXpay {
    
    
    
    PayReq * req = [[PayReq alloc]init];
    
    //    /** 商家向财付通申请的商家id */
    //    @property (nonatomic, retain) NSString *partnerId;
    //    /** 预支付订单 */
    //    @property (nonatomic, retain) NSString *prepayId;
    //    /** 随机串，防重发 */
    //    @property (nonatomic, retain) NSString *nonceStr;
    //    /** 时间戳，防重发 */
    //    @property (nonatomic, assign) UInt32 timeStamp;
    //    /** 商家根据财付通文档填写的数据和签名 */
    //    @property (nonatomic, retain) NSString *package;
    //    /** 商家根据微信开放平台文档对数据做的签名 */
    //    @property (nonatomic, retain) NSString *sign;
    
    req.partnerId = [NSString stringWithFormat:@"%@",self.payDic[@"partnerId"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.payDic[@"prepayId"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.payDic[@"nonceStr"]];
    //注意此处是int 类型
    req.timeStamp = [self.payDic[@"timeStamp"] intValue];
    req.package =  [NSString stringWithFormat:@"%@",self.payDic[@"package"]];
    req.sign =  [NSString stringWithFormat:@"%@",self.payDic[@"sign"]];
    
    //发起支付
    [WXApi sendReq:req];
    
}

//微信支付结果处理
- (void)WXWXWXWX:(NSNotification *)no {
    
    BaseResp * resp = no.object;
    if (resp.errCode==WXSuccess)
    {
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //            zkBaoMingChengGongVC * vc =[[zkBaoMingChengGongVC alloc] init];
            //            vc.isHuoDong = YES;
            //            vc.ID = self.ID;
            //            [self.navigationController pushViewController:vc animated:YES];
            
        });
        
    }
    else if (resp.errCode==WXErrCodeUserCancel)
    {
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}



//支付宝支付结果处理
- (void)goZFB{
    
    
    [[AlipaySDK defaultService] payOrder:self.payDic[@"prepayId"] fromScheme:@"com.yiqu.app" callback:^(NSDictionary *resultDic) {
        
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
            //用户取消支付
            [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
            
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //                zkBaoMingChengGongVC * vc =[[zkBaoMingChengGongVC alloc] init];
                //                vc.isHuoDong = YES;
                //                vc.ID = self.ID;
                //                [self.navigationController pushViewController:vc animated:YES];
                
            });
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
        
        NSLog(@"-----------%@",resultDic);
        
        NSLog(@"==========成功");
        
        
    }];
    
    
}


//支付宝支付结果处理,此处是app 被杀死之后用的
- (void)ZFBZFBZFBZFB:(NSNotification *)notic {
    
    NSDictionary *resultDic = notic.object;
    
    if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
        //用户取消支付
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        
    } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            zkBaoMingChengGongVC * vc =[[zkBaoMingChengGongVC alloc] init];
            //            vc.isHuoDong = YES;
            //            vc.ID = self.ID;
            //            [self.navigationController pushViewController:vc animated:YES];
        });
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
    NSLog(@"%@",resultDic);
    NSLog(@"成功");
    //
}





@end
