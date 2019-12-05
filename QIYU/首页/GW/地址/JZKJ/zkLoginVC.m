//
//  zkLoginVC.m
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/8.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "zkLoginVC.h"
#import "YJXieYiVC.h"
#import "AAAAFMDBSignle.h"
@interface zkLoginVC()
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@end


@implementation zkLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBt.layer.cornerRadius = 21;
    self.loginBt.clipsToBounds = YES;
    
}

- (IBAction)closeAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
       [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        if (self.nameTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
            return;
        }
        if (self.passWordTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        
        [self loginOrRegist];
        
    }
    
    
}
- (IBAction)xieYiAction:(id)sender {
    
    YJXieYiVC * vc =[[YJXieYiVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)loginOrRegist {
    
    FMDatabase * db = [AAAAFMDBSignle shareFMDB].fd;
    BOOL isOpen = [db open];
    if (isOpen) {
        NSString * sql = [NSString stringWithFormat:@"select *from 'kk_users' where name = %@ ",self.nameTF.text];
        
        FMResultSet * result = [db executeQuery:sql];
        BOOL isOK = NO;
        while ([result next]) {
            
            NSLog(@"%@\n",@"成功!!!!!");

            
            NSString * name = [result stringForColumn:@"name"];
            NSString * passWord = [result stringForColumn:@"passWord"];
            if ([name isEqualToString:self.nameTF.text]) {
                   isOK = YES;
                if ([passWord isEqualToString:self.passWordTF.text]) {
                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                    [QQYYSignleToolNew shareTool].isLogin = YES;
                    [QQYYSignleToolNew shareTool].session_uid = self.nameTF.text;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                    
                    break;
                }else {
                    [SVProgressHUD showErrorWithStatus:@"密码错误"];
                    break;
                    
                }
             
            }
        }
            
        
        if (!isOK) {
        NSString * sql = [NSString stringWithFormat:@"insert into kk_users (name,passWord) values (%@,%@)",self.nameTF.text,self.passWordTF.text];
           BOOL insert =  [db executeUpdate:sql];
            if (insert) {
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [QQYYSignleToolNew shareTool].session_uid = self.nameTF.text;
                [QQYYSignleToolNew shareTool].isLogin = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });

            }else {
                [SVProgressHUD showErrorWithStatus:@"服务异常"];
            }
        }
    }else {
        [SVProgressHUD showErrorWithStatus:@"数据库异常请稍后再试"];
    }
    
    [db close];
    
    
    
    
}




@end
