//
//  HomeVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "QQYYHomeTVC.h"
#import "QQYYHomeOneCell.h"
#import "QQYYHomeTwoCell.h"
#import "QQYYHomeThreeCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "QQYYHomeDongTaiCell.h"
#import "zkHomelModel.h"
#import "QQYYDetailTVC.h"
#import "QQYYGongGaoTVC.h"
#import "QQYYReDuTVC.h"
#import "HangQingVC.h"
#import "MineVC.h"
#import "QQYYHomeFiveCell.h"
#import "QQYYMineDongTaiTVC.h"
#import "LxmWebViewController.h"
#import "QQYYMakeFriendsCell.h"
#import "GuanZhuVC.h"

@interface QQYYHomeTVC ()<SDCycleScrollViewDelegate,QQYYHomeDongTaiCellDelegate,QQYYYongBaoViewDeletage,UITabBarControllerDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)SDCycleScrollView *sdcycView;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *scrollDataArray;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,strong)QQYYYongBaoView *showView;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSArray *jiaArr;
@property(nonatomic,assign)NSInteger selectIndex; //tabbar 选中的第几个
@property(nonatomic,assign)NSInteger pageNo,tagId;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArrayDaLei;
@property(nonatomic,assign)NSInteger type; // 1 热度 2 时间 3 关注
@property(nonatomic,assign)BOOL isHot;
@end

@implementation QQYYHomeTVC

- (NSMutableArray<QQYYTongYongModel *> *)scrollDataArray {
    if (_scrollDataArray == nil) {
        _scrollDataArray = [NSMutableArray array];
    }
    return _scrollDataArray;
}

- (QQYYYongBaoView *)showView {
    if (_showView == nil) {
        _showView = [[QQYYYongBaoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showView.deletage = self;
    }
    return _showView;
}

- (NSMutableArray<zkHomelModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
    self.type = 0;
    self.dataArrayDaLei = @[].mutableCopy;
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight);
    
    self.titleArr = @[].mutableCopy;
    self.selectIndex = 0;
    self.tagId = 1;
    [self.tableView registerClass:[QQYYHomeOneCell class] forCellReuseIdentifier:@"cellOne"];
    [self.tableView registerClass:[QQYYHomeThreeCell class] forCellReuseIdentifier:@"cellThree"];
    [self.tableView registerClass:[QQYYHomeDongTaiCell class] forCellReuseIdentifier:@"cellFour"];
    [self.tableView registerClass:[QQYYHomeFiveCell class] forCellReuseIdentifier:@"cellFive"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYHomeTwoCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    [self.tableView registerClass:[QQYYMakeFriendsCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    self.tableView.estimatedSectionFooterHeight = 0;
    
    
    self.tabBarController.delegate = self;
    
    
    
    self.pageNo = 1;
    [self getData];
    [self getBannerData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self getData];
        [self getDataDaLei];
        [self getBannerData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getData];
    }];
    
    [self getDataDaLei];

    
}

- (void)getConfig {
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getIosConfigURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"object"][@"show"]] isEqualToString:@"1"]) {
                [zkSignleTool shareTool].isppp = YES;
            }else {
                [zkSignleTool shareTool].isppp = NO;
            }
                [self setHeadView];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

    
- (void)getData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNo);
    NSString * url = [QQYYURLDefineTool nearbyUserListURL];
    if (self.isHot) {
        url = [QQYYURLDefineTool heatUserListURL];
    }else {
        if ([zkSignleTool shareTool].latitude > 0) {
            dict[@"latitude"] = @([zkSignleTool shareTool].latitude);
            dict[@"longitude"] = @([zkSignleTool shareTool].longitude);
        }
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.tableView.userInteractionEnabled = YES;
        if ([responseObject[@"code"] intValue]== 0) {
            
            NSArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
            if (self.pageNo == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            self.pageNo++;
            [self.tableView reloadData];
            
        }else {
            [self.tableView reloadData];
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.tableView.userInteractionEnabled = YES;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


//设置头视图
- (void)setHeadView {
    
    self.headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, 0)];
    self.headView.clipsToBounds = YES;
    if (isDDDDDDDD) {
        self.headView.mj_h =  200;
    }
    self.headView.backgroundColor  = WhiteColor;
    UIButton * imgBt = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenW * 3/4, ScreenW, 200)];
    [imgBt addTarget:self action:@selector(goShoping) forControlEvents:UIControlEventTouchUpInside];
    [imgBt setBackgroundImage:[UIImage imageNamed:@"400"] forState:UIControlStateNormal];
    self.headView.clipsToBounds = YES;
    [self.headView addSubview:imgBt];
    self.tableView.tableHeaderView = self.headView;
    
    
