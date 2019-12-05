//
//  kkJieSuanVC.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/19.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "kkJieSuanVC.h"
#import "YJAddressTVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface kkJieSuanVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property(nonatomic,strong)NSMutableDictionary *payDic;

@end

@implementation kkJieSuanVC
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
    self.navigationItem.title = @"结算";
    self.payDic = @{}.mutableCopy;
}

- (IBAction)conAction:(UIButton *)button {
    if (self.titleLB.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    
    CGFloat money = 0;
    for (YJHomeModel * model in self.itemArr) {
        money = money + model.price * model.number;
    }
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    if (button.tag == 101) {
        requestDict[@"payType"] = @(4);
    }else {
        requestDict[@"payType"] = @(3);
    }
    requestDict[@"amount"] = @(money);
    requestDict[@"title"] = @"购物清单";
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
        
   
        
    }];
    
    
    
}

- (void)setdata {

        NSString * str = @"";
        for (int i = 0 ; i < self.itemArr.count; i++) {
            if (i == 0) {
                str =  [NSString stringWithFormat:@"(ID = %ld and goodId = '%@')",self.itemArr[i].ID,self.itemArr[i].goodId];
            }else {
                str = [str stringByAppendingString: [NSString stringWithFormat:@" or (ID = %ld and goodId ='%@')",self.itemArr[i].ID,self.itemArr[i].goodId]];
            }
        }
        //        NSString * sql =  [NSString stringWithFormat:@"delete from kk_mygoodscar where %@",str];
        NSString * sql =  [NSString stringWithFormat:@"update kk_mygoodscar set status = 1 where %@",str];
        
        FMDatabase * db =[AAAAFMDBSignle shareFMDB].fd;
        if ([db open]) {
            BOOL delete = [db executeUpdate:sql ];
            if (delete) {
                [SVProgressHUD showSuccessWithStatus:@"订单提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else {
                NSLog(@"%@",@"失败");
            }
            
        }
        [db close];
        


    
}


//- (void)gouAction:(UIButton *)button  {
//
//            NSMutableDictionary * requestDict = @{}.mutableCopy;
//            if (button.tag == 101) {
//                requestDict[@"payType"] = @(4);
//            }else {
//                requestDict[@"payType"] = @(3);
//            }
//            requestDict[@"amount"] = @(self.model.price);
//            requestDict[@"title"] = self.model.name;
//            [SVProgressHUD show];
//            [QQYYRequestTool networkingPOST:[QQYYURLDefineTool cccOrderURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
//                [SVProgressHUD dismiss];
//                if ([responseObject[@"code"] intValue]== 0) {
//
//                    if (button.tag == 101) {
//                        //支付宝
//                        self.payDic = responseObject[@"object"];
//    //                    [self goZFB];
//
//                    }else {
//                        //微信
//                        self.payDic = responseObject[@"object"];
//    //                    [self goWXpay];
//                    }
//
//
//                }else {
//                    [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
//                }
//
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//                [self.tableView.mj_header endRefreshing];
//                [self.tableView.mj_footer endRefreshing];
//
//            }];
//
//}

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
            
            [self setdata];
            
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
                
                [self setdata];
                
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




- (IBAction)addressaction:(id)sender {
    
    YJAddressTVC * vc =[[YJAddressTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    typeof(self) weakSelf = self;
    vc.sendAddressBlock = ^(YJHomeModel * _Nonnull model) {
        weakSelf.titleLB.text =  [NSString stringWithFormat:@"姓名:%@  %@,",model.name,model.phone];
        weakSelf.addressLB.text =  [NSString stringWithFormat:@"%@",model.address];
    };
    [self.navigationController pushViewController:vc  animated:YES];
    
}



@end
