//
//  QQYYGuanZhuHeadTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYGuanZhuHeadTVC.h"

@interface QQYYGuanZhuHeadTVC ()
@property(nonatomic,strong)UIView *headV;

@end

@implementation QQYYGuanZhuHeadTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"赞列表";
//    self.dataArray =  @[@"http://pic18.nipic.com/20120204/8339340_144203764154_2.jpg",@"http://pic31.nipic.com/20130801/11604791_100539834000_2.jpg",@"http://pic15.nipic.com/20110629/5078207_164705330000_2.jpg",@"http://pic18.nipic.com/20120204/8339340_144203764154_2.jpg",@"http://pic31.nipic.com/20130801/11604791_100539834000_2.jpg",@"http://pic15.nipic.com/20110629/5078207_164705330000_2.jpg",@"http://pic18.nipic.com/20120204/8339340_144203764154_2.jpg",@"http://pic31.nipic.com/20130801/11604791_100539834000_2.jpg",@"http://pic15.nipic.com/20110629/5078207_164705330000_2.jpg"].mutableCopy;
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.tableHeaderView = self.headV;
    
    [self setViewS];
    
}


- (void)setViewS {
 
    CGFloat ww = 50;
    
    CGFloat space = (ScreenW - ww*5) / 6;
    CGFloat ww2 = ww + space ;
    
    CGFloat spaceY = 15;
    
    for ( int i = 0 ; i < self.dataArray.count; i++) {
        
        UIButton * button = [[UIButton alloc] init];
        button.size = CGSizeMake(ww, ww);
        button.mj_x = space + (space + ww) * (i % 5);
        button.mj_y = 15 + (spaceY + ww + 25) * (i/5);
        button.layer.cornerRadius = ww/2;
        button.clipsToBounds = YES;
        button.tag = i;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.dataArray[i].avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
        [self.headV addSubview:button];
        
        
        UILabel * lb =[[UILabel alloc] init];
        lb.textColor = [UIColor blackColor];
        lb.font = kFont(13);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = self.dataArray[i].nickName;
        lb.size = CGSizeMake(ww2, 20);
        lb.mj_y = CGRectGetMaxY(button.frame) + 5;
        lb.mj_x = CGRectGetMinX(button.frame) - space/2;
        [self.headV addSubview:lb];
        
        if (i + 1 == self.dataArray.count) {
         
            if (CGRectGetMaxY(lb.frame) > ScreenH) {
                self.headV.mj_h = CGRectGetMaxY(lb.frame) + 40;
            }
        }
        
    }
    
    
    
}

- (void)clickAction:(UIButton *)button {
    
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    if (self.isQuanZi) {
       vc.userId = self.dataArray[button.tag].userId;
    }else {
        vc.userId = self.dataArray[button.tag].createBy;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
