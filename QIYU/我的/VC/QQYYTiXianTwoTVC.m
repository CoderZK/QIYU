//
//  QQYYTiXianTwoTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYTiXianTwoTVC.h"
#import "QQYYTiXianJiLuTVC.h"
#import "QQYYYinHangKaTVC.h"
@interface QQYYTiXianTwoTVC ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *carTF;
@property (weak, nonatomic) IBOutlet UIButton *tixianBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property(nonatomic,strong)NSString *carNumber;

@end

@implementation QQYYTiXianTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    
    self.tixianBt.layer.cornerRadius = 22;
    self.tixianBt.clipsToBounds = YES;
    
//    UIButton * rightbtn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
//    
//    //    [rightbtn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
//    [rightbtn setTitle:@"提现记录" forState:UIControlStateNormal];
//    rightbtn.titleLabel.font = kFont(14);
//    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [rightbtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    rightbtn.tag = 11;
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    self.titleLB.text = [NSString stringWithFormat:@"可提现%@元(1元对应100个爱豆)",self.flowerNumber];
    
    
}

- (void)navBtnClick:(UIButton *)button {
    QQYYTiXianJiLuTVC * vc =[[QQYYTiXianJiLuTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)action:(UIButton *)button {
    if (button.tag == 100) {
        
        QQYYYinHangKaTVC * vc =[[QQYYYinHangKaTVC alloc] init];
        Weak(weakSelf);
        vc.sendCarBlock = ^(QQYYTongYongModel * _Nonnull model) {
            
            NSString * str = model.cardNo;
            if (model.cardNo.length > 4) {
                str = [model.cardNo substringWithRange:NSMakeRange(model.cardNo.length - 4, 4)];
            }
            weakSelf.carTF.text = [NSString stringWithFormat:@"%@   尾号%@",model.bankName,str];
            
            weakSelf.carNumber = model.cardNo;
            
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(button.tag == 101) {
        //点击全部提现
        self.moneyTF.text = self.flowerNumber;
        
    }else {
        //单击确认提现
        if (self.moneyTF.text.length == 0 ){
            [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
            return;
        }
        if ([self.moneyTF.text floatValue]>[self.flowerNumber floatValue]){
            [SVProgressHUD showErrorWithStatus:@"提现金额不足"];
            return;
        }
        if ([self.moneyTF.text floatValue] <0){
            [SVProgressHUD showErrorWithStatus:@"请输入大于0的金额"];
            return;
        }
        
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"accountType"] = @(1);
        dict[@"flowerNum"] = self.moneyTF.text;
        dict[@"targetAccount"] = self.carNumber;
        
        [zkRequestTool networkingPOST:[QQYYURLDefineTool addWithDrawURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

            if ([responseObject[@"code"] intValue]== 0) {
                
                [SVProgressHUD showSuccessWithStatus:@"提现操作成功"];
               
                self.titleLB.text = [NSString stringWithFormat:@"可提现%0.2f元",[_flowerNumber floatValue] - [self.moneyTF.text floatValue]];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            

            
        }];
        
        
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
