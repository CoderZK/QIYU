//
//  QQYYXiaoFeiVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYXiaoFeiVC.h"
#import "QQYYXiaoFeiListTVC.h"
@interface QQYYXiaoFeiVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView *blackAndWihteView,*topTitleView;
@property(nonatomic,strong)UIButton *BTBTLeft,*BTBTRightNew;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)QQYYXiaoFeiListTVC *neraTV,*hotTV;
@property(nonatomic,assign)NSInteger selectIndex;
@end

@implementation QQYYXiaoFeiVC
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = 0;
    [self addTitleVIewNew];
    [self addSubViews];
   
}



- (void)topTitleAction:(UIButton *)BBTTnew {
    
    self.blackAndWihteView.width = BBTTnew.titleLabel.width;
    [UIView animateWithDuration:0.1 animations:^{
        self.blackAndWihteView.centerX = BBTTnew.centerX;
    }];
    
    self.selectIndex = BBTTnew.tag - 100;
    if (BBTTnew.tag == 100) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else {
        if (self.childViewControllers.count < 2) {
            
            self.hotTV = [[QQYYXiaoFeiListTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            _hotTV.isChongZhi = NO;
            self.hotTV.view.frame = CGRectMake(ScreenW, 0, ScreenW, self.scrollView.height);
            [self addChildViewController:self.hotTV];
            [self.scrollView addSubview:self.hotTV.view];
        }        
        [self.scrollView setContentOffset:CGPointMake(ScreenW, 0) animated:YES];
    }
    
    
}

- (void)addTitleVIewNew {
    self.topTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    self.BTBTLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [self.BTBTLeft setTitle:@"充值记录" forState:UIControlStateNormal];
    self.BTBTLeft.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.BTBTLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.BTBTLeft.tag = 100;
    [self.BTBTLeft addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.BTBTLeft];

    self.BTBTRightNew = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 80, 44)];
    [self.BTBTRightNew setTitle:@"消费记录" forState:UIControlStateNormal];
    self.BTBTRightNew.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.BTBTRightNew.tag = 101;
    [self.BTBTRightNew setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BTBTRightNew addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.BTBTRightNew];
    self.blackAndWihteView = [[UIView alloc] init];
    self.blackAndWihteView.backgroundColor = [UIColor blackColor];
    self.blackAndWihteView.mj_y = 40;
    self.blackAndWihteView.mj_w = [@"充值记录" getSizeWithMaxSize:CGSizeMake(1000, 1000) withFontSize:18].width;
    self.blackAndWihteView.mj_h = 2;
    self.blackAndWihteView.centerX = self.BTBTLeft.centerX;
    [self.topTitleView addSubview:self.blackAndWihteView];
    self.navigationItem.titleView = self.topTitleView;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.childViewControllers.count < 2) {
        self.hotTV = [[QQYYXiaoFeiListTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        _hotTV.isChongZhi = NO;
        self.hotTV.view.frame = CGRectMake(ScreenW, 0, ScreenW, self.scrollView.height);
        [self addChildViewController:self.hotTV];
        [self.scrollView addSubview:self.hotTV.view];
    }
    NSInteger aa = scrollView.contentOffset.x / ScreenW;
    self.selectIndex = aa;
    UIButton * BBTTnew = [self.topTitleView viewWithTag:100 + aa];
    [UIView animateWithDuration:0.1 animations:^{
        self.blackAndWihteView.centerX = BBTTnew.centerX;
    }];
    
}

- (void)addSubViews {
    self.view.backgroundColor = [UIColor greenColor];
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
    self.neraTV = [[QQYYXiaoFeiListTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    _neraTV.isChongZhi = YES;
    self.neraTV.view.frame = CGRectMake(0, 0, ScreenW, self.scrollView.height);
    self.scrollView.contentSize = CGSizeMake(ScreenW * 2, 0);
    [self.scrollView addSubview:self.neraTV.view];
    [self addChildViewController:self.neraTV];

}

@end
