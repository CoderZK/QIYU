//
//  QQYYAddZiLiaoTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYAddZiLiaoTVC.h"
#import "QQYYTongYongCell.h"
#import "zkJuBaoView.h"
#import "SelectTimeV.h"
#import "QQYYShowPickerView.h"
#import "QQYYXingQuBiaoQianTVC.h"
#import "QQYYLoginVC.h"
@interface QQYYAddZiLiaoTVC ()<zkJuBaoViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UIButton * headBt;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *placeHolderArr;
@property(nonatomic,strong)NSString *nickName,*birthday,*provinceld,*tags,*tagIds,*genderStr,*provinceldID,*cityID,*headImgStr;
@property(nonatomic,assign)NSInteger gender ;

@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *addressArr;
@end

@implementation QQYYAddZiLiaoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gender = 0;
    self.addressArr = @[].mutableCopy;
    [self getProvinceListData];
    
    self.navigationItem.title = @"资料完善";
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2- 50, 20, 100, 100)];
    self.headBt.layer.cornerRadius = 5;
    self.headBt.clipsToBounds = YES;
    [self.headBt setBackgroundImage:[UIImage imageNamed:@"89"] forState:UIControlStateNormal];
    [self.headBt addTarget:self action:@selector(addPict) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.headBt];
    
    self.tableView.tableHeaderView = headView;
    
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    UILabel * LB = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, ScreenW-20, 20)];
    LB.text = @"为保证交友质量您的性别一经保存无法修改";
    LB.textAlignment = NSTextAlignmentCenter;
    LB.font = kFont(13);
    [footView addSubview:LB];
    
    UIButton * confrimBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 60, ScreenW-30, 45)];
    confrimBt.layer.cornerRadius =5;
    confrimBt.clipsToBounds = YES;
    [confrimBt addTarget:self action:@selector(confrimAction:) forControlEvents:UIControlEventTouchUpInside];
    [confrimBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [confrimBt setTitle:@"完成" forState:UIControlStateNormal];
    [footView addSubview:confrimBt];
    
    self.tableView.tableFooterView = footView;
    
    self.titleArr = @[@"昵称",@"生日",@"性别",@"地址",@"标签"];
    self.placeHolderArr = @[@"输入昵称(1~8)",@"选择生日",@"选择性别",@"地址",@"选择标签"];
    
    [self.tableView registerClass:[QQYYTongYongCell class] forCellReuseIdentifier:@"cell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYTongYongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.TF.userInteractionEnabled = NO;
    cell.leftLB.text = self.titleArr[indexPath.row];
    cell.TF.placeholder = self.placeHolderArr[indexPath.row];
    if (indexPath.row +1 == [self.titleArr count]) {
        cell.lineV.hidden = YES;
    }else {
        cell.lineV.hidden = NO;
    }
 
    if (indexPath.row == 0) {
        cell.TF.userInteractionEnabled = YES;
        cell.TF.delegate = self;
    }else if (indexPath.row == 1) {
        cell.TF.text = self.birthday;
    }else if (indexPath.row == 2) {
        cell.TF.text = self.genderStr;
    }else if (indexPath.row == 3) {
        cell.TF.text = self.provinceld;
    }else if (indexPath.row == 4) {
        cell.TF.text = self.tags;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QQYYTongYongCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.TF resignFirstResponder];
    if (indexPath.row == 1) {
        
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectOld = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
            
            if (timeStr) {
                weakSelf.birthday = timeStr;
                [weakSelf.tableView reloadData];
                
            }
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    }else if (indexPath.row == 2){
        
        QQYYShowPickerView * pickerV = [[QQYYShowPickerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        Weak(weakSelf);
        NSArray * arr = @[@"男",@"女"];
        pickerV.didSelectIndexBlock = ^(NSInteger index) {
            weakSelf.genderStr = arr[index];
            weakSelf.gender = index + 1;
            [weakSelf.tableView reloadData];
        };
         [pickerV showWithDataArr:arr];
    }else if (indexPath.row == 3) {
        
        QQYYShowPickerView * pickerV = [[QQYYShowPickerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        pickerV.isAddress = YES;
        pickerV.provityArr = self.addressArr;
        Weak(weakSelf);
        
        pickerV.didSelectCityBlock = ^(NSString * _Nonnull cityName, NSString * _Nonnull cityId,NSString * _Nonnull provinceName, NSString * _Nonnull provinceID) {
            weakSelf.provinceldID = provinceID;
            weakSelf.provinceld = cityName;
            weakSelf.cityID = cityId;
            [weakSelf.tableView reloadData];
        };
        
        pickerV.didSelectIndexBlock = ^(NSInteger index) {
            weakSelf.provinceldID = self.addressArr[index].ID;
            weakSelf.provinceld = self.addressArr[index].name;
            [weakSelf.tableView reloadData];
        };
        NSMutableArray * arr = @[].mutableCopy;
        for (int i = 0 ; i < self.addressArr.count; i++) {
            QQYYTongYongModel * model = self.addressArr[i];
            [arr addObject:model.name];
        }
        [pickerV showWithDataArr:arr];
    }else if (indexPath.row == 4) {
        QQYYXingQuBiaoQianTVC * vc =[[QQYYXingQuBiaoQianTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        Weak(weakSelf);
        vc.sendBiaoQianBlock = ^(NSArray<QQYYTongYongModel *> * _Nonnull arr, NSString * _Nonnull jionTitleStr, NSString * _Nonnull jionIdStr) {
            weakSelf.tags = jionTitleStr;
            weakSelf.tagIds = jionIdStr;
            [weakSelf.tableView reloadData];
            
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    QQYYTongYongCell * cell = (QQYYTongYongCell *)[textField superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        self.nickName = textField.text;
    }
    
    
}

//举报界面
- (void)didSelectAtIndex:(NSInteger )index withIndexPath:(NSIndexPath *)indexPath{
   
    NSArray * arr = @[@"男",@"女"];
    self.gender = index+1;
    self.genderStr = arr[index];
    [self.tableView reloadData];
    
}


- (void)confrimAction:(UIButton *)button {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"性别一经注册将无法修改" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self registerAction];
        
    }];

    [ac addAction:action1];
    [ac addAction:action2];

    
    [self.navigationController presentViewController:ac animated:YES completion:nil];

}

- (void)registerAction {
    
    if (self.headImgStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择头像"];
        return;
    }
    if (self.nickName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return;
    }
    
    if ( self.nibName.length > 8) {
        [SVProgressHUD showErrorWithStatus:@"请输入1~8位的昵称"];
        return;
    }
    
    if (self.birthday.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择生日"];
        return;
    }
    if (self.gender == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        return;
    }
    if (self.provinceld.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择常住地址"];
        return;
    }
    if (self.tags.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择常标签"];
        return;
    }
   
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    if (self.isThred) {
        dict[@"appKey"] = self.appOpenId;
        dict[@"appName"] = self.appType;
    }
    dict[@"phone"] = self.phoneStr;
    dict[@"password"] = self.passdWord;
    dict[@"birthday"] = self.birthday;
    dict[@"avatar"] = self.headImgStr;
    dict[@"gender"] = @(self.gender);
    dict[@"nickName"] = self.nickName;
    dict[@"provinceId"] = self.provinceldID;
    dict[@"cityId"] = self.cityID;
    dict[@"tags"] = self.tagIds;
    dict[@"invitationCode"] = self.yaoQingStr;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool registerURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            QQYYLoginVC * vc = (QQYYLoginVC *)[self.navigationController.childViewControllers firstObject];
            if (self.isThred) {
                vc.loginType = 1;
     
            }else {
                vc.loginType = 0;
                vc.phoneStr = self.phoneStr;
                vc.passwordStr = self.passdWord;
            }
            [self.navigationController popToViewController:vc animated:YES];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}



- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                
                
                 [self.headBt setBackgroundImage:image forState:UIControlStateNormal];
                
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
           
            [self showMXPickerWithMaximumPhotosAllow:1 completion:^(NSArray *assets) {
                if (assets.count>0) {
                    ALAsset *asset = assets[0];
                    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                    CGImageRef imgRef = [assetRep fullResolutionImage];
                    UIImage *image = [[UIImage alloc] initWithCGImage:imgRef
                                                                scale:assetRep.scale
                                                          orientation:(UIImageOrientation)assetRep.orientation];
                    
                    if (!image) {
                        image = [[UIImage alloc] initWithCGImage:[[asset defaultRepresentation] fullScreenImage]
                                                           scale:assetRep.scale
                                                     orientation:(UIImageOrientation)assetRep.orientation];
                        
                    }
                    if (!image) {
                        CGImageRef thum = [asset aspectRatioThumbnail];
                        image = [UIImage imageWithCGImage:thum];
                    }
                    
                    [self uploadHeadImageWithImage:image];
                    
                    [self.headBt setBackgroundImage:image forState:UIControlStateNormal];
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

- (void)uploadHeadImageWithImage:(UIImage *)image {
    
    [zkRequestTool uploadImagsWithArr:@[image] withType:@"2" result:^(NSString *str) {
        if ([str isEqualToString:@"0"]) {
           
        }else {
           self.headImgStr = str;
        }
        
    }];
}


//获取省份
- (void)getProvinceListData {
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool provinceListURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            
            self.addressArr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
     
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}


@end
