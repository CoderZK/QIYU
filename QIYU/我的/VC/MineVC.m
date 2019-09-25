//
//  MineVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "MineVC.h"
#import "QQYYMineOneCell.h"
#import "QQYYMineTwoCell.h"
#import "QQYYMineThreeCell.h"
#import "QQYYMineFourCell.h"
#import "QQYYMineFriendsTVC.h"
#import "QQYYReDuTVC.h"
#import "QQYYKaiTongHuiYuanTVC.h"
#import "QQYYZhuYeTVC.h"
#import "QQYYXiuGaiZiLiaoTVC.h"
#import "QQYYMineCollectTVC.h"
#import "QQYYMinePhotoTVC.h"
#import "QQYYMineDongTaiTVC.h"
#import "QQYYMineTaskTVC.h"
#import "QQYYShiMingRenZhengTVC.h"
#import "QQYYXiaoFeiVC.h"
#import "QQYYYiJianTVC.h"
#import "QQYYTiXianTVC.h"
#import "QQYYSettingTVC.h"
@interface MineVC ()<QQYYMineFourCellDelegate,QQYYMineOneCellDelegate>
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)QQYYUserModel *dataModel;
@end

@implementation MineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self acquireDataFromServe];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人中心";
    
    [self.tableView registerClass:[QQYYMineThreeCell class] forCellReuseIdentifier:@"cellThree"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYMineOneCell" bundle:nil] forCellReuseIdentifier:@"cellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYMineTwoCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYMineFourCell" bundle:nil] forCellReuseIdentifier:@"cellFour"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.titleArr = @[@[],@[@"开通会员"],@[@"我的主页",@"我的动态",@"谁看过我",@"我的相册",@"我的收藏",@"我的黑名单"],@[@"任务中心",@"实名认证",@"会员服务",@"我的订单",@"我的提现",@"意见反馈"]];
    
    
    UIButton * clickBt=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 24 -15 , sstatusHeight + 10 , 24, 24)];
    [clickBt setBackgroundImage:[UIImage imageNamed:@"85"] forState:UIControlStateNormal];
    [clickBt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    clickBt.tag = 11;
    [self.view addSubview:clickBt];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight);
}

- (void)acquireDataFromServe {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getMyInfoCenterURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.dataModel = [QQYYUserModel mj_objectWithKeyValues:responseObject[@"object"]];
            [zkSignleTool shareTool].nickName = self.dataModel.nickName;
            [zkSignleTool shareTool].img = self.dataModel.avatar;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


//设置
- (void)leftOrRightClickAction:(UIButton *)button {
    
    QQYYSettingTVC  * vc =[[QQYYSettingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.phoneStr = self.dataModel.phone;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section <2) {
        return 1;
    }
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * footV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    if (footV == nil) {
        footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        footV.backgroundColor = BackgroundColor;
    }
    return footV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == 1 && indexPath.row == 0 && isDDDDDDDD) || (indexPath.section == 3 && indexPath.row == 2 && isDDDDDDDD) ||(indexPath.section == 3 && indexPath.row == 3 && isDDDDDDDD)||(indexPath.section == 3 && indexPath.row == 4 && isDDDDDDDD)){
        return 0;
    }
    
    if (indexPath.section == 0) {
        return 260;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QQYYMineOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headBt addTarget:self action:@selector(gotoZhuYe) forControlEvents:UIControlEventTouchUpInside];
        [cell.ccopyBt addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
        cell.model = self.dataModel;
        cell.delegate = self;
        cell.imgV.hidden = !self.dataModel.isVip;
        return cell;
    }else {
        QQYYMineThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellThree" forIndexPath:indexPath];
        cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"qy%ld-%ld",indexPath.section,indexPath.row]];
        cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        QQYYKaiTongHuiYuanTVC * vc =[[QQYYKaiTongHuiYuanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.nickName = self.dataModel.nickName;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self gotoZhuYe];
        }else if (indexPath.row == 1) {
            QQYYMineDongTaiTVC * vc =[[QQYYMineDongTaiTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isMine = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            
            if (!self.dataModel.isVip) {
               
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只有开通Vip会员才能查看谁看过我" preferredStyle:UIAlertControllerStyleAlert];
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
                
                
            }
            
            QQYYMineFriendsTVC * vc =[[QQYYMineFriendsTVC alloc] init];
            vc.type = 3;
            vc.userNo = self.dataModel.userNo;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 3) {
            
            QQYYMinePhotoTVC * vc =[[QQYYMinePhotoTVC alloc] init];
            vc.photos = self.dataModel.photos;
            if (self.dataModel.isVip) {
                vc.maxPhotos = 20;
            }else {
                vc.maxPhotos = 10;
            }
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 4) {
            QQYYMineCollectTVC * vc =[[QQYYMineCollectTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 5) {
            QQYYMineFriendsTVC * vc =[[QQYYMineFriendsTVC alloc] init];
            vc.type = 4;
            vc.userNo = self.dataModel.userNo;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section ==3) {
        if (indexPath.row == 0) {
            QQYYMineTaskTVC * vc =[[QQYYMineTaskTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            QQYYShiMingRenZhengTVC * vc =[[QQYYShiMingRenZhengTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            
            QQYYKaiTongHuiYuanTVC * vc =[[QQYYKaiTongHuiYuanTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.nickName = self.dataModel.nickName;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 3) {
            
            QQYYXiaoFeiVC * vc =[[QQYYXiaoFeiVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 4) {
           
            QQYYTiXianTVC * vc =[[QQYYTiXianTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.flowerNumber = [NSString stringWithFormat:@"%ld",self.dataModel.flowerNum];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else if (indexPath.row == 5) {
            QQYYYiJianTVC * vc =[[QQYYYiJianTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}

- (void)didClickHeadView:(QQYYMineOneCell *)cell withIndex:(NSInteger )index {
    
    if (index == 4) {
        QQYYXiuGaiZiLiaoTVC * vc =[[QQYYXiuGaiZiLiaoTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (index == 3) {
        if (isDDDDDDDD) {
            return;
        }
        QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        QQYYMineFriendsTVC * vc =[[QQYYMineFriendsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userNo = self.dataModel.userNo;
        vc.type = index;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


//复制
- (void)copyAction {
    [SVProgressHUD showSuccessWithStatus:@"已经复制到粘贴板"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.dataModel.userNo;
    
}

//去主页
- (void)gotoZhuYe{
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataModel.userId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- 点击了会员和修改资料 ----
- (void)huiYuanOrZiLiaoAction:(UIButton *)button {
    if (button.tag == 100) {
        //点击了开通会员
        QQYYKaiTongHuiYuanTVC * vc =[[QQYYKaiTongHuiYuanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.nickName = self.dataModel.nickName;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //点击了修改资料
        QQYYXiuGaiZiLiaoTVC * vc =[[QQYYXiuGaiZiLiaoTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

#pragma mark ---- 点击了关注粉丝一栏 -----
- (void)didClickView:(QQYYMineFourCell *)cell withIndex:(NSInteger)index {
    if (index == 3) {
        if (isDDDDDDDD) {
            return;
        }
        QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        QQYYMineFriendsTVC * vc =[[QQYYMineFriendsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userNo = self.dataModel.userNo;
        vc.type = index;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
