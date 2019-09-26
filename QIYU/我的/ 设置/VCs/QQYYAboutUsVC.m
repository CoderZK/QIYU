//
//  QQYYAboutUsVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYAboutUsVC.h"

@interface QQYYAboutUsVC ()
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@end

@implementation QQYYAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    self.contentLB.text = @"账户、支付出现问题，或有任何意见，可点反馈菜单进行反馈，也可使用如下方式联系我们。\n邮箱：2222222@qq.com\n官方微信公众号：hhhhhh\n天地有限公司";
    
    [self acquireDataFromServe];
    
}

- (void)acquireDataFromServe {
 
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool getBannerListURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
 
        if ([responseObject[@"code"] intValue]== 0) {
            
            
            
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
