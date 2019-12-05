//
//  kkRenZhengVC.m
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/10.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "kkRenZhengVC.h"
#import "UIViewController+MXPhotoPicker.h"

@interface kkRenZhengVC()
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *zhengBt;
@property (weak, nonatomic) IBOutlet UIButton *fanBt;
@property(nonatomic,assign)BOOL zheng,fan;

@end

@implementation kkRenZhengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"nil"] forState:UIControlStateNormal];
    [button setTitle:@"认证" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(renZhengAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)renZhengAction {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if (self.numberTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    
    if (self.zheng == NO) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证正面"];
        return;
    }
    
    if (self.fan == NO) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证反面"];
        return;
    }
    [SVProgressHUD show];
    NSString * sql = [NSString stringWithFormat:@"insert into kk_approveRecord (userName,name,number) values ('%@','%@','%@')",[QQYYSignleToolNew shareTool].session_uid,self.nameTF.text,self.numberTF.text];
    FMDatabase *db = [AAAAFMDBSignle shareFMDB].fd;
    BOOL isOpen = [db open];
    if (isOpen) {
        BOOL insert = [db executeUpdate:sql];
        if (insert) {
            NSLog(@"%@",@"插入认证信息成功\n");
            NSString * sql2 = [NSString stringWithFormat:@"update kk_users set status = 1 where name = '%@'",[QQYYSignleToolNew shareTool].session_uid];
           BOOL up = [db executeUpdate:sql2];
            if (up) {
                 NSLog(@"%@",@"认证信息更新成功\n");
                
                    NSString * sql3 = [NSString stringWithFormat:@"insert into kk_news (title,content,name) values ('%@','%@','%@')",@"实名认证",@"您已经提交了实名认证信息,我们将在2~3工作日对您的认证信息进行反馈",[QQYYSignleToolNew shareTool].session_uid];
                    BOOL news = [db executeUpdate:sql3];
                    if (news) {
                        NSLog(@"%@",@"添加信息成功\n");
                    }
                
            }
            
        }
        
    }else {
        [SVProgressHUD showErrorWithStatus:@"服务器数据异常"];
    }
    
    [db close];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showSuccessWithStatus:@"认证提交成功2~3工作日给出审核结果"];
        [self.navigationController popViewControllerAnimated:YES];
        
    });
    
}


- (IBAction)clickAction:(UIButton *)sender {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            if ([self isCanUsePhotos]) {
                [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                    
                    [sender setBackgroundImage:image forState:UIControlStateNormal];
                    if (sender.tag == 100) {
                        self.zheng = YES;
                    }else {
                        self.fan = YES;
                    }
                    
                    
                }];
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([self isCanUsePicture]) {
                [self showMXPickerWithMaximumPhotosAllow:1 completion:^(NSArray *assets) {
                    if (assets.count > 0) {
                        ALAsset *asset = assets[0];
                        //全屏分辨率图片
                        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                         [sender setBackgroundImage:image forState:UIControlStateNormal];
                        if (sender.tag == 100) {
                            self.zheng = YES;
                        }else {
                            self.fan = YES;
                        }
                    }
                 
             
                }];
                
            }else{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:action1];
        [ac addAction:action2];
        [ac addAction:action3];
        
        [self.navigationController presentViewController:ac animated:YES completion:nil];
    
    
    
}





@end
