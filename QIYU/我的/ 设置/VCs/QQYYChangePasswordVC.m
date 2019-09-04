//
//  QQYYChangePasswordVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYChangePasswordVC.h"

@interface QQYYChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@end

@implementation QQYYChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.view1.layer.cornerRadius = self.view2.layer.cornerRadius = self.view3.layer.cornerRadius = 25;
    self.confrimBt.layer.cornerRadius=22.5;
    self.view3.clipsToBounds =self.view2.clipsToBounds = self.view1.clipsToBounds = self.confrimBt.clipsToBounds = YES;
       self.view3.layer.borderWidth = self.view1.layer.borderWidth =  self.view2.layer.borderWidth = 0.5;
   self.view3.layer.borderColor = self.view1.layer.borderColor = self.view2.layer.borderColor = CharacterBlack40.CGColor;
}

- (IBAction)action:(UIButton *)button {
    
    if (button.tag == 100) {
        //发送验证码
        
        
        if (self.phoneTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        if (self.phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        NSMutableDictionary * dict = @{@"phone":self.phoneTF.text}.mutableCopy;
        dict[@"deviceId"] = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
        [zkRequestTool networkingPOST:[QQYYURLDefineTool sendValidCodeURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"code"] intValue]== 0) {
                [self timeAction];
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            
        }];
        
    }else if (button.tag == 101){
        
        
        if (self.phoneTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        if (self.phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        if (self.passWordTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        
        
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"code"] = self.codeTF.text;
        dict[@"newPwd"]= self.passWordTF.text;
        [zkRequestTool networkingPOST:[QQYYURLDefineTool updatePwdURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"code"] intValue]== 0) {
                
                [SVProgressHUD showErrorWithStatus:@"修改密码成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            
        }];
      
    }
    
    
    
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
