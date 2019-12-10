//
//  QQYYXiuGaiZiLiaoTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYXiuGaiZiLiaoTVC.h"
#import "QQYYZhuYeOneCell.h"
#import "QQYYZhuYeTwoCell.h"
#import "QQYYZhuYeThreeCell.h"
#import "QQYYZhuYeFourCell.h"
#import "QQYYHomeDongTaiCell.h"
#import "zkHomelModel.h"
#import "QQYYTongYongCell.h"
#import "QQYYReportAndCollectVIew.h"
#import "SelectTimeV.h"
#import "QQYYShowPickerView.h"
#import "QQYYXingQuBiaoQianTVC.h"
@interface QQYYXiuGaiZiLiaoTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *headBt ,*editBt;
@property(nonatomic,strong)UIImageView *backImgV;
@property(nonatomic,strong)UILabel *navitaTitleLB;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *placeHolderArr;
@property(nonatomic,strong)QQYYUserModel *dataModel;
@property(nonatomic,strong)NSMutableArray  *photosArr;
@property(nonatomic,strong)NSString *nickName,*birthday,*provinceld,*tags,*tagIds,*genderStr,*provinceldID,*cityID,*cityName,*headImgStr;
@property(nonatomic,strong)NSArray<QQYYTongYongModel *> *addressArr;
@property(nonatomic,strong)NSArray *sexArr,*marryArr;
@property(nonatomic,assign)NSInteger type; //是需改头像还是背景
@property(nonatomic,assign)NSInteger sexGo;
@end

@implementation QQYYXiuGaiZiLiaoTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    if (self.navigationController.childViewControllers.count <2) {
        [self xiugGAIAction];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addressArr = @[].mutableCopy;
    [self getProvinceListData];
    
    
    // Do any additional setup after loading the view.
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight);
    [self.tableView registerClass:[QQYYZhuYeThreeCell class] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerClass:[QQYYZhuYeFourCell class] forCellReuseIdentifier:@"cell4"];
    [self.tableView registerClass:[QQYYTongYongCell class] forCellReuseIdentifier:@"cell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    [self initHeadV];
    [self createBackNavigation];

    self.photosArr = @[].mutableCopy;
    self.titleArr = @[@[],@[@"昵称",@"性别",@"生日",@"常住地区"],@[],@[@"身高",@"体重",@"性取向",@"感情状况",@"个性签名"]];
    self.placeHolderArr = @[@[],@[@"填写",@"选择",@"选择",@"选择"],@[],@[@"选择",@"选择",@"选择",@"选择",@"填写"]];
    
    self.sexArr = @[@"男",@"女"];
    self.marryArr = @[@"单身",@"已婚",@"保密"];
    
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];

    
}


- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool getMyInfoURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataModel = [QQYYUserModel mj_objectWithKeyValues:responseObject[@"object"]];
            self.photosArr = [self.dataModel.photos componentsSeparatedByString:@","].mutableCopy;
            self.tags = self.dataModel.tagsName;
            self.tagIds = self.dataModel.tags;
            self.cityName = self.dataModel.cityName;
            self.provinceld = self.dataModel.provinceName;
            self.sexGo = [self.dataModel.sexualOrientation integerValue];
            [self.tableView reloadData];
            
         
            [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.dataModel.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
            [self.backImgV sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.dataModel.background]]
                             placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (void)leftOrRightClickAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initHeadV {
    UIView * headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, Kscale(245))];
    headView.backgroundColor  = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:headView.bounds];
    imgV.image = [UIImage imageNamed:@"96"];
    self.backImgV = imgV;
    imgV.clipsToBounds = YES;
    self.backImgV.contentMode = UIViewContentModeScaleAspectFill;
    [headView addSubview:imgV];
    
    self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 - 40, (Kscale(245) - 70 )/2 ,70, 70)];
    self.headBt.layer.cornerRadius = 5;
    self.headBt.clipsToBounds = YES;
    self.headBt.tag = 100;
    [headView addSubview:self.headBt];
    [self.headBt addTarget:self action:@selector(updateAvatar:) forControlEvents:UIControlEventTouchUpInside];
    [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    
    self.editBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 10, sstatusHeight + 2 ,60, 30)];
    [self.editBt setTitle:@"更换背景" forState:UIControlStateNormal];
    self.editBt.titleLabel.font = kFont(14);
    [self.editBt setTitleColor:WhiteColor forState:UIControlStateNormal];
