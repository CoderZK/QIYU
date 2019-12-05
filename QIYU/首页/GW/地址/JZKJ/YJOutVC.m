//
//  YJOutVC.m
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/13.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "YJOutVC.h"

@interface YJOutVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginOutBt;

@end

@implementation YJOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    self.loginOutBt.layer.cornerRadius = 21;
    self.loginOutBt.clipsToBounds = YES;
    if ([QQYYSignleToolNew shareTool].isLogin) {
        self.loginOutBt.hidden = NO;
    }else {
        self.loginOutBt.hidden = YES;
    }
    
    
}
- (IBAction)outAction:(id)sender {
    [QQYYSignleToolNew shareTool].isLogin = NO;
    [self.navigationController popViewControllerAnimated:YES];
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
