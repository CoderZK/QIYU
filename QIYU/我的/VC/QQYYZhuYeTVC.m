//
//  QQYYZhuYeTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYZhuYeTVC.h"
#import "QQYYZhuYeOneCell.h"
#import "QQYYZhuYeTwoCell.h"
#import "QQYYZhuYeThreeCell.h"
#import "QQYYZhuYeFourCell.h"
#import "QQYYHomeDongTaiCell.h"
#import "zkHomelModel.h"
#import "QQYYReDuTVC.h"
#import "QQYYMineFriendsTVC.h"
#import "QQYYAddFriendsTVC.h"
#import "QQYYMinePhotoTVC.h"
#import "QQYYXingQuBiaoQianTVC.h"
#import "QQYYKaiTongHuiYuanTVC.h"
@interface QQYYZhuYeTVC ()<QQYYHomeDongTaiCellDelegate,QQYYYongBaoViewDeletage,QQYYHomeDongTaiCellDelegate,QQYYZhuYeTwoCellDelegate>
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3;
@property(nonatomic,strong)UIButton *headBt ,*editBt,*addFriendBt,*attentionBt,*cancelGuanZhuBt;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)zkHomelModel *model;
@property(nonatomic,strong)QQYYYongBaoView *showView;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)QQYYUserModel *dataModel;
@property(nonatomic,strong)UIImageView *backImgV;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,assign)NSInteger type; //是需改头像还是背景
@property(nonatomic,strong)NSString *tags,*tagIds;
@property(nonatomic,assign)CGFloat minY;
@end

@implementation QQYYZhuYeTVC

- (QQYYYongBaoView *)showView {
    if (_showView == nil) {
        _showView = [[QQYYYongBaoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showView.deletage = self;
    }
    return _showView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.pageNo = 1;
    self.dataArray = @[].mutableCopy;
    [self initHeadV];
   
    [self createBackNavigation];
    
    
    [self.tableView registerClass:[QQYYZhuYeOneCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[QQYYZhuYeTwoCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[QQYYZhuYeThreeCell class] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerClass:[QQYYZhuYeFourCell class] forCellReuseIdentifier:@"cell4"];
    [self.tableView registerClass:[QQYYHomeDongTaiCell class] forCellReuseIdentifier:@"cell5"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.titleArr = @[@"",@"个人相册",@"个人信息",@"帖子",@"评论"];
    
    [self acquireDataFromServe];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self acquireDataFromServe];
   
    }];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getTieZiData];
    }];
    
    
}

