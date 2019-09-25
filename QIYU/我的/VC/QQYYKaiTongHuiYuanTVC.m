//
//  QQYYKaiTongHuiYuanTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYKaiTongHuiYuanTVC.h"
#import "QQYYZhiFuCell.h"
#import "QQYYHuiYuanOneCell.h"
#import "QQYYHuiYuanTwoCell.h"
#import "QQYYHuiYuanThreeCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface QQYYKaiTongHuiYuanTVC ()
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3;
@property(nonatomic,assign)NSInteger selectIndexZhiFu;
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@property (nonatomic,strong)NSDictionary *payDic;
@end

@implementation QQYYKaiTongHuiYuanTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBZFB:) name:@"ZFBPAY" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self initHeadV];
    [self initNav];
    
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];

}

- (void)initNav{
    
    UIButton * leftbtn=[[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2 , 40, 40)];
    [leftbtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.tag = 10;
    [self.view addSubview:leftbtn];

}

- (void)leftOrRightClickAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getVipPkgListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)initHeadV {
    UIView * headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, Kscale(192))];
    headView.backgroundColor  = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:headView.bounds];
    imgV.image = [UIImage imageNamed:@"96"];
    [headView addSubview:imgV];
    
    UILabel * titleLB  =[[UILabel alloc] initWithFrame:CGRectMake(60, sstatusHeight + 2 , ScreenW-120, 40)];
    titleLB.font =[UIFont systemFontOfSize:18];
    titleLB.textColor = WhiteColor;
    [headView addSubview:titleLB];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.text = @"会员服务";
    

    
    self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, (Kscale(192) - 70 )/2 ,70, 70)];
    self.headBt.layer.cornerRadius = 35;
    self.headBt.clipsToBounds = YES;
    [headView addSubview:self.headBt];
    [self.headBt sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.imgStr]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15 , CGRectGetMinY(self.headBt.frame) + 10, 150, 20)];
    lb.textColor = WhiteColor;
    lb.font = kFont(16);
    lb.text = self.nickName;
    lb.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:lb];
    self.LB1 = lb;
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15,CGRectGetMaxY(self.LB1.frame) + 5, ScreenW -CGRectGetMaxX(self.headBt.frame) -30, 40)];
    lb2.textColor = WhiteColor;
    lb2.font = kFont(14);
    lb2.text = @"立即开通会员,享受6大特权";
    lb2.textAlignment =  NSTextAlignmentLeft;
    [headView addSubview:lb2];
    self.LB2 = lb2;
    
    self.tableView.tableHeaderView = headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
        cell.titleLB.text = [NSString stringWithFormat:@"%@  %@ 元",self.dataArray[indexPath.row].name,self.dataArray[indexPath.row].price];
        cell.rightBt.tag = indexPath.row + 100;
        [cell.rightBt addTarget:self action:@selector(rightBtAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
  
    
}

- (void)rightBtAction:(UIButton *)button {
  
    QQYYTongYongModel * model = self.dataArray[button.tag - 100];
    NSMutableDictionary * dict = @{}.mutableCopy;
    if (self.selectIndexZhiFu == 0) {
        dict[@"payType"] = @(4);
    }else {
        dict[@"payType"] = @(3);
    }
    dict[@"pkgId"] = model.ID;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool vipReChargeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        if ([responseObject[@"code"] intValue]== 0) {
            
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
      
        
    }];
    
    
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
    
    req.partnerId = [NSString stringWithFormat:@"%@",self.payDic[@"partnerid"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.payDic[@"prepayid"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.payDic[@"noncestr"]];
    //注意此处是int 类型
    req.timeStamp = [self.payDic[@"timestamp"] intValue];
    req.package =  [NSString stringWithFormat:@"%@",self.payDic[@"package"]];
    req.sign =  [NSString stringWithFormat:@"%@",self.payDic[@"sign"]];
    
    //发起支付
    [WXApi sendReq:req];
    
}

//微信支付结果处理
- (void)WXWX:(NSNotification *)no {
    
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
    NSString *str;
    str = self.payDic[@"alipay"];
    
    [[AlipaySDK defaultService] payOrder:self.payDic[@"alipay"] fromScheme:@"com.cz001.binfenjiari" callback:^(NSDictionary *resultDic) {
        
        
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
- (void)ZFBZFB:(NSNotification *)notic {
    
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