//    self.editBt.backgroundColor = WhiteColor;
//    self.editBt.layer.cornerRadius = 17.5;
//    self.editBt.clipsToBounds = YES;
    [self.editBt addTarget:self action:@selector(updateAvatar:) forControlEvents:UIControlEventTouchUpInside];
    self.editBt.tag = 101;
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:self.editBt];
    [headView addSubview:self.editBt];
    
    self.navitaTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(30, sstatusHeight, ScreenW - 60, 44)];
    self.navitaTitleLB.font = kFont(18);
    self.navitaTitleLB.text = @"修改资料";
    self.navitaTitleLB.textAlignment = NSTextAlignmentCenter;
    self.navitaTitleLB.textColor = [UIColor whiteColor];
    [headView addSubview:self.navitaTitleLB];
    
    
    UIImageView * bottomImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, Kscale(192), ScreenW, Kscale(53))];
    bottomImgV.image = [UIImage imageNamed:@"qy87"];
    [headView addSubview:bottomImgV];
    
    self.tableView.tableHeaderView = headView;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataModel == nil) {
        return 0;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 1;
    }else if (section == 1) {
        return 4;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (self.dataModel.photos.length == 0) {
            return 0;
        }
        
        return (ScreenW - 60) / 4 + 30;
    }else if (indexPath.section ==2) {
        return  self.dataModel.cellHeight;
    }
    return 50;
}