//    self.headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, ScreenW * 3/4)];
//    self.headView.backgroundColor  = WhiteColor;
//    //    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, ScreenW, Kscale(230))];
//    //    imgV.image = [UIImage imageNamed:@"86"];
//    //    [self.headView addSubview:imgV];
//
//    //    self.scrollDataArray = @[@"http://attachments.gfan.com/forum/201411/29/224352283mf2aaio2madbu.jpg",@"http://pic1.win4000.com/wallpaper/a/52e5ccc6a5f28.jpg",@"http://attach.bbs.miui.com/forum/201312/06/211410sxjtbyaj9abo5qzh.jpg",@"http://img17.3lian.com/d/file/201702/21/2d561f5e226af7b0a222c5432deb6d2a.jpg"].mutableCopy;
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.headView.bounds delegate:self placeholderImage:nil];
//    cycleScrollView.autoScrollTimeInterval = 3;
//    //    cycleScrollView.layer.cornerRadius = 4;
//    //    cycleScrollView.clipsToBounds = YES;
//    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    //    cycleScrollView.pageControlDotSize = CGSizeMake(6, 6);
//    cycleScrollView.currentPageDotColor = [UIColor colorWithRed:80/255.0 green:72/255.0 blue:155/255.0 alpha:1.0];
//    CGFloat aa = 15;
//    cycleScrollView.placeholderImage =[UIImage imageNamed:@"new_picture_default-1"];
//    cycleScrollView.pageDotColor = [UIColor whiteColor];
//    cycleScrollView.localizationImageNamesGroup = @[[UIImage imageNamed:@"a"],[UIImage imageNamed:@"b"],[UIImage imageNamed:@"c"]];
//    self.sdcycView = cycleScrollView;
//    [self.headView addSubview:cycleScrollView];
    
