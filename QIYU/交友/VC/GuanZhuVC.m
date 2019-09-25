//
//  GuanZhuVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "GuanZhuVC.h"
#import "QQYYMakeFriendsTVC.h"
#import "QQYYShowView.h"
#import "QQYYFriendsSearchTVC.h"
#import "QQYYMineFriendsTVC.h"
@interface GuanZhuVC ()<UIScrollViewDelegate,QQYYShowViewdelegate>
@property(nonatomic,strong)UIView *whiteV,*topTitleView;
@property(nonatomic,strong)UIButton *leftBt,*rightBt;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)QQYYFriendsSearchTVC *neraTV,*hotTV;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)QQYYShowView *showV;
@end

@implementation GuanZhuVC
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH  - sstatusHeight - 44)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (QQYYShowView *)showV {
    if (_showV == nil) {
        _showV = [[QQYYShowView alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44 , ScreenW, ScreenH - (sstatusHeight + 44))];
        _showV.delegate = self;
    }
    return _showV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectIndex = 0;
    
    [self settitleView];
    
    [self addSubViews];
    [self initNav];
    
}


- (void)settitleView {
    
    self.topTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [self.leftBt setTitle:@"附近的人" forState:UIControlStateNormal];
    self.leftBt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftBt.tag = 100;
    [self.leftBt addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.leftBt];
    

    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 80, 44)];
    [self.rightBt setTitle:@"热度榜" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.rightBt.tag = 101;
    [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBt addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.rightBt];
    
    
    self.whiteV = [[UIView alloc] init];
    self.whiteV.backgroundColor = [UIColor blackColor];
    self.whiteV.mj_y = 40;
    self.whiteV.mj_w = [@"附近的人" getSizeWithMaxSize:CGSizeMake(1000, 1000) withFontSize:18].width;
    self.whiteV.mj_h = 2;
    self.whiteV.centerX = self.leftBt.centerX;
    [self.topTitleView addSubview:self.whiteV];
    self.navigationItem.titleView = self.topTitleView;
    
}

- (void)topTitleAction:(UIButton *)button {
    
    self.whiteV.width = button.titleLabel.width;
    [UIView animateWithDuration:0.1 animations:^{
        self.whiteV.centerX = button.centerX;
    }];
   
    self.selectIndex = button.tag - 100;
    if (button.tag == 100) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else {
        
        if (self.childViewControllers.count <2) {

            self.hotTV = [[QQYYFriendsSearchTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            _hotTV.isHot = YES;
            self.hotTV.view.frame = CGRectMake(ScreenW, 0, ScreenW, self.scrollView.height);
            [self.scrollView addSubview:self.hotTV.view];
            [self addChildViewController:self.hotTV];

        }
        [self.scrollView setContentOffset:CGPointMake(ScreenW, 0) animated:YES];
       
    }

    
}



- (void)addSubViews {
    self.view.backgroundColor = [UIColor greenColor];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    self.neraTV = [[QQYYFriendsSearchTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    _neraTV.isHot = NO;
    self.neraTV.view.frame = CGRectMake(0, 0, ScreenW, self.scrollView.height);
    self.scrollView.contentSize = CGSizeMake(ScreenW * 2, 0);
    [self.scrollView addSubview:self.neraTV.view];
    [self addChildViewController:self.neraTV];
    
    
 

    
}

- (void)initNav{
    
    
    UIButton * leftbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"53"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.tag = 10;

//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
//
//    UIButton * clickBt=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
//
//    [clickBt setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
//    [clickBt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    clickBt.tag = 11;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clickBt];
}
- (void)leftOrRightClickAction:(UIButton *)btn{
    
    if (btn.tag == 10) {
       //搜索
    
        QQYYMineFriendsTVC * vc =[[QQYYMineFriendsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
        QQYYFriendsSearchTVC * vc =[[QQYYFriendsSearchTVC alloc] init];
        vc.isHot = self.selectIndex;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        //检索
//        if(self.selectIndex == 1) {
//        [self.showV showWithTitleArr:@[@"推荐",@"男"] andImgeStrArr:@[@"60",@"nanb",@"nvblack",@"CD",@"FtM",@"MtF",@"40"] selectIndex:3];
//        }else {
//          [self.showV showWithTitleArr:@[@"推荐",@"男"] andImgeStrArr:@[@"60",@"nanb",@"nvblack",@"CD",@"FtM",@"MtF",@"40"] selectIndex:3];
//        }
    }
}

#pragma  mark ---- 点击筛选 -----
- (void)didClickIndex:(NSInteger)index {
 
     [[NSNotificationCenter defaultCenter] postNotificationName:@"DAIBAN" object:nil userInfo:@{@"type":@(self.selectIndex)}];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    if (self.childViewControllers.count <2) {
        
        self.hotTV = [[QQYYFriendsSearchTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        _hotTV.isHot = YES;
        self.hotTV.view.frame = CGRectMake(ScreenW, 0, ScreenW, self.scrollView.height);
        [self.scrollView addSubview:self.hotTV.view];
        [self addChildViewController:self.hotTV];
        
    }
    
    NSInteger aa = scrollView.contentOffset.x / ScreenW;
    self.selectIndex = aa;
    UIButton * button = [self.topTitleView viewWithTag:100 + aa];
    //    if (button.tag == 100) {
    //        self.touPiaoBt.hidden = NO;
    //    }else {
    //        self.touPiaoBt.hidden = YES;
    //    }
    [UIView animateWithDuration:0.1 animations:^{
        self.whiteV.centerX = button.centerX;
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