- (void)createBackNavigation{
    
    UIButton * leftbtn=[[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2 , 40, 40)];
    [leftbtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.tag = 10;
    [self.view addSubview:leftbtn];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QQYYZhuYeThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
      
        cell.dataArray = self.photosArr;
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section == 2) {
        
        QQYYZhuYeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        cell.model = self.dataModel;
        cell.type = 1;
        cell.arr = [self.tags componentsSeparatedByString:@","];
        return cell;
    }
    
    QQYYTongYongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.TF.userInteractionEnabled = NO;
    cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
    cell.TF.placeholder = self.placeHolderArr[indexPath.section][indexPath.row];
    if (indexPath.row +1 == [self.titleArr[indexPath.section] count]) {
        cell.lineV.hidden = YES;
    }else {
        cell.lineV.hidden = NO;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.TF.userInteractionEnabled = YES;
            cell.TF.delegate = self;
            cell.TF.text = self.dataModel.nickName;
        }else if (indexPath.row == 1) {
            cell.TF.text = self.sexArr[self.dataModel.gender-1];
        }else if (indexPath.row == 2) {
            cell.TF.text = self.dataModel.birthday.length > 10 ? [self.dataModel.birthday substringToIndex:10] : self.dataModel.birthday;
        }else if (indexPath.row == 3) {
            cell.TF.text = [NSString stringWithFormat:@"%@-%@",self.provinceld,self.cityName];;
        }

    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            if (self.dataModel.height.length > 0) {
                cell.TF.text = [NSString stringWithFormat:@"%@cm",self.dataModel.height];
            }
            
        }else if (indexPath.row == 1) {
              if (self.dataModel.weight.length > 0) {
                  cell.TF.text = [NSString stringWithFormat:@"%@kg",self.dataModel.weight];
                  
              }
        }else if (indexPath.row == 2) {
            if (self.dataModel.sexualOrientation.length > 0) {
                cell.TF.text = self.sexArr[self.sexGo  - 1];
            }
            
        }else if (indexPath.row == 3) {
            if (self.dataModel.marriageStatus) {
                cell.TF.text = self.marryArr[self.dataModel.marriageStatus - 1];
            }
            
        }else if (indexPath.row == 4) {
            cell.TF.userInteractionEnabled = YES;
            cell.TF.delegate = self;
            cell.TF.text = self.dataModel.sign;
        }
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 0.01;
    }else {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * footV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    if (footV == nil) {
        footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        footV.backgroundColor = BackgroundColor;
    }
    return footV;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 1) {

        }else if (indexPath.row == 2) {
            //生日
            SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
            selectTimeV.isCanSelectOld = YES;
            Weak(weakSelf);
            selectTimeV.block = ^(NSString *timeStr) {
                
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                                          [formatter setDateFormat:@"yyyy-mm-dd"];
                                          NSString * nowSate = [formatter stringFromDate:[NSDate date]];
                                          NSInteger nowY = [[nowSate substringToIndex:4] intValue];
                                          if (timeStr.length >= 10) {
                                              NSInteger oldY = [[timeStr substringToIndex:4] intValue];
                                              if (nowY - oldY <18) {
                                                  [SVProgressHUD showErrorWithStatus:@"我们不允许18岁以下人员注册"];
                                                  return ;
                                              }
                                          }
                
                
                if (timeStr) {
                    
                    weakSelf.dataModel.birthday = timeStr;
                    [weakSelf.tableView reloadData];
                }
                
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];

        }else if (indexPath.row == 3) {
            //常住地区
            QQYYShowPickerView * pickerV = [[QQYYShowPickerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            pickerV.isAddress = YES;
            pickerV.provityArr = self.addressArr;
            Weak(weakSelf);
            
            pickerV.didSelectCityBlock = ^(NSString * _Nonnull cityName, NSString * _Nonnull cityId,NSString * _Nonnull provinceName, NSString * _Nonnull provinceID) {
                weakSelf.provinceldID = provinceID;
                weakSelf.provinceld = provinceName;
                weakSelf.cityID = cityId;
                weakSelf.cityName = cityName;
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
        }
        
        
    }else if (indexPath.section == 2) {
        //标签
        QQYYXingQuBiaoQianTVC * vc =[[QQYYXingQuBiaoQianTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        Weak(weakSelf);

        vc.sendBiaoQianBlock = ^(NSArray<QQYYTongYongModel *> * _Nonnull arr, NSString * _Nonnull jionTitleStr, NSString * _Nonnull jionIdStr) {
            weakSelf.tags = jionTitleStr;
            weakSelf.tagIds = jionIdStr;
            [weakSelf.tableView reloadData];
            
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 3) {
        
        NSMutableArray * arr = @[].mutableCopy;
        //身高
        if (indexPath.row == 0) {
            for (int i = 130 ; i < 220; i++) {
                [arr addObject:[NSString stringWithFormat:@"%dcm",i]];
                
            }
             QQYYShowPickerView * pickerV = [[QQYYShowPickerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            Weak(weakSelf);
            pickerV.didSelectIndexBlock = ^(NSInteger index) {
                weakSelf.dataModel.height = [NSString stringWithFormat:@"%ld",index + 130];
                [weakSelf.tableView reloadData];
            };
            [pickerV showWithDataArr:arr];
        }else if (indexPath.row == 1) {
         //体重
            for (int i = 30 ; i < 150; i++) {
                [arr addObject:[NSString stringWithFormat:@"%dkg",i]];
 
            }
            QQYYShowPickerView * pickerV = [[QQYYShowPickerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            Weak(weakSelf);
            pickerV.didSelectIndexBlock = ^(NSInteger index) {
                weakSelf.dataModel.weight = [NSString stringWithFormat:@"%ld",index + 30];
                [weakSelf.tableView reloadData];
            };
            [pickerV showWithDataArr:arr];
            
        }else if (indexPath.row == 2) {
            //取向
            QQYYShowPickerView * pickerV = [[QQYYShowPickerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            Weak(weakSelf);
            pickerV.didSelectIndexBlock = ^(NSInteger index) {
                weakSelf.dataModel.sexualOrientation = [self.sexArr objectAtIndex:index];
                weakSelf.sexGo = index+1;
                [weakSelf.tableView reloadData];
            };
            [pickerV showWithDataArr:self.sexArr];
        }else if (indexPath.row == 3) {
            //感情
            QQYYShowPickerView * pickerV = [[QQYYShowPickerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            Weak(weakSelf);
            pickerV.didSelectIndexBlock = ^(NSInteger index) {
                weakSelf.dataModel.marriageStatusStr = [self.marryArr objectAtIndex:index];
                weakSelf.dataModel.marriageStatus = index + 1;
                [weakSelf.tableView reloadData];
            };
            [pickerV showWithDataArr:self.marryArr];
        }
       
        
    }
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    QQYYTongYongCell * cell = (QQYYTongYongCell *)[textField superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0 && indexPath.section == 1) {
        self.dataModel.nickName = textField.text;
    }else if (indexPath.row == 4 && indexPath.section == 3) {
        self.dataModel.sign = textField.text;
    }
    [self.tableView reloadData];
    
}

//获取省份
- (void)getProvinceListData {
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool provinceListURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            
            self.addressArr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}


- (void)updateAvatar:(UIButton *)button {
    if (button.tag == 100) {
      
        self.type = 1;
        
    }else {
        
        self.type = 2;
    }
    
      [self addpic];
}


- (void)addpic {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                if (self.type == 1) {
                    [self.headBt setBackgroundImage:image forState:UIControlStateNormal];
                    Weak(weakSelf);
                    [QQYYRequestTool uploadImagsWithArr:@[image] withType:@"2" result:^(NSString *str) {
                        weakSelf.dataModel.avatar = str;
                        [weakSelf updateHeadImgOrbackImge];
                        
                    }];
                }else {
                    
                    self.backImgV.image = image;
                    Weak(weakSelf);
                    [QQYYRequestTool uploadImagsWithArr:@[image] withType:@"4" result:^(NSString *str) {
                        weakSelf.dataModel.background = str;
                        [weakSelf updateHeadImgOrbackImge];
                    }];
                }
               
                
                
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
               
                if (self.type == 1) {
                    [self.headBt setBackgroundImage:photos[0] forState:UIControlStateNormal];
                    Weak(weakSelf);
                    [QQYYRequestTool uploadImagsWithArr:photos withType:@"2" result:^(NSString *str) {
                        weakSelf.dataModel.avatar = str;
                        [weakSelf updateHeadImgOrbackImge];
                    }];
                }else {
                    
                    self.backImgV.image = photos[0];
                    Weak(weakSelf);
                    [QQYYRequestTool uploadImagsWithArr:photos withType:@"4" result:^(NSString *str) {
                        weakSelf.dataModel.background = str;
                        [weakSelf updateHeadImgOrbackImge];
                    }];
                }
                
                
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


- (void)updateHeadImgOrbackImge {
    
   
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    if(self.type == 1) {
        requestDict[@"type"] = @"avatar";
        requestDict[@"avatar"] = self.dataModel.avatar;
    }else {
        requestDict[@"type"] = @"background";
        requestDict[@"avatar"] = self.dataModel.background;
    }
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool updateAvatarURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


//修改
- (void)xiugGAIAction {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"avatar"] = self.dataModel.avatar;
    requestDict[@"birthday"] = self.dataModel.birthday;
    requestDict[@"gender"] = @(self.dataModel.gender);
    requestDict[@"height"] = self.dataModel.height;
    requestDict[@"weight"] = self.dataModel.weight;
    if (self.dataModel.marriageStatus != 0) {
        requestDict[@"marriageStatus"] = @(self.dataModel.marriageStatus);
    }
    requestDict[@"nickName"] = self.dataModel.nickName;
    if (self.provinceldID.length > 0) {
      requestDict[@"provinceId"] = self.provinceldID;
    }
    if (self.cityID.length > 0) {
      requestDict[@"cityId"] = self.cityID;
    }
    if (self.sexGo != 0) {
       requestDict[@"sexualOrientation"] = @(self.sexGo);
    }
    requestDict[@"sign"] = self.dataModel.sign;
    requestDict[@"tags"] = self.tagIds;
//    requestDict[@""]
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool updateMyInfoURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}



@end
