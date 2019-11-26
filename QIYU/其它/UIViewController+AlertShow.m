//
//  UIViewController+AlertShow.m
//  FMWXB
//
//  Created by kunzhang on 2017/11/10.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import "UIViewController+AlertShow.h"

@implementation UIViewController (AlertShow)

-(void)showAlertWithKey:(NSString *)num message:(NSString *)message{
    [SVProgressHUD dismiss];
    int n = [num intValue];
    NSString * msg = nil;
    
    switch (n)
    {
         
        case 10004:
        {
            [QQYYSignleToolNew shareTool].isLogin = NO;
            msg=[NSString stringWithFormat:@"%@",message];
            break;
        }
        case 10005:
        {
            [QQYYSignleToolNew shareTool].isLogin = NO;
            msg=[NSString stringWithFormat:@"%@",message];
            break;
        }
       
        default:
            msg=[NSString stringWithFormat:@"%@",message];
            break;
    }

    if (msg)
    {

        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * confirm =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (n == 10004 || n == 10005) {
              UIViewController * vc = [UIApplication sharedApplication].keyWindow.rootViewController ;
                QQYYLoginVC * vc1 =[[QQYYLoginVC alloc] init];
                BaseNavigationController * navc =[[BaseNavigationController alloc] initWithRootViewController:vc1];;
                [vc presentViewController:navc animated:YES completion:nil];
            }else if (n == 10007) {
            
//                if (isDDDDDDDD) {
//                    return ;
//                }
                TabBarController * barVC = (TabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                BaseNavigationController * navc = (BaseNavigationController *)barVC.selectedViewController;
                QQYYReDuTVC * vc1 =[[QQYYReDuTVC alloc] init];
                [navc pushViewController:vc1 animated:YES];
            }
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    
    
    
}

@end
