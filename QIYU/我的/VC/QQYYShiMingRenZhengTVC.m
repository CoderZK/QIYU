//
//  QQYYShiMingRenZhengTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYShiMingRenZhengTVC.h"

@interface QQYYShiMingRenZhengTVC ()
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UITextField *nameTF,*numberTF;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *footStr,*backStr,*handStr;
@end

@implementation QQYYShiMingRenZhengTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"实名认证";
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 80);
    
    UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    lb.backgroundColor = RGB(245, 245, 245);
    lb.textColor = CharacterBlack40;
    lb.text = @"请如实准确本人信息, 否则驳回本人认证!";
    lb.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:lb];
    
    UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lb.frame) + 15, 60, 20)];
    lb1.textColor = CharacterBlack40;
    lb1.font = kFont(14);
    lb1.text = @"姓名";
    [self.headView addSubview:lb1];
    
    self.nameTF = [[UITextField alloc] init];
    self.nameTF.mj_x = CGRectGetMaxX(lb1.frame);
    self.nameTF.centerY = lb1.centerY;
    self.nameTF.mj_h = 30;
    self.nameTF.mj_w = ScreenW - CGRectGetMaxX(lb1.frame) - 15;
    self.nameTF.textAlignment = NSTextAlignmentRight;
    self.nameTF.placeholder = @"请输入您的名字";
    self.nameTF.font = kFont(14);
    [self.headView addSubview:self.nameTF];
    
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameTF.frame) + 10 , ScreenW - 30 , 0.6)];
    backV1.backgroundColor = lineBackColor;
    [self.headView addSubview:backV1];
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backV1.frame) + 15 , 60, 20)];
    lb2.textColor = CharacterBlack40;
    lb2.font = kFont(14);
    lb2.text = @"身份证号";
    [self.headView addSubview:lb2];
    
    self.numberTF = [[UITextField alloc] init];
    self.numberTF.mj_x = CGRectGetMaxX(lb2.frame);
    self.numberTF.centerY = lb2.centerY;
    self.numberTF.mj_h = 30;
    self.numberTF.mj_w = ScreenW - CGRectGetMaxX(lb2.frame) - 15;
    self.numberTF.textAlignment = NSTextAlignmentRight;
    self.numberTF.placeholder = @"请输入您的身份证号18位";
    self.numberTF.font = kFont(14);
    [self.headView addSubview:self.numberTF];
    
    UIView * backV2 =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.numberTF.frame) + 10 , ScreenW - 30 , 0.6)];
    backV2.backgroundColor = RGB(245, 245, 245);
    [self.headView addSubview:backV2];
    
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backV2.frame) + 15 , 120, 20)];
    lb3.textColor = CharacterBlack40;
    lb3.font = kFont(15);
    lb3.text = @"上传身份证";
    [self.headView addSubview:lb3];
    
    UILabel * lb4 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lb3.frame) + 15 , ScreenW - 30, 20)];
    lb4.textColor = CharacterBackColor;
    lb4.font = kFont(14);
    lb4.text = @"照片清晰 ,真实 ,完整 ,未经过PS处理";
    [self.headView addSubview:lb4];
    
    CGFloat w2 = (ScreenW - 60-150);
    CGFloat h2 = (w2 * 236 / 389);
    
    NSArray * arr = @[@"点击上传身份证面",@"点击上传身份证反面",@"点击上传手持身份证\n(可选)"];
    
    for (int i = 0 ; i < 3 ; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(lb4.frame) + 15 + (w2 * 236 / 389 + 20 ) * i , w2  , h2)];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"ss_%d",i]] forState:UIControlStateNormal];
       
        button.userInteractionEnabled = NO;
        button.tag = 300+i;
        
        UIButton * bt2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) + 15 , CGRectGetMinY(button.frame), 135, h2)];
        [bt2 setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake((135 - 40)/2, (h2 - 40)/2 - 15, 40, 40)];
        imgV.image = [UIImage imageNamed:@"95"];
        [bt2 addSubview:imgV];
        bt2.tag = 100+i;
        [bt2 addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(imgV.frame) , 125, 36)];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.numberOfLines = 0;
        lb.text = arr[i];
        lb.font = kFont(13);
        lb.textColor = CharacterBlackColor;
        [bt2 addSubview:lb];
        
        if (i== 1) {
            
            UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(button.frame) + 9.8 , ScreenW-60, 0.4)];
            backV.backgroundColor = lineBackColor;
            [self.headView addSubview:backV];
            

        }
        
        [self.headView addSubview:bt2];
        
        [self.headView addSubview:button];
        
        if (i == 2) {
            self.headView.mj_h = CGRectGetMaxY(button.frame) ;
        }
    }
    self.tableView.tableHeaderView = self.headView;
    
    UIView * footV =[[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 80 -sstatusHeight -44, ScreenH, 80)];
    footV.backgroundColor = [UIColor whiteColor];
    UIButton * confrimBt =[[UIButton alloc] initWithFrame:CGRectMake(20,20 , ScreenW - 40, 40)];
    confrimBt.tag = 200;
    [confrimBt setTitle:@"提交" forState:UIControlStateNormal];
    confrimBt.titleLabel.font = kFont(15);
    confrimBt.layer.cornerRadius = 20;
    confrimBt.clipsToBounds = YES;
    [confrimBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [confrimBt addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:confrimBt];
     [self.view addSubview:footV];
}

- (void)confirmAction:(UIButton *)button {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    if (self.numberTF.text.length != 18) {
        [SVProgressHUD showErrorWithStatus:@"请输入18位身份证号"];
        return;
    }
    if (self.footStr == nil) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证正面"];
        return;
    }
    if (self.backStr == nil) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证反面面"];
        return;
    }
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"actualName"] = self.nameTF.text;
    requestDict[@"idNo"] = self.numberTF.text;
    requestDict[@"idCardFront"] = self.footStr;
    requestDict[@"idCardBack"] = self.backStr;
    requestDict[@"handIdCard"] = self.handStr;
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool userAuthURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            [SVProgressHUD showSuccessWithStatus:@"认证成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}


- (void)chooseAction:(UIButton *)button {
    
    if (button.tag == 200) {
        
    }else {
        self.type = button.tag;
        UIButton * bt = [self.headView viewWithTag:button.tag + 200];
       [self addPictWithButton:bt];
    }
}

- (void)addPictWithButton:(UIButton *)button  {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                //                _img = image;
                //                _iconImg.image = image;
                
                [button setBackgroundImage:image forState:UIControlStateNormal];
                [self updateImgWithImg:image];
                
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                //                _img = photos.firstObject;
                //                _iconImg.image = photos.firstObject;
                [button setBackgroundImage:[photos lastObject] forState:UIControlStateNormal];
                
                 [self updateImgWithImg:photos[0]];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
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


- (void)updateImgWithImg:(UIImage *)imge {
    
    Weak(weakSelf);
    [QQYYRequestTool uploadImagsWithArr:@[imge] withType:@"6" result:^(NSString *str) {
        if (weakSelf.type == 100) {
            weakSelf.footStr = str;
        }else if (weakSelf.type == 101) {
            weakSelf.backStr = str;
        }else {
            weakSelf.handStr = str;
        }
        
        
    }];
}

@end
