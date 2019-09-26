//
//  QQYYBindPoneTwoVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYBindPoneTwoVC.h"
#import "QQYYBindPhoneVC.h"

@interface QQYYBindPoneTwoVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;

@end

@implementation QQYYBindPoneTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更换手机号";
    
    self.view1.layer.cornerRadius  =  25;
    self.confrimBt.layer.cornerRadius =22.5;
    self.view1.clipsToBounds = self.confrimBt.clipsToBounds = YES;
    self.view1.layer.borderWidth =  0.5;
    self.view1.layer.borderColor =  CharacterBlack40.CGColor;
    
    self.titleLB.text = [NSString stringWithFormat:@"已绑定的手机号：%@",self.phoneStr];
    
}

- (IBAction)action:(UIButton *)button {
    
    if (button.tag == 100) {
        
        [self sendCode];
        
    }else {
        [self vaile];

    }
    
    
    
}

- (void)sendCode {
    
  
    NSMutableDictionary * requestDict = @{@"phone":self.phoneStr}.mutableCopy;
    requestDict[@"deviceId"] = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool sendValidCodeURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            [self timeAction];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

//验证验证码
- (void)vaile {
    NSMutableDictionary * requestDict = @{@"phone":self.phoneStr}.mutableCopy;
    requestDict[@"code"] = self.codeTF.text;
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool validCodeURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            QQYYBindPhoneVC * vc =[[QQYYBindPhoneVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
