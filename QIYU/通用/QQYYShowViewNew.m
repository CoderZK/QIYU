//
//  QQYYShowViewNew.m
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYShowViewNew.h"
#import <MJRefresh.h>
#define ssHH [UIApplication sharedApplication].statusBarFrame.size.width
#define HHHHHH [UIScreen mainScreen].bounds.size.height
#define WWWWW [UIScreen mainScreen].bounds.size.width
@implementation QQYYShowViewNew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.HeiSeBlackViewNew = [[UIView alloc] init];
        self.HeiSeBlackViewNew.backgroundColor =[UIColor colorWithWhite:1 alpha:1.0];
        self.HeiSeBlackViewNew.mj_w = frame.size.width;
        self.HeiSeBlackViewNew.mj_h = 280;
        self.HeiSeBlackViewNew.mj_x = 0;
        self.HeiSeBlackViewNew.mj_y = HHHHHH;
        [self addSubview:self.HeiSeBlackViewNew];
        
    }
    
    return self;
}


- (void)addViews {
    
    CGFloat ww = 70;
    CGFloat space = (WWWWW - 4*ww)/5;
    
    NSArray * arr = @[@"灵魂伴侣",@"因材施教",@"萝莉大叔",@"答疑解惑",@"志同道合",@"花花世界",@"秘密花园",@"面经交流"];
    for (int i = 0 ; i < arr.count ; i++) {
        
        UIButton * newBTBT =[[UIButton alloc] initWithFrame:CGRectMake(space + (space + ww) * (i % 4), 15 + (ww +10+ 15) * (i /4) , ww, ww+10)];
        newBTBT.tag = i;
        [newBTBT setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"sybj%d",i]] forState:UIControlStateNormal];
        [newBTBT addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * imgV =[[UIImageView alloc] initWithFrame:CGRectMake((ww - 30)/2, 15, 30, 30)];
        imgV.image =[UIImage imageNamed: [NSString stringWithFormat:@"%d",i]];
        [newBTBT addSubview:imgV];
        UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(0, 55, ww, 20)];
        lb.text = arr[i];
        //        lb.textColor = [UIColor colorWithRed:100/225.0 green:100/225.0 blue:100/225.0 alpha:1.0];
        lb.font =[UIFont systemFontOfSize:14];
        lb.textColor = CharacterBlackColor;
        lb.textAlignment = NSTextAlignmentCenter;
        [newBTBT addSubview:lb];
        
        [self.HeiSeBlackViewNew addSubview:newBTBT];
        
    }
    
}


- (void)setDataArray:(NSMutableArray<QQYYTongYongModel *> *)dataArray {
    _dataArray = dataArray;
    [self.HeiSeBlackViewNew.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = 70;
    CGFloat space = (WWWWW - 4*ww)/5;
    
    for (int i = 0 ; i < self.dataArray.count ; i++) {
        
        UIButton * newBTBT =[[UIButton alloc] initWithFrame:CGRectMake(space + (space + ww) * (i % 4), 15 + 50+ (ww + 15) * (i /4) , ww, ww)];
        newBTBT.tag = i+100;
        //        [newBTBT setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"sybj%d",i]] forState:UIControlStateNormal];
        [newBTBT addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * imgV =[[UIImageView alloc] initWithFrame:CGRectMake((ww - 30)/2, 15, 30, 30)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:self.dataArray[i].icon]] placeholderImage:[UIImage imageNamed: [NSString stringWithFormat:@"%d",i]] options:SDWebImageRetryFailed];
        [newBTBT addSubview:imgV];
        
        
        UIImageView * imgVTwo =[[UIImageView alloc] initWithFrame:CGRectMake(ww - 15, 0, 15, 15)];
        imgVTwo.tag = 300+i;
        [newBTBT addSubview:imgVTwo];
        imgVTwo.image = [UIImage imageNamed:@"78"];
        
        
        UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(0, 55, ww, 20)];
        lb.text = self.dataArray[i].name;
        //        lb.textColor = [UIColor colorWithRed:100/225.0 green:100/225.0 blue:100/225.0 alpha:1.0];
        lb.font =[UIFont systemFontOfSize:14];
        lb.textColor = CharacterBlackColor;
        lb.textAlignment = NSTextAlignmentCenter;
        [newBTBT addSubview:lb];
        
        [self.HeiSeBlackViewNew addSubview:newBTBT];
        
    }
    
    UIButton * newBTBT =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, WWWWW, HHHHHH - 280)];
    [newBTBT addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:newBTBT];
    
    UIButton * cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
    cancelBt.titleLabel.font = kFont(14);
    [cancelBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    [self.HeiSeBlackViewNew addSubview:cancelBt];
    [cancelBt addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * confirmBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60- 10, 10, 60, 30)];
    [confirmBt setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    [self.HeiSeBlackViewNew addSubview:confirmBt];
    [confirmBt addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    confirmBt.titleLabel.font = kFont(14);
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, ScreenW - 140, 30)];
    lb.textColor = CharacterBlackColor;
    lb.font = [UIFont systemFontOfSize:15 weight:0.2];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"选择圈子";
    [self.HeiSeBlackViewNew addSubview:lb];
    
}


- (void)confirmAction {
    
    NSMutableArray * arr = @[].mutableCopy;
    NSMutableArray * arrTwo = @[].mutableCopy;
    NSMutableArray * arrThree = @[].mutableCopy;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        
        UIButton * newBTBT = [self.HeiSeBlackViewNew viewWithTag:i+100];
        if (newBTBT.selected) {
            [arr addObject:self.dataArray[i]];
            [arrTwo addObject:self.dataArray[i].name];
            [arrThree addObject:self.dataArray[i].ID];
        }
        
    }
    
    if (arr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"至少选择一个圈子"];
        return;
    }
    
    [self diss];
    
    
    if (self.deleate != nil && [self.deleate respondsToSelector:@selector(didSelctStr:idStr:)]){
        
        [self.deleate didSelctStr:[arrTwo componentsJoinedByString:@","] idStr:[arrThree componentsJoinedByString:@","]];
        
    }
    
}

- (void)action:(UIButton *)newBTBT {
    
    newBTBT.selected = !newBTBT.selected;
    
    UIImageView * imgV = [self.HeiSeBlackViewNew viewWithTag:200+newBTBT.tag];
    if (newBTBT.selected) {
        imgV.image =[UIImage imageNamed:@"80"];
    }else {
        imgV.image =[UIImage imageNamed:@"78"];
    }
    
    
    
}

- (void)show {
    
    self.isShow = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        if ( ssHH > 20) {
            self.HeiSeBlackViewNew.mj_y = HHHHHH - 280  - 34 + 44;
        }else {
            self.HeiSeBlackViewNew.mj_y = HHHHHH - 280  + 44;
            
        }
        
    }];
    
    
    
    
}

- (void)diss{
    self.isShow = NO;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.HeiSeBlackViewNew.mj_y = self.frame.size.height;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
    
    
}


@end
