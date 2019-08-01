//
//  QQYYLoginVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYLoginVC.h"
#import "QQYYChangePasswordVC.h"
#import "QQYYRgisterVC.h"
@interface QQYYLoginVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;
@end

@implementation QQYYLoginVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    self.view1.layer.cornerRadius = self.view2.layer.cornerRadius =  25;
    self.confrimBt.layer.cornerRadius = 22.5;
    self.view2.clipsToBounds = self.view1.clipsToBounds = self.confrimBt.clipsToBounds = YES;
    self.view1.layer.borderWidth =  self.view2.layer.borderWidth = 0.5;
     self.view1.layer.borderColor = self.view2.layer.borderColor = CharacterBlack40.CGColor;
    
    [self.confrimBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (IBAction)action:(UIButton *)button {
    if (button.tag == 100) {
        //叉
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (button.tag == 101) {
        button.selected = !button.selected;
        self.passWordTF.secureTextEntry = !button.selected;
        
    }else if (button.tag == 102) {
        //忘记秘密
        QQYYChangePasswordVC * vc =[[QQYYChangePasswordVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 103) {
         QQYYRgisterVC* vc =[[QQYYRgisterVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 104) {
        //登录
        
//        [zkSignleTool shareTool].isLogin = YES;
//        [self dismissViewControllerAnimated:YES completion:nil];
//        return;
//
        [self loginAction];
        
        

        
        
    }else if (button.tag == 105) {
        //QQ
        [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
    }else if (button.tag == 106) {
        //wx
         [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
    }else if (button.tag == 107) {
        //WB
         [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
    }
    
    
}


//登录
- (void)loginAction {
    

    
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
    NSMutableDictionary * dict = @{@"phone":self.phoneTF.text}.mutableCopy;
    dict[@"password"] = self.passWordTF.text;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getLoginURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
          
            [zkSignleTool shareTool].isLogin = YES;
            [zkSignleTool shareTool].session_token = responseObject[@"object"][@"token"];
            [zkSignleTool shareTool].session_uid = [NSString stringWithFormat:@"%@",responseObject[@"object"][@"userId"]];
            [zkSignleTool shareTool].img =[NSString stringWithFormat:@"%@",responseObject[@"object"][@"avatar"]];
            [zkSignleTool shareTool].nickName =[NSString stringWithFormat:@"%@",responseObject[@"object"][@"nickName"]];
             [zkSignleTool shareTool].huanxin =[NSString stringWithFormat:@"%@",responseObject[@"object"][@"huanxin"]];
            EMError * error = [[EMClient sharedClient] loginWithUsername:responseObject[@"object"][@"huanxin"] password:huanXinMiMa];
            if (!error) {
                
                [[EMClient sharedClient].options setIsAutoLogin:YES]; //设定自动登录
                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"%@",@"登录成功");
                
            }else {
             
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}



- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}



@end
