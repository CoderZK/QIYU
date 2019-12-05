//
//  YJWenTiVC.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/12.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "YJWenTiVC.h"

@interface YJWenTiVC ()
@property (weak, nonatomic) IBOutlet UITextView *TF;
@property (weak, nonatomic) IBOutlet UIButton *bt;

@end

@implementation YJWenTiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TF.layer.borderColor = [UIColor blackColor].CGColor;
    self.TF.layer.borderWidth = 1.0f;
    self.navigationItem.title = @"意见反馈";
    self.bt.layer.cornerRadius = 21;
    self.bt.clipsToBounds = YES;
}
- (IBAction)clickAction:(id)sender {
    if (self.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的意见"];
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"意见提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
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
