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
    
//    [self setFootVNew];
    
    [self setFootV];
    
    
}

//- (void)setFootVNew {
//
//    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 60 - sstatusHeight -44, ScreenW, 60 )];
//    self.footV.backgroundColor = [UIColor groupTableViewBackgroundColor];
//
//    UIView * payV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
//    [self.footV addSubview:payV];
//
//    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 60)];
//    [button1 setTitle:@"微信" forState:UIControlStateNormal];
//    [button1 setTitleColor:CharacterBlack40 forState: UIControlStateNormal];
//    [button1 setImage:[UIImage imageNamed:@"zhifu_1"] forState:UIControlStateNormal];
//    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
//    button1.tag =100;
//    [button1 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2, 0, ScreenW/2, 60)];
//    [button2 setTitle:@"支付宝" forState:UIControlStateNormal];
//    [button2 setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
//    [button2 setImage:[UIImage imageNamed:@"zhifu_0"] forState:UIControlStateNormal];
//    [button2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
//    button2.tag =101;
//    [button2 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
//
//    [payV addSubview:button1];
//    [payV addSubview:button2];
//
//    [self.view addSubview:self.footV];
//
//
//}

- (void)setFootV {
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 60 - sstatusHeight -44, ScreenW, 60)];
    self.footV.backgroundColor = [UIColor whiteColor];

    
    UIButton * bt1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
    [bt1 setImage:[UIImage imageNamed:@"gjian"] forState:UIControlStateNormal];
    bt1.tag = 100;
    [bt1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footV addSubview:bt1];
    
    self.numberLB = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 60, 20)];
    self.numberLB.text = @"1";
    self.numberLB.textAlignment = NSTextAlignmentCenter;
    self.numberLB.font = [UIFont systemFontOfSize:14];
    [self.footV addSubview:self.numberLB];
    
    UIButton * bt2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 40, 40)];
    [bt2 setImage:[UIImage imageNamed:@"gjia"] forState:UIControlStateNormal];
    bt2.tag = 101;
    [bt2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footV addSubview:bt2];
    
    UIButton * bt3 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 85 , 10, 75, 40)];
    [bt3 setBackgroundColor:TabberGreen];
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
            [self gotoLoginVC];
            
            return;
        }
        NSString * sql = [NSString stringWithFormat:@"insert into kk_mygoodscar (userName,des,price,number,shangpinurl,goodId,desTwo) values ('%@','%@','%f','%ld','%@','%ld','%@')",[QQYYSignleToolNew shareTool].session_uid,self.model.des,self.model.price,(long)number,self.model.imgStr,(long)self.model.id,self.model.desTwo];
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




- (void)action:(UIButton *)button {

  
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
//                    [self goZFB];

                }else {
                    //微信
                    self.payDic = responseObject[@"object"];
//                    [self goWXpay];
                }


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