//    self.tableView.tableHeaderView = self.headView;
    
    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
        
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return self.dataArray.count;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 250;
    }else if(indexPath.section == 1){
        return 55;
    }else if (indexPath.section == 2) {
        return 95;
    }
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            QQYYHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellFive" forIndexPath:indexPath];
            cell.dataArray = self.dataArrayDaLei;
            Weak(weakSelf);
            cell.clickIndexBlock = ^(NSInteger index) {
                weakSelf.titleArr = weakSelf.jiaArr[index];
                QQYYMineDongTaiTVC* vc =[[QQYYMineDongTaiTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.circleId = weakSelf.dataArrayDaLei[index].ID;
                vc.titleStr = weakSelf.dataArrayDaLei[index].name;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else {
            QQYYHomeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/79f131b957a2e68fa97510f606eeecda97a7a0bd44d34-gnWqEC_fw658"]];
            cell.clipsToBounds = YES;
            return cell;
        }
    }else if (indexPath.section == 1) {
        __weak typeof(self) weakSelf = self;
        QQYYHomeThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellThree" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.selectIndex = self.type;
        cell.dataArray = self.titleArr;
        cell.clickIndexBlock = ^(NSInteger index) {
            
            if (index == 3) {
                
                GuanZhuVC * vc =[[GuanZhuVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }else {
                weakSelf.type = index;
                weakSelf.pageNo = 1;
                weakSelf.isHot = index;
                [weakSelf.dataArray removeAllObjects];
                weakSelf.tableView.userInteractionEnabled = NO;
                [weakSelf getData];
            }
            
        };
        cell.backgroundColor = WhiteColor;
        return cell;
    }else if (indexPath.section == 2) {
        QQYYMakeFriendsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.headBt.tag = indexPath.row + 100;
        cell.isHot = self.isHot;
        cell.model = self.dataArray[indexPath.row];
        return cell;
        
    }
    
    QQYYHomeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.section == 2) {
//        QQYYDetailTVC * vc =[[QQYYDetailTVC alloc] init];
//        vc.ID = self.dataArray[indexPath.row].postId;
//        Weak(weakSelf);
//        vc.sendZanYesOrNoBlock = ^(BOOL isZan, NSInteger number) {
//            weakSelf.dataArray[indexPath.row].currentUserLike = isZan;
//            weakSelf.dataArray[indexPath.row].likeNum = number;
//            [weakSelf.tableView reloadData];
//        };
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    if (indexPath.section == 2){
        zkHomelModel * model = self.dataArray[indexPath.row];
        
        QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = model.userId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
}

- (void)gotoZhuYeAction:(UIButton *)button {
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataArray[button.tag - 100].userId;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ----- 轮播图的点击 --------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    
    QQYYTongYongModel * model = self.scrollDataArray[index];
    LxmWebViewController *vc = [[LxmWebViewController alloc] init];
    vc.loadUrl = [NSURL URLWithString:model.url];
    vc.navigationItem.title = model.name;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark ------ 点击cell 内部的按钮 ----
//0 头像 1 查看,2 评论 3 赞 ,4送爱豆,5分享 6 点击查看原文
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
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self zanActionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
        
    }else if (index == 4) {
        
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        if ([[zkSignleTool shareTool].session_uid isEqualToString:self.dataArray[indexPath.row].createBy]) {
            [SVProgressHUD showErrorWithStatus:@"自己不能给自己送爱豆"];
            return;
        }
        [self.showView showWithIndexPath:indexPath];
        
    }else if (index == 5) {
        
       [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)] withUrl:nil shareModel:self.dataArray[indexPath.row]];
        
    }else if (index == 6) {
        
    }else if (index == 7) {
        
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self collectionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
    }
    
    
    
    
}

- (void)zanActionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"postId"] = model.postId;
    dict[@"type"] = @"1";
    NSString * url = [QQYYURLDefineTool getlikeURL];
    if (model.currentUserLike) {
        url = [QQYYURLDefineTool notlikeURL];
    }
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            model.currentUserLike = !model.currentUserLike;
            if (model.currentUserLike) {
                model.likeNum = model.likeNum + 1;
            }else {
                model.likeNum = model.likeNum  - 1;
            }
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            
            
            
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
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"targetId"] = self.dataArray[indexPath.row].postId;
    dict[@"type"] = @"2";
    NSString * url = [QQYYURLDefineTool addMyCollectionURL];
    if (model.currentUserCollect) {
        url = [QQYYURLDefineTool deleteMyCollectionURL];
        [zkRequestTool networkingPOST:url parameters:self.dataArray[indexPath.row].postId success:^(NSURLSessionDataTask *task, id responseObject) {
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
        [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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

#pragma  mark ---- 点击 抱一抱 的内容 ----
- (void)didClcikIndex:(NSInteger)index withIndexPath:(NSIndexPath *)indexPath WithNumber:(nonnull NSString *)str{
    
    if (index == 4) {
        [self.showView diss];
        QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        Weak(weakSelf);
        [self sendFlowerWithNumber:str andLinkId:self.dataArray[indexPath.row].postId andIsGiveUser:NO result:^(BOOL isOK) {
            if (isOK) {
                [SVProgressHUD showSuccessWithStatus:@"送爱豆成功!"];
                weakSelf.dataArray[indexPath.row].heat += [str integerValue];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            }
            
            
        }];
    }
    
}


#pragma mark ----- 点击tabbar -----

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    BaseNavigationController * vc = (BaseNavigationController *)viewController;
    
    BaseTableViewController * tvc = (BaseTableViewController *)[vc.childViewControllers firstObject];
    
    if (([tvc isKindOfClass:[HangQingVC class]] || [tvc isKindOfClass:[MineVC class]]) && ![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return NO;
    }
    
    NSLog(@"===\n%@",viewController);
    NSLog(@"+++++\n%@",vc.childViewControllers);
    
    
    
    
    return YES;
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (self.selectIndex == tabBarController.selectedIndex) {
        //重复点击内容
        
    }else {
        self.selectIndex = tabBarController.selectedIndex;
    }
    
    
    NSLog(@"---------\n%d",[self.tabBarController.selectedViewController isEqual:viewController]);
    
    
    
}


- (void)getBannerData {
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getBannerListURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.scrollDataArray = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            NSMutableArray * arr = @[].mutableCopy;
            for (QQYYTongYongModel * model  in self.scrollDataArray) {
                [arr addObject:[QQYYURLDefineTool getImgURLWithStr:model.pic]];
            }
            self.sdcycView.imageURLStringsGroup = arr;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


- (void)getDataDaLei {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getSysSocialCircleListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArrayDaLei = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
