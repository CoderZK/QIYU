//
//  QQYYHYFWTVC.m
//  QIYU
//
//  Created by zk on 2019/12/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHYFWTVC.h"
#import "QQYYZhiFuCell.h"
#import "QQYYHuiYuanOneCell.h"
#import "QQYYHuiYuanTwoCell.h"
#import "QQYYHuiYuanThreeCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface QQYYHYFWTVC ()
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3;
@property(nonatomic,assign)NSInteger selectIndexZhiFu;
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@property (nonatomic,strong)NSDictionary *payDic;
@end

@implementation QQYYHYFWTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXWXWXWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBZFBZFBZFB:) name:@"ZFBPAY" object:nil];
}


- (void)createBackNavigation{
    
    UILabel * labe =[[UILabel alloc] init];
    labe.font = kFont(14);
    UIButton * LeftOrRightBT=[[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2 , 40, 40)];
    [LeftOrRightBT setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [LeftOrRightBT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    LeftOrRightBT.tag = 10;
    [self.view addSubview:LeftOrRightBT];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.selectIndexZhiFu = 0;
    [self.tableView registerClass:[QQYYZhiFuCell class] forCellReuseIdentifier:@"cellZhiFu"];
    [self.tableView registerClass:[QQYYHuiYuanOneCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYHuiYuanTwoCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYHuiYuanThreeCell" bundle:nil] forCellReuseIdentifier:@"cellThree"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight);
    [self AddHeadView];
    [self createBackNavigation];
    
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];
}

- (void)leftOrRightClickAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)acquireDataFromServe {
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool getVipPkgListURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.dataArray = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (void)AddHeadView {
    UIView * NewHeadView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, Kscale(192))];
    NewHeadView.backgroundColor  = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:NewHeadView.bounds];
    imgV.image = [UIImage imageNamed:@"96"];
    [NewHeadView addSubview:imgV];
    UILabel * NameLB  =[[UILabel alloc] initWithFrame:CGRectMake(60, sstatusHeight + 2 , ScreenW-120, 40)];
    NameLB.font =[UIFont systemFontOfSize:18];
    NameLB.textColor = WhiteColor;
    [NewHeadView addSubview:NameLB];
    NameLB.textAlignment = NSTextAlignmentCenter;
    NameLB.text = @"会员服务";
    self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, (Kscale(192) - 70 )/2 ,70, 70)];
    self.headBt.layer.cornerRadius = 35;
    self.headBt.clipsToBounds = YES;
    [NewHeadView addSubview:self.headBt];
    [self.headBt sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.imgStr]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15 , CGRectGetMinY(self.headBt.frame) + 10, 150, 20)];
    lb.textColor = WhiteColor;
    lb.font = kFont(16);
    lb.text = self.nickName;
    lb.textAlignment = NSTextAlignmentLeft;
    [NewHeadView addSubview:lb];
    self.LB1 = lb;
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15,CGRectGetMaxY(self.LB1.frame) + 5, ScreenW -CGRectGetMaxX(self.headBt.frame) -30, 40)];
    lb2.textColor = WhiteColor;
    lb2.font = kFont(14);
    lb2.text = @"立即开通会员,享受6大特权";
    lb2.textAlignment =  NSTextAlignmentLeft;
    [NewHeadView addSubview:lb2];
    self.LB2 = lb2;
    self.tableView.tableHeaderView = NewHeadView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }else if (section == 2) {
        return 2;
    }else {
        
        return self.dataArray.count;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 230;
    }else if (indexPath.section == 1) {
        return 50;
    }else if (indexPath.section == 2) {
        return 70;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QQYYHuiYuanOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        QQYYHuiYuanTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2) {
        QQYYZhiFuCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellZhiFu" forIndexPath:indexPath];
        if (self.selectIndexZhiFu == indexPath.row) {
            cell.rightImgV.image = [UIImage imageNamed:@"80"];
        }else {
            cell.rightImgV.image = [UIImage imageNamed:@"78"];
        }
        if (indexPath.row == 0) {
            cell.titleLB.text = @"支付宝支付";
        }else {
            cell.titleLB.text = @"微信支付";
        }
        cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"zhifu_%ld",indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        QQYYHuiYuanThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellThree" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLB.text = [NSString stringWithFormat:@"%@  %0.2f 元",self.dataArray[indexPath.row].name,[self.dataArray[indexPath.row].price floatValue]];
        cell.rightBt.tag = indexPath.row + 100;
        [cell.rightBt addTarget:self action:@selector(clickRightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    
}




- (void)buzhidaoxieshaWithIndex:(int)index{
    
    for (int i = 0; i<index; i++) {
        int f = i*100+arc4random() % 8;
        if (f % 3 == 0) {
            NSLog(@"%d",f);
        }
    }
}

- (void)clickRightBtAction:(UIButton *)button {
    
    QQYYTongYongModel * model = self.dataArray[button.tag - 100];
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    if (self.selectIndexZhiFu == 0) {
        requestDict[@"payType"] = @(4);
    }else {
        requestDict[@"payType"] = @(3);
    }
    requestDict[@"pkgId"] = model.pkgId;
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool vipReChargeURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (self.selectIndexZhiFu == 0) {
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

- (void)shishiLaJiDaiMaDeXiaoGuo{
    [self buzhidaoxieshaWithIndex:500];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        self.selectIndexZhiFu = indexPath.row;
        [self.tableView reloadData];
        //        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
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
