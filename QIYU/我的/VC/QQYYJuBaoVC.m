//
//  QQYYJuBaoVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/7/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYJuBaoVC.h"

@interface QQYYJuBaoVC ()
@property (weak, nonatomic) IBOutlet UIView *grayV;
@property (strong, nonatomic) IQTextView *TV;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@end

@implementation QQYYJuBaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"举报";
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(8, 8, ScreenW - 30- 16, 134)];
    self.TV.backgroundColor  = [UIColor clearColor];
    [self.grayV addSubview:self.TV];
    self.TV.font = kFont(14);
    self.TV.placeholder = @"请输入举报内容";
    self.grayV.layer.cornerRadius = 3;
    self.grayV.clipsToBounds = YES;
    
    self.confirmBt.layer.cornerRadius  = 22;
    self.confirmBt.clipsToBounds  = YES;
}

- (IBAction)keFuAction:(UIButton *)button {
    

        
        if (self.TV.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入意见反馈"];
            return;
        }
        
        [self send];

    
    
}

- (void)send {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"reportRemark"] = self.TV.text;
    dict[@"linkId"] = self.ID;
    dict[@"type"] = @"2";
    [zkRequestTool networkingPOST:[QQYYURLDefineTool addMyReportURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
