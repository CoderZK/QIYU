//
//  QQYYRgisterVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYRgisterVC.h"
#import "QQYYAddZiLiaoTVC.h"
@interface QQYYRgisterVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;
@property (weak, nonatomic) IBOutlet UITextField *yaoQingCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *gouBt;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conH3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conH2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conH1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space3;

@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;

@end

@implementation QQYYRgisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    if (self.isTherd) {
       self.navigationItem.title = @"注册/绑定";
        [self.confrimBt setTitle:@"注册/绑定" forState:UIControlStateNormal];
        self.phoneTF.placeholder = @"请输入手机号(注册过/未注册过)";
        self.passWordTF.placeholder = @"请输入使用手机登录时的密码";
    }
   self.view4.layer.cornerRadius = self.view1.layer.cornerRadius = self.view2.layer.cornerRadius = self.view3.layer.cornerRadius = 25;
    self.confrimBt.layer.cornerRadius= 22.5;
   self.view4.clipsToBounds = self.view3.clipsToBounds =self.view2.clipsToBounds = self.view1.clipsToBounds = self.confrimBt.clipsToBounds = YES;
    self.view4.layer.borderWidth =  self.view3.layer.borderWidth = self.view1.layer.borderWidth =  self.view2.layer.borderWidth = 0.5;
   self.view4.layer.borderColor = self.view3.layer.borderColor = self.view1.layer.borderColor = self.view2.layer.borderColor = CharacterBlack40.CGColor;
    if (self.isTherd) {
//        self.conH1.constant = self.conH2.constant = self.conH3.constant = self.space1.constant = self.space2.constant = self.space3.constant = 0;
        
        
      
        
    }
}

- (IBAction)action:(UIButton *)button {
    
    if (button.tag == 100) {
        //发送验证码
        [self sendCode];
    }else if (button.tag == 101){
        //注册同意
        button.selected = !button.selected;
    }else if (button.tag == 102){
        //用户协议
        
    }else if (button.tag == 103){
        //隐私协议
        
       
        
    }else if (button.tag == 104){
        //注册
        
//        QQYYAddZiLiaoTVC * vc =[[QQYYAddZiLiaoTVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//        return;
        
        
        if (!self.gouBt.isSelected) {
            [SVProgressHUD showErrorWithStatus:@"请勾选注册协议"];
            return;
        }
        [self registerAction];
        
       
    }
    
    
    
}

- (void)sendCode {
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    NSMutableDictionary * dict = @{@"phone":self.phoneTF.text}.mutableCopy;
    dict[@"type"] = @(0);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool sendValidCodeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            [self timeAction];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

- (void)registerAction{
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (self.passWordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    NSMutableDictionary * dict = @{@"phone":self.phoneTF.text}.mutableCopy;
    dict[@"code"] = self.codeTF.text;
    dict[@"password"] = self.passWordTF.text;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool validCodeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            if (self.isTherd) {
                [self bindOrRegist];
            }else {
                QQYYAddZiLiaoTVC * vc =[[QQYYAddZiLiaoTVC alloc] init];
                vc.passdWord = self.passWordTF.text;
                vc.phoneStr = self.phoneTF.text;
                vc.yaoQingStr = self.yaoQingCodeTF.text;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

//注册或者绑定
- (void)bindOrRegist {
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    if (self.codeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (self.passWordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    NSMutableDictionary * dict = @{@"phone":self.phoneTF.text}.mutableCopy;
    dict[@"code"] = self.codeTF.text;
    dict[@"password"] = self.passWordTF.text;
    dict[@"type"] = self.apptype;
    dict[@"appKey"] = self.appOpenId;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool bindPhoneAndAppKeyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            
            QQYYLoginVC * vc = (QQYYLoginVC *)[self.navigationController.childViewControllers firstObject];
            vc.loginType = 1;
            [self.navigationController popToViewController:vc animated:YES];
            
        }else if ([responseObject[@"code"] intValue]== 10005) {
            QQYYAddZiLiaoTVC * vc =[[QQYYAddZiLiaoTVC alloc] init];
            vc.passdWord = self.passWordTF.text;
            vc.phoneStr = self.phoneTF.text;
            vc.yaoQingStr = self.yaoQingCodeTF.text;
            vc.appOpenId = self.appOpenId;
            vc.appType = self.apptype;
            vc.isThred = YES;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


- (void)timeAction {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.codeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.codeBt setTitle:[NSString stringWithFormat:@"%lds后重发",_number] forState:UIControlStateNormal];
    }else {
        [self.codeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.codeBt.userInteractionEnabled = YES;
    }
    
    
}

@end
