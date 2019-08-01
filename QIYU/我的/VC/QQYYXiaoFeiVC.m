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
@property(nonatomic,strong)UIView *whiteV,*topTitleView;
@property(nonatomic,strong)UIButton *leftBt,*rightBt;
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
    
    [self settitleView];
    
    [self addSubViews];
   
}

- (void)settitleView {
    
    self.topTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [self.leftBt setTitle:@"充值记录" forState:UIControlStateNormal];
    self.leftBt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftBt.tag = 100;
    [self.leftBt addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.leftBt];
    
    
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 80, 44)];
    [self.rightBt setTitle:@"消费记录" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.rightBt.tag = 101;
    [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBt addTarget:self action:@selector(topTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:self.rightBt];
    
    
    self.whiteV = [[UIView alloc] init];
    self.whiteV.backgroundColor = [UIColor blackColor];
    self.whiteV.mj_y = 40;
    self.whiteV.mj_w = [@"充值记录" getSizeWithMaxSize:CGSizeMake(1000, 1000) withFontSize:18].width;
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


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    if (self.childViewControllers.count < 2) {
        
        self.hotTV = [[QQYYXiaoFeiListTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        _hotTV.isChongZhi = NO;
        self.hotTV.view.frame = CGRectMake(ScreenW, 0, ScreenW, self.scrollView.height);
        [self addChildViewController:self.hotTV];
        [self.scrollView addSubview:self.hotTV.view];
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




@end
