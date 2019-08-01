//
//  QQYYPrivacyPassWordVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYPrivacyPassWordVC.h"
@interface QQYYPrivacyPassWordVC ()

@end

@implementation QQYYPrivacyPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"隐私设置";
    YWUnlockView * v = [YWUnlockView shareInstace];
    [YWUnlockView deleteGesturesPassword];
    v.mj_y = -sstatusHeight - 44;
    v.type = YWUnlockViewCreate;
    __weak typeof(self) weakSelf = self;
    v.block = ^(BOOL result) {
        NSLog(@"-->%@",@(result));
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
    v.forgetPassBlock = ^(NSInteger type) {
        NSLog(@"-->%@",@(type));
    };
    
    
    [self.view addSubview:v];
    
    self.view.backgroundColor = WhiteColor;
    
    
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