- (void)createBackNavigation{
    
    UIButton * leftbtn=[[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2 , 40, 40)];
    [leftbtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.tag = 10;
    [self.view addSubview:leftbtn];
    
}

- (void)leftOrRightClickAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initfootView {
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH  - 50 , ScreenW, 50)];
    //    self.footView.backgroundColor = [UIColor greenColor];
    self.footView.backgroundColor = RGB(250, 250, 250);
    [self.view addSubview:self.footView];
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH - 50 + sstatusHeight );
    
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight - 50 - 34);
        self.footView.frame = CGRectMake(0, ScreenH  - 50 - 34, ScreenW, 50);
    }
    
    self.addFriendBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, (ScreenW  - 25)/2, 40)];
    [self.addFriendBt setTitle:@"申请好友" forState:UIControlStateNormal];
    if (self.dataModel.friends) {
        [self.addFriendBt setTitle:@"发送信息" forState:UIControlStateNormal];
    }
    [self.addFriendBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    self.addFriendBt.titleLabel.font = kFont(14);
    [self.footView addSubview:self.addFriendBt];
    self.addFriendBt.tag = 100;
    [self.addFriendBt addTarget:self action:@selector(footAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.attentionBt = [[UIButton alloc] initWithFrame:CGRectMake(10 + 5 +(ScreenW - 25)/2, 5, (ScreenW - 25)/2, 40)];
    [self.attentionBt setTitle:@"关注动态" forState:UIControlStateNormal];
    if (self.dataModel.subscribed) {
        [self.attentionBt setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    [self.attentionBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    self.attentionBt.titleLabel.font = kFont(14);
    [self.footView addSubview:self.attentionBt];
    self.attentionBt.tag = 101;
    [self.attentionBt addTarget:self action:@selector(footAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelGuanZhuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70 - 15, 0, 70, 0)];
    [self.cancelGuanZhuBt setTitle:@"取消关注" forState:UIControlStateNormal];
    self.cancelGuanZhuBt.titleLabel.font = kFont(13);
    [self.cancelGuanZhuBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    [self.tableView addSubview:self.cancelGuanZhuBt];
    self.cancelGuanZhuBt.clipsToBounds = YES;
    [self.cancelGuanZhuBt addTarget:self action:@selector(guanZhuOrNo) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initHeadV {
    UIView * headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, Kscale(192))];
    headView.backgroundColor  = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:headView.bounds];
    imgV.image = [UIImage imageNamed:@"96"];
    [headView addSubview:imgV];
    imgV.clipsToBounds = YES;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    self.backImgV = imgV;
    
    self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 - 40, (Kscale(192) -70)/2 ,70, 70)];
    self.headBt.layer.cornerRadius = 35;
    self.headBt.clipsToBounds = YES;
    self.headBt.tag = 100;
    [headView addSubview:self.headBt];
    [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    
    self.editBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 10, sstatusHeight + 2 ,60, 30)];
    [self.editBt setTitle:@"更换背景" forState:UIControlStateNormal];
    self.editBt.titleLabel.font = kFont(14);
    [self.editBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.editBt addTarget:self action:@selector(updateAvatar:) forControlEvents:UIControlEventTouchUpInside];
    self.editBt.tag = 101;
    
    if ([[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.userId]) {
        [headView addSubview:self.editBt];
         [self.headBt addTarget:self action:@selector(updateAvatar:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        
    }
    
    
    
    self.tableView.tableHeaderView = headView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataModel == nil) {
        return 0;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1 || section == 2 ) {
        return 1;
    }else if (section == 3) {
        if (![[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.userId] && !self.dataModel.friends) {
            return self.dataArray.count > 3?3:self.dataArray.count;
        }else {
            return self.dataArray.count;
        }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 90;
        }else {
            return 70;
        }
    }else if (indexPath.section == 1) {
        if (self.dataModel.photos.length == 0) {
            return 0;
        }
        return (ScreenW - 60) / 4 + 30;
    }else if (indexPath.section == 2) {
//        self.tableView.estimatedRowHeight = 1;
//        return UITableViewAutomaticDimension;
        return self.dataModel.cellHeight;
    }else if (indexPath.section == 3) {
        return self.dataArray.count > 0 ? self.dataArray[indexPath.row].cellHeight:0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            QQYYZhuYeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.xinImgV.image = [UIImage imageNamed:@"19"];
            cell.typeLB.text = @"送爱豆";
            [cell.guanZhuBt  addTarget:self action:@selector(yongBaoAction) forControlEvents:UIControlEventTouchUpInside];
            cell.typeLB.textAlignment = NSTextAlignmentCenter;
            
            if (isDDDDDDDD) {
                cell.xinImgV.hidden = cell.typeLB.hidden = cell.guanZhuBt.hidden = YES;
            }
            
            cell.userModel = self.dataModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            QQYYZhuYeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.model = self.dataModel;
            cell.delegate = self;
            self.minY = cell.frame.origin.y + 12.5 ;
            self.cancelGuanZhuBt.mj_y = self.minY;
            NSLog(@"-----\n%@",NSStringFromCGRect(cell.frame));
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if (indexPath.section ==1){
        QQYYZhuYeThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.dataArray = [self.dataModel.photos componentsSeparatedByString:@","];
        cell.clipsToBounds = YES;
        return cell;
    }else if (indexPath.section ==2) {
        QQYYZhuYeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        cell.titleLB.text = @"标签";
        cell.model = self.dataModel;
        cell.biaoQianLB.text = [NSString stringWithFormat:@"已经选择标签(%lu)",(unsigned long)[self.dataModel.tagsName componentsSeparatedByString:@","].count];
        cell.arr = [self.tags componentsSeparatedByString:@","];
        if ([[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.userId]) {
            cell.gotoImgV.hidden = NO;
        }
        return cell;
    }else if (indexPath.section == 3) {
        QQYYHomeDongTaiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
        cell.delegate = self;
//        self.model = [[zkHomelModel alloc] init];
//        self.model.content = @"ad覅和气温日访客污染费全额外人回复区沃尔夫依噶素服一个我去热饭攻击不是对付一个千万染发膏";
//        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArray[indexPath.row];
        cell.lineV.hidden = YES;
        cell.clipsToBounds = YES;
        return cell;
    }
    
    QQYYZhuYeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else if (section == 1) {
        if (self.dataModel.photos.length == 0) {
            return 0.01;
        }
    }else if (section == 3) {
        if (self.dataArray.count == 0) {
            return 0.01;
        }
        
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headV =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    if (headV == nil) {
        headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        headV.backgroundColor = BackgroundColor;
        UILabel * leftLB  =[[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 40, 20)];
        leftLB.font = kFont(15);
        leftLB.textColor = CharacterBlack40;
        leftLB.tag = 100;
        [headV addSubview:leftLB];
        
        UIButton  * rightBt =[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15 , 10, 60, 30)];
        rightBt.tag = 101;
        [rightBt setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
        rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        rightBt.titleLabel.font = kFont(15);
        [rightBt setTitle:@"编辑" forState:UIControlStateNormal];
        [headV addSubview:rightBt];
        
    }
    
    UIButton * bt =[headV viewWithTag:101];
    [bt addTarget:self action:@selector(gotoPhotos) forControlEvents:UIControlEventTouchUpInside];
    UILabel * lb =(UILabel *)[headV viewWithTag:100];
    lb.text = self.titleArr[section];
    headV.clipsToBounds = YES;
    bt.hidden = YES;
    if (section == 1 ) {
        if ([[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.userId]) {
            bt.hidden = NO;
            lb.text = @"相册";
        }else {
            bt.hidden = YES;
        }
    } else if (section == 2) {
        lb.text = @"个人信息";
    } else if (section == 3) {
        if ( ![[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.userId] && !self.dataModel.friends) {
            lb.text = @"帖子(非好友最多看三条)";
        }else {
         lb.text = @"帖子";
        }
    }
    headV.tag = section;
    return headV;
}

- (void)gotoPhotos {
    
    QQYYMinePhotoTVC * vc =[[QQYYMinePhotoTVC alloc] init];
    vc.photos = self.dataModel.photos;
    if (self.dataModel.isVip) {
        vc.maxPhotos = 20;
    }else {
        vc.maxPhotos = 10;
    }
    Weak(weakSelf);
    vc.sendPhotosBlock = ^(NSString * _Nonnull str) {
        weakSelf.dataModel.photos = str;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:(UITableViewRowAnimationNone)];
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
#pragma mark ------ 点击cell 内部的按钮 ----
//0 头像 1 查看,2 评论 3 赞 ,4送花,5分享 6 点击查看原文
-(void)didClickButtonWithCell:(QQYYHomeDongTaiCell *)cell andIndex:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (index == 0) {
        QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = self.dataArray[indexPath.row].createBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1) {
        
    }else if (index == 2) {
        
    }else if (index == 3) {
        if (![QQYYSignleToolNew shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self zanActionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
        
    }else if (index == 4) {
        
        if (![QQYYSignleToolNew shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        if ([[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.dataArray[indexPath.row].userId]) {
            [SVProgressHUD showErrorWithStatus:@"自己不能给自己送爱豆"];
            return;
        }
        [self.showView showWithIndexPath:indexPath];
        
    }else if (index == 5) {
        
        [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)] withUrl:nil shareModel:self.dataArray[indexPath.row]];
        
    }else if (index == 6) {
        
    }else if (index == 7) {
        
        if (![QQYYSignleToolNew shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self collectionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
    }

}


#pragma mark ------ 点击cell 内部的按钮 关注和粉丝  关注 ----
- (void)didClickGuanZhuOrFansWith:(NSInteger )index {
    
    if (index == 3) {
        
        if (self.dataModel.subscribed) {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.cancelGuanZhuBt.mj_h = 35;
                self.cancelGuanZhuBt.mj_y = self.minY-35;
                
            }];
        }else {
            [self guanZhuOrNo];
        }
        
        return;
        
    }else if (index == 2) {
        
        
        if (isDDDDDDDD) {
            return;
        }
        if ([[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.dataModel.userId]) {
            
            QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            return;
        }
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"送爱豆给他/她 充值买爱豆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"送爱豆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
             [self.showView showWithIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"买爱豆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [ac addAction:action1];
        [ac addAction:action2];
        [ac addAction:action3];
       
        [self.navigationController presentViewController:ac animated:YES completion:nil];
        return;
    }
    
    if (!self.dataModel.currentUserIsVip  && ![[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.dataModel.userId]) {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只有开通Vip会员才能查看他人的关注和粉丝" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"开通会员" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            QQYYKaiTongHuiYuanTVC * vc =[[QQYYKaiTongHuiYuanTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];

        }];
        
        [ac addAction:action1];
        [ac addAction:action2];
        
        [self.navigationController presentViewController:ac animated:YES completion:nil];
        
    }else {
        QQYYMineFriendsTVC * vc =[[QQYYMineFriendsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userNo = self.dataModel.userNo;
        vc.type = index+1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.cancelGuanZhuBt.mj_h = 0;
        self.cancelGuanZhuBt.mj_y = self.minY;
        
    }];
}

- (void)yongBaoAction {
    if ([[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.dataModel.userId]) {
        [SVProgressHUD showErrorWithStatus:@"自己不能给自己送爱豆"];
        return;
    }
    [self.showView showWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
}

#pragma mark ----- 关注或者取消关注------
- (void)guanZhuOrNo {
    
    if (self.dataModel.subscribed) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.cancelGuanZhuBt.mj_h = 0;
            self.cancelGuanZhuBt.mj_y = self.minY;
            
        }];
        
    }
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"type"] = @"1";
    requestDict[@"userId"] = self.userId;
    NSString * url = [QQYYURLDefineTool addUserSubscribeURL];
    if (self.dataModel.subscribed) {
        url = [QQYYURLDefineTool deleteUserSubscribeURL];
    }
    [QQYYRequestTool networkingPOST:url parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataModel.subscribed = !self.dataModel.subscribed;
            
            if (self.dataModel.subscribed) {
                [SVProgressHUD showSuccessWithStatus:@"关注动态成功"];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消关注成功"];
            }
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}


- (void)zanActionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
  
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"postId"] = model.postId;
    requestDict[@"type"] = @"1";
    NSString * url = [QQYYURLDefineTool getlikeURL];
    if (model.currentUserLike) {
        url = [QQYYURLDefineTool notlikeURL];
    }
    [QQYYRequestTool networkingPOST:url parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            model.currentUserLike = !model.currentUserLike;
            if (model.currentUserLike) {
                model.likeNum = model.likeNum + 1;
            }else {
                model.likeNum = model.likeNum  - 1;
            }
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            [self.tableView reloadData];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

//收藏或者取消操作
- (void)collectionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"targetId"] = self.dataArray[indexPath.row].postId;
    requestDict[@"type"] = @"2";
    NSString * url = [QQYYURLDefineTool addMyCollectionURL];
    if (model.currentUserCollect) {
        url = [QQYYURLDefineTool deleteMyCollectionURL];
        [QQYYRequestTool networkingPOST:url parameters:self.dataArray[indexPath.row].postId success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }else {
        [QQYYRequestTool networkingPOST:url parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }
    
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        QQYYDetailTVC * vc =[[QQYYDetailTVC alloc] init];
        vc.ID = self.dataArray[indexPath.row].postId;
        Weak(weakSelf);
        vc.sendZanYesOrNoBlock = ^(BOOL isZan, NSInteger number) {
            weakSelf.dataArray[indexPath.row].currentUserLike = isZan;
            weakSelf.dataArray[indexPath.row].likeNum = number;
            [weakSelf.tableView reloadData];
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)acquireDataFromServe {

    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool gethomeURL] parameters:self.userId success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.model = [zkHomelModel mj_objectWithKeyValues:responseObject[@"object"]];
            self.dataModel = [QQYYUserModel mj_objectWithKeyValues:responseObject[@"object"]];
            [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.dataModel.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
            [self.backImgV sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.dataModel.background]]  placeholderImage:[UIImage imageNamed:@"96"] options:SDWebImageRetryFailed];
            
            self.tags = self.dataModel.tagsName;
            self.tagIds = self.dataModel.tags;
            
            if ([self.dataModel.userId isEqualToString:[QQYYSignleToolNew shareTool].session_uid]) {
                  self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH  + sstatusHeight );
            }else {
                [self initfootView];
            }

            [self getTieZiData];
            
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)getTieZiData {
    
    if (self.pageNo>1 && ![[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.userId] && !self.dataModel.friends) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    //    requestDict[@"tagId"] = @(self.tagId);
    requestDict[@"pageNo"] = @(self.pageNo);
    requestDict[@"pageSize"] = @(10);
    requestDict[@"createBy"] = self.userId;
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool getsearchURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            NSArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
            if (self.pageNo == 1) {
                [self.dataArray removeAllObjects];
            }
            
            [self.dataArray addObjectsFromArray:arr];
            self.pageNo++;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

#pragma  mark ---- 点击 抱一抱 的内容 ----
- (void)didClcikIndex:(NSInteger)index withIndexPath:(NSIndexPath *)indexPath WithNumber:(nonnull NSString *)str{
    
    if (index == 4) {
        [self.showView diss];
        QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        Weak(weakSelf);
        BOOL isUser = YES;
        NSString * linkId = self.userId;
        if (indexPath.section == 3){
            isUser = NO;
            linkId = self.dataArray[indexPath.row].postId;
        }
        
        [self sendFlowerWithNumber:str andLinkId:linkId andIsGiveUser:isUser result:^(BOOL isOK) {
            if (isOK) {
                [SVProgressHUD showSuccessWithStatus:@"送爱豆成功!"];
                
                if (isUser) {
                    if (![self.dataModel.userId isEqualToString:[QQYYSignleToolNew shareTool].session_uid]) {
                        //给他人送花要加花,自己送花不需要
                        weakSelf.dataModel.flowerNum += [str integerValue];
                    }
                }else {
                    
                    self.dataArray[indexPath.row].heat += [str integerValue];
                    if (![self.dataModel.userId isEqualToString:[QQYYSignleToolNew shareTool].session_uid]) {
                        //给他人送花要加花,自己送花不需要
                        weakSelf.dataModel.flowerNum += [str integerValue];
                    }
                    
                }
                
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath,[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
                
            }
            
            
        }];
    }
    
}

#pragma mark ---- 点击添加好友或者关注 -----
- (void)footAction:(UIButton *)button {
    if (button.tag == 100) {
        
        if (self.dataModel.friends) {
            //
            if (self.dataModel.inMyBlackList) {
                [SVProgressHUD showErrorWithStatus:@"对方被你拉黑了,请去我的黑名单左滑操作,然后重新加好友"];
                return;
            }else {
                //去聊天
                
                [self gotoCharWithOtherHuanXinID:self.dataModel.userNo andOtherUserId:self.dataModel.userId andOtherNickName:self.dataModel.nickName andOtherImg:self.dataModel.avatar andVC:self];
                
            }
        }else {
            
            if (!self.dataModel.currentUserIsVip  && ![[QQYYSignleToolNew shareTool].session_uid isEqualToString:self.dataModel.userId]) {
                
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只有开通Vip会员才能添加好友" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"开通会员" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    QQYYKaiTongHuiYuanTVC * vc =[[QQYYKaiTongHuiYuanTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                    
                }];
                
                [ac addAction:action1];
                [ac addAction:action2];
                
                [self.navigationController presentViewController:ac animated:YES completion:nil];
                
            }else {
                //添加好友
                QQYYAddFriendsTVC * vc =[[QQYYAddFriendsTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.model = self.model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }
        
        
    }else {
        
        
        NSMutableDictionary * requestDict = @{}.mutableCopy;
        requestDict[@"type"] = @"1";
        requestDict[@"userId"] = self.userId;
        NSString * url = [QQYYURLDefineTool addUserSubscribeURL];
        if (self.dataModel.subscribed) {
            url = [QQYYURLDefineTool deleteUserSubscribeURL];
        }
        [QQYYRequestTool networkingPOST:url parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                self.dataModel.subscribed = !self.dataModel.subscribed;
                if (self.dataModel.subscribed) {
                    [self.attentionBt setTitle:@"取消关注" forState:UIControlStateNormal];
                }else {
                    [self.attentionBt setTitle:@"关注动态" forState:UIControlStateNormal];
                }
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
        
    }
    
    
}

@end
