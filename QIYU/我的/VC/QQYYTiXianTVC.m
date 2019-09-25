//
//  QQYYTiXianTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYTiXianTVC.h"
#import "QQYYTiXianGuiZeVC.h"
#import "QQYYTiXianTwoTVC.h"
#import "QQYYYinHangKaTVC.h"
#import "QQYYAddYinHangKaVC.h"
#import "QQYYTiXianJiLuTVC.h"
@interface QQYYTiXianTVC ()
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UILabel *leftLB,*rightLB;
@end

@implementation QQYYTiXianTVC

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
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight);
    [self initHeadV];
    [self initNav];
    
    
}

- (void)initNav{
    
    UIButton * leftbtn=[[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2 , 40, 40)];
    [leftbtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.tag = 10;
    [self.view addSubview:leftbtn];
    
    UIButton * newClickUpAndInsideBT=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    
    //    [newClickUpAndInsideBT setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [newClickUpAndInsideBT setTitle:@"提现记录" forState:UIControlStateNormal];
    newClickUpAndInsideBT.titleLabel.font = kFont(14);
//    [newClickUpAndInsideBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newClickUpAndInsideBT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    newClickUpAndInsideBT.tag = 11;
     [self.view addSubview:newClickUpAndInsideBT];

    

}

- (void)leftOrRightClickAction:(UIButton *)button {
    if (button.tag == 10) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 11) {
        QQYYTiXianJiLuTVC * vc =[[QQYYTiXianJiLuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 12) {
        QQYYTiXianGuiZeVC * vc =[[QQYYTiXianGuiZeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        QQYYTiXianTwoTVC * vc =[[QQYYTiXianTwoTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.flowerNumber = [NSString stringWithFormat:@"%ld",[self.flowerNumber integerValue]/100];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)initHeadV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH + sstatusHeight)];
    self.headV.backgroundColor =BackgroundColor;
    
    UIView * headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, 270 )];
    headView.backgroundColor  = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:headView.bounds];
    imgV.image = [UIImage imageNamed:@"hhy26"];
    [headView addSubview:imgV];
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, ScreenW - 30, 20)];
    lb.textColor = WhiteColor;
    lb.font = kFont(15);
    lb.text = @"爱豆";
    lb.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:lb];
    self.LB1 = lb;
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 60 +  20 , ScreenW - 30, 40)];
    lb2.textColor = WhiteColor;
    lb2.font = kFont(25);
    lb2.text = [NSString stringWithFormat:@"%@个",self.flowerNumber];
    lb2.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:lb2];
    self.LB2 = lb2;
    
    [self.headV addSubview:headView];
    
    UIView * whiteV =[[UIView alloc] initWithFrame:CGRectMake(0,60 +  20 + 60 , ScreenW, 110)];
    whiteV.backgroundColor = [UIColor clearColor];

    [self.headV addSubview:whiteV];
    
    UIView * view1 =[[UIView alloc] initWithFrame:CGRectMake(15 , 15, (ScreenW - 40 ) / 2, 80)];
    view1.backgroundColor = [UIColor clearColor];
    [whiteV addSubview:view1];
        
    UIView * view2 =[[UIView alloc] initWithFrame:CGRectMake(15 + ((ScreenW - 40 ) / 2 + 10) , 15, (ScreenW - 40 ) / 2, 80)];
    view2.backgroundColor = [UIColor clearColor];
    [whiteV addSubview:view2];
    
    
    self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, view1.width - 20, 20)];
    self.leftLB.text = [NSString stringWithFormat:@"%@个",self.flowerNumber];
    self.leftLB.font = kFont(15);
    self.leftLB.textColor = [UIColor whiteColor];
    self.leftLB.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:self.leftLB];
    
    UILabel * leftLB1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 45, view1.width - 20, 20)];
    leftLB1.font = kFont(14);
    leftLB1.textColor = [UIColor whiteColor];
    leftLB1.textAlignment = NSTextAlignmentCenter;
    leftLB1.text = @"累计爱豆";
    [view1 addSubview:leftLB1];
    
    self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, view1.width - 20, 20)];
    self.rightLB.text = [NSString stringWithFormat:@"%ld个",[self.flowerNumber integerValue]/100 * 100];
    self.rightLB.font = kFont(15);
    self.rightLB.textColor = [UIColor whiteColor];
    self.rightLB.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:self.rightLB];
    
    UILabel * leftLB2 =[[UILabel alloc] initWithFrame:CGRectMake(10, 45, view1.width - 20, 20)];
    leftLB2.font = kFont(14);
    leftLB2.textColor = [UIColor whiteColor];
    leftLB2.textAlignment = NSTextAlignmentCenter;
    leftLB2.text = @"可提现爱豆";
    [view2 addSubview:leftLB2];
    
    
    UIButton * btt = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btt setTitleColor:CharacterRedColor forState:UIControlStateNormal];
    btt.frame = CGRectMake(15, CGRectGetMaxY(headView.frame) + 40, ScreenW - 30, 30);
    [btt setTitle:@"查看《提现规则》" forState:UIControlStateNormal];
    btt.titleLabel.font = kFont(15);
    [btt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btt.tag = 12;
    [self.headV addSubview:btt];
    
    
    UIButton * confirmBt = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmBt.frame = CGRectMake(15, CGRectGetMaxY(btt.frame) + 20 , ScreenW - 30, 44);
    [confirmBt setTitle:@"提现" forState:UIControlStateNormal];
    confirmBt.layer.cornerRadius = 22;
    confirmBt.titleLabel.font = kFont(15);
    confirmBt.clipsToBounds = YES;
    [confirmBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [confirmBt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    confirmBt.tag = 13;
    [self.headV addSubview:confirmBt];
    

    self.tableView.tableHeaderView = self.headV;
    
 
}





@end
