//
//  QQYYBindQWXVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYBindQWXVC.h"

@interface QQYYBindQWXVC ()

@end

@implementation QQYYBindQWXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定第三方";
}
- (IBAction)action:(UIButton *)button {
    
    if (button.tag == 100) {
        //QQ
        [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
    }else if (button.tag == 101) {
        //wx
        [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
    }else if (button.tag == 102) {
        //WB
        [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
    }
    
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;

        
        [self logWithUMSocialUserInfoResponse:resp];
        
        
    }];
}

//绑定第三方
- (void)logWithUMSocialUserInfoResponse:(UMSocialUserInfoResponse *)resp {
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"appkey"] = resp.openid;
    if (resp.platformType == UMSocialPlatformType_WechatSession) {
        requestDict[@"type"] = @"wechat";
    }else if (resp.platformType == UMSocialPlatformType_Sina) {
        requestDict[@"type"] = @"xinlang";
    }else if (resp.platformType == UMSocialPlatformType_QQ) {
        requestDict[@"type"] = @"qq";
    }
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool updateThirdAppURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            [SVProgressHUD showSuccessWithStatus:@"绑定第三方成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
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
