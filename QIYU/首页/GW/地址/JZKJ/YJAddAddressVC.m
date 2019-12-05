//
//  YJAddAddressVC.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/12.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "YJAddAddressVC.h"

@interface YJAddAddressVC ()
@property (weak, nonatomic) IBOutlet UITextView *TV;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;

@end

@implementation YJAddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.TV.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.TV.layer.borderWidth = 1.0f;
    self.confirmBt.layer.cornerRadius = 21;
    self.confirmBt.clipsToBounds = YES;
    
    
    
    
}
- (IBAction)confirmAction:(id)sender {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人姓名"];
        return;
    }
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人电话"];
        return;
    }
    if (self.TV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        return;
    }
    
    NSString * sql = [NSString stringWithFormat:@"insert into kk_address (name,phone,address,userId) values ('%@','%@','%@','%@')",self.nameTF.text,self.phoneTF.text,self.TV.text,[QQYYSignleToolNew shareTool].session_uid];
    
    FMDatabase * db = [AAAAFMDBSignle shareFMDB].fd;
    if ([db open]) {
        BOOL insert = [db executeUpdate:sql];
        if (insert) {
            [SVProgressHUD showSuccessWithStatus:@"添加地址成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }else {
        
        [SVProgressHUD showErrorWithStatus:@"数据异常"];
        
        
    }
    
    
    
    
}


@end
