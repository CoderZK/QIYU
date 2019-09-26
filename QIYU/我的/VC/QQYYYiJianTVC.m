//
//  QQYYYiJianTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYYiJianTVC.h"

@interface QQYYYiJianTVC ()
@property (weak, nonatomic) IBOutlet UIButton *keFuBt;
@property (weak, nonatomic) IBOutlet UIView *grayV;
@property (strong, nonatomic) IQTextView *TV;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property(nonatomic,strong)zkHomelModel *model;

@end

@implementation QQYYYiJianTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(8, 8, ScreenW - 30- 16, 134)];
    self.TV.backgroundColor  = [UIColor clearColor];
    [self.grayV addSubview:self.TV];
    self.TV.font = kFont(14);
    self.TV.placeholder = @"请输入意见反馈";
    self.grayV.layer.cornerRadius = 3;
    self.grayV.clipsToBounds = YES;
    
    self.confirmBt.layer.cornerRadius = self.keFuBt.layer.cornerRadius = 22;
    self.confirmBt.clipsToBounds = self.keFuBt.clipsToBounds = YES;
    
    [self getKeFu];
    
    
}
- (IBAction)keFuAction:(UIButton *)button {
    
    if (button.tag == 100){
        //跳转到客服
        
        [self gotoCharWithOtherHuanXinID:self.model.userNo andOtherUserId:self.model.userId andOtherNickName:self.model.nickName andOtherImg:@"" andVC:self];
        
    }else {
       //点击了确定
        
        if (self.TV.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入意见反馈"];
            return;
        }
        
        [self sendMessageAction];
        
    }
    
    
}

- (void)getKeFu {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool contactKefURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            self.model = [zkHomelModel mj_objectWithKeyValues:responseObject[@"object"]];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
}


- (void)sendMessageAction {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"content"] = self.TV.text;
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool addMyFeedBackURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            [SVProgressHUD showSuccessWithStatus:@"意见提交成功,感谢您的宝贵意见我们将进行改进"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    
        
    }];
    
}


@end
