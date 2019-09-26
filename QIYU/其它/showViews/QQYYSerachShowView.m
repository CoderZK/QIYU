//
//  QQYYSerachShowView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYSerachShowView.h"

#define spaceX  13
#define spaceY  10



@interface QQYYSerachShowView()
@property(nonatomic,strong)UIView *whiteVOne,*whiteVTwo,*whiteVThree,*whiteVFour,*whiteVThreeTwo;
@property(nonatomic,assign)CGFloat h1,h2,h3,h4;
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSArray<QQYYTongYongModel *> *cityArr;

@end

@implementation QQYYSerachShowView

//此处是用来展示 热度榜的筛选

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.cityArr = @[];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setType:(NSInteger)type {
    _type = type;
}

- (void)setDataArray:(NSMutableArray *)dataArray  {
    
    _dataArray = dataArray;
    if (self.type == 0) {
        //性别
        [self setWVOWithArr:dataArray];
        
    }else if (self.type == 1) {
        //兴趣
        [self setWVTWithArr:dataArray];
    }else if (self.type == 2) {
        //常住地区
        
        [self setProviceArr:dataArray];
        
//        [self setWVTHWithArr:dataArray];
        
    }else if (self.type == 3) {
        //更多
        [self setWVFWithArr:dataArray];
        
    }
    
    
    
    
}



- (void)setWVOWithArr:(NSArray *)arr{
    
    if (self.whiteVOne != nil) {
        [self.whiteVOne.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
        _whiteVOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        _whiteVOne.backgroundColor = WhiteColor;
        _whiteVOne.clipsToBounds = YES;
        
        UIView * confirmV = [self getViewWithButtonTag:100];
        [_whiteVOne addSubview:confirmV];
        CGFloat ww = (ScreenW - 30 - 3 * spaceX) / 4;
        CGFloat hh = 35;
        for (int i = 0;i< arr.count; i++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) , 15 + (spaceY + hh) * (i/4), ww, hh)];
            [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
            button.tag = i+1000;
            button.layer.cornerRadius = 4;
            
            if ([self.sexSelectArr containsObject:@(i+1)]) {
                button.selected = YES;
            }else {
                button.selected = NO;
            }
            
            button.clipsToBounds = YES;
            button.titleLabel.font = kFont(13);
            [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
            [button setTitleColor:WhiteColor forState:UIControlStateSelected];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [_whiteVOne addSubview:button];
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i+1 == arr.count) {
                confirmV.mj_y = 20 + button.mj_y + hh;
            }
            
        }
    
        self.h1 = CGRectGetMaxY(confirmV.frame);
        self.scrollView.contentSize = CGSizeMake(ScreenW, self.h1);
        [self.scrollView addSubview:_whiteVOne];
   
    
    
}

- (void)setWVTWithArr:(NSArray<QQYYTongYongModel *> *)arr {

       if (self.whiteVTwo != nil) {
          [self.whiteVTwo.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
       }
        self.whiteVTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        self.whiteVTwo.backgroundColor = WhiteColor;
        self.whiteVTwo.clipsToBounds = YES;
        UIView * confirmV = [self getViewWithButtonTag:100];
        [self.whiteVTwo addSubview:confirmV];
        
        
        
        CGFloat ww = (ScreenW - 30 - 3 * spaceX) / 4;
        CGFloat hh = 35;
        for (int i = 0;i< arr.count; i++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) , 15 + (spaceY + hh) * (i/4), ww, hh)];
            [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
            button.tag = i+1000;
            button.layer.cornerRadius = 4;
            button.clipsToBounds = YES;
            button.titleLabel.font = kFont(13);
            [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
            [button setTitleColor:WhiteColor forState:UIControlStateSelected];
            [button setTitle:arr[i].name forState:UIControlStateNormal];
            [self.whiteVTwo addSubview:button];
            
            if ([self.biaoQianSelectArr containsObject:[@(i+1) stringValue]]) {
                button.selected = YES;
            }else {
                button.selected = NO;
            }
            
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i+1 == arr.count) {
                confirmV.mj_y = 20 + button.mj_y + hh;
            }
            
        }
        
        self.h2 = CGRectGetMaxY(confirmV.frame);
        self.scrollView.contentSize = CGSizeMake(ScreenW, self.h3);
        [self.scrollView addSubview:self.whiteVTwo];
    
}


//城市省

- (void)setProviceArr:(NSArray<QQYYTongYongModel *> *)arr {
    
    if (self.whiteVThree != nil) {
        [self.whiteVThree.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
        self.whiteVThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        self.whiteVThree.backgroundColor = WhiteColor;
        self.whiteVThree.clipsToBounds = YES;
    
        self.whiteVThreeTwo = [[UIView alloc] init];
        [self.whiteVThree addSubview:self.whiteVThreeTwo];
        [self.whiteVThreeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(@0);
        }];
        
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollEnabled = YES;
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.tag = 900;
        CGFloat space = 8;
        CGFloat hh = 40;
        CGFloat totalW = 0;

        for (int i = 0 ; i < arr.count; i++) {

            CGFloat ww = [arr[i].name getWidhtWithFontSize:14] + 20;
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake( totalW + space , (50 - hh) / 2 , ww , hh )];
            [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
            button.tag = i+2000;
            button.titleLabel.font = kFont(14);
            button.layer.cornerRadius = 4;
            button.clipsToBounds = YES;
            [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
            [button setTitleColor:WhiteColor forState:UIControlStateSelected];
            [button setTitle:arr[i].name forState:UIControlStateNormal];
            [scrollView addSubview:button];
            [button addTarget:self action:@selector(proviceAction:) forControlEvents:UIControlEventTouchUpInside];
            totalW = CGRectGetMaxX(button.frame);
            
            if (self.proviceID != nil && [self.proviceID isEqualToString:arr[i].ID]) {
                button.selected = YES;
                [self getcityArrWithProviceID:self.proviceID];
            }else {
                button.selected = NO;
            }
            
        }

        scrollView.contentSize = CGSizeMake(totalW+8, 50);
        [self.whiteVThree addSubview:scrollView];
        [self.scrollView addSubview:self.whiteVThree];
        UIView * confirmV = [self getViewWithButtonTag:100];
        [self.whiteVThree addSubview:confirmV];
        confirmV.tag = 901;
        confirmV.mj_y = 50;
        self.h3 = CGRectGetMaxY(confirmV.frame);

    
}

//市
- (void)setWVTHWithArr:(NSArray<QQYYTongYongModel *> *)arr {
    
        UIView * confirmV = [self.whiteVThree viewWithTag:901];
        [self.whiteVThreeTwo.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CGFloat ww = (ScreenW - 30 - 3 * spaceX) / 4;
        CGFloat hh = 35;
    
        if (arr.count == 0) {
            confirmV.mj_y = 50;
            self.h3 = CGRectGetMaxY(confirmV.frame);
            [self show];
            
        }
    
        for (int i = 0;i< arr.count; i++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww) * (i%4) , 15 + 45 + (spaceY + hh) * (i/4), ww, hh)];
            [button setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
            button.tag = i+1000;
            button.layer.cornerRadius = 4;
            button.clipsToBounds = YES;
            button.titleLabel.font = kFont(13);
            [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
            [button setTitleColor:WhiteColor forState:UIControlStateSelected];
            [button setTitle:arr[i].name forState:UIControlStateNormal];
            
            if ([self.citySelectArr containsObject:arr[i].ID]) {
                button.selected = YES;
            }else {
                button.selected = NO;
            }
            [self.whiteVThreeTwo addSubview:button];
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i+1 == arr.count) {
                confirmV.mj_y = 20 + button.mj_y + hh;
            }
            
        }
        self.h3 = CGRectGetMaxY(confirmV.frame);
        self.scrollView.contentSize = CGSizeMake(ScreenW, self.h3);
        [self.scrollView addSubview:self.whiteVThree];
        [self show];
    
}

- (void)setWVFWithArr:(NSArray *)arr {
  
    if (self.whiteVFour != nil) {
        [self.whiteVFour.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
        self.whiteVFour = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        self.whiteVFour.backgroundColor = WhiteColor;
        self.whiteVFour.clipsToBounds = YES;
        
        UIView * confirmV = [self getViewWithButtonTag:100];
        [self.whiteVFour addSubview:confirmV];
        CGFloat ww = (ScreenW - 30 - 3 * spaceX) / 4;
        CGFloat hh = 35;
//
//        UIImageView *redOne = [[UIImageView alloc] initWithFrame:CGRectMake(15 , 15, 2, 25)];
//        redOne.image = [UIImage imageNamed:@"backr"];
//        [self.whiteVFour addSubview:redOne];
//        redOne.layer.cornerRadius = 1;
//        redOne.clipsToBounds = YES;
//
//
//        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(27, 15, 150, 25)];
//        lb.textColor = [UIColor blackColor];
//        lb.font = [UIFont systemFontOfSize:15 weight:0.2];
//        lb.text = @"取向";
//        [self.whiteVFour addSubview:lb];
//
        UIImageView *redT = [[UIImageView alloc] initWithFrame:CGRectMake(15 , 15  , 2, 25)];
        redT.image = [UIImage imageNamed:@"backr"];
        [self.whiteVFour addSubview:redT];
        redT.layer.cornerRadius = 1;
        redT.clipsToBounds = YES;
        
        UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(27, 15 , 150, 20)];
        lb2.centerY = redT.centerY;
        lb2.textColor = [UIColor blackColor];
        lb2.font = [UIFont systemFontOfSize:15 weight:0.2];
        lb2.text = @"感情状态";
        [self.whiteVFour addSubview:lb2];
        
        for (int i = 0;i< arr.count; i++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + (spaceX + ww ) * (i%4) , 15 + 40 + (15 + hh + 40) * (i/4), ww, hh)];
            [button setImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"80"] forState:UIControlStateSelected];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
//            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            button.tag = i+1000;
            button.titleLabel.font = kFont(13);
            button.layer.cornerRadius = 4;
            button.clipsToBounds = YES;
            [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
            if ([self.marrSelectArr containsObject:@(i+1)]){
                button.selected = YES;
            }else {
                button.selected = NO;
            }
            [self.whiteVFour addSubview:button];
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i+1 == arr.count) {
                confirmV.mj_y = 20 + button.mj_y + hh;
            }
            
        }
        
        self.h4 = CGRectGetMaxY(confirmV.frame);
        self.scrollView.contentSize = CGSizeMake(ScreenW, self.h4);
        [self.scrollView addSubview:self.whiteVFour];
  
    
    
    
}




//获取确定和取消
- (UIView *)getViewWithButtonTag:(NSInteger )tag {
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = WhiteColor;;
    v.size = CGSizeMake(ScreenW, 75);
    v.mj_x = 0;
    UIButton * cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 110, 35)];

    cancelBt.titleLabel.font = kFont(14);
    [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    cancelBt.tag = 100;
    cancelBt.layer.cornerRadius = 4;
    cancelBt.clipsToBounds = YES;
    [cancelBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:cancelBt];
    
    UIButton * confirmBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 125, 10, 110, 35)];
    [confirmBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    confirmBt.titleLabel.font = kFont(14);
    [confirmBt setTitle:@"确定" forState:UIControlStateNormal];
    confirmBt.tag = 101;
    confirmBt.layer.cornerRadius = 4;
    confirmBt.clipsToBounds = YES;
    [confirmBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:confirmBt];
    
    return v;
}


- (void)proviceAction:(UIButton *)button {
    
    UIScrollView * sss = [self.whiteVThree viewWithTag:900];
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        UIButton * bt = [sss viewWithTag:2000+i];
        if (button.tag == bt.tag) {
            bt.selected = YES;
            QQYYTongYongModel * model = self.dataArray[i];
            self.proviceID = model.ID;
            self.proviceName = model.name;
            [self getcityArrWithProviceID:model.ID];
            
        }else {
            bt.selected = NO;
        }
    }
    
    
}

- (void)getcityArrWithProviceID:(NSString *)ID {
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool cityListURL] parameters:ID success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]== 0) {
            self.cityArr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self setWVTHWithArr:self.cityArr];
            
        }else {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)selectAction:(UIButton *)button {
    
    button.selected =!button.selected;
    
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        if (self.type == 0) {
            self.whiteVOne.mj_h = self.h1;
            self.whiteVTwo.mj_h = 0;
            self.whiteVThree.mj_h = 0;
            self.whiteVFour.mj_h = 0;
        }else if (self.type == 1) {
            self.whiteVTwo.mj_h = self.h2;
            self.whiteVOne.mj_h = 0;
            self.whiteVThree.mj_h = 0;
            self.whiteVFour.mj_h = 0;
        }else if (self.type == 2) {
            self.whiteVThree.mj_h = self.h3;
            self.whiteVOne.mj_h = 0;
            self.whiteVTwo.mj_h = 0;
            self.whiteVFour.mj_h = 0;
        }else if (self.type == 3) {
            self.whiteVFour.mj_h = self.h4;
            self.whiteVOne.mj_h = 0;
            self.whiteVTwo.mj_h = 0;
            self.whiteVThree.mj_h = 0;
        }
    }];
}

- (void)diss {
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteVOne.mj_h = 0;
        self.whiteVTwo.mj_h = 0;
        self.whiteVThree.mj_h = 0;
        self.whiteVFour.mj_h = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//点击确定或者取消
- (void)clickAction:(UIButton *)button {
    [self diss];
    NSMutableArray * arr = @[].mutableCopy;
    NSMutableArray * arrTwo = @[].mutableCopy;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didIsClickConfrimBt:withType:andSelectArr:andSelectNameArr:proviceId:proviceName:)]) {
        
        if (self.type == 0) {
            
            for (int i = 0 ; i <2; i++) {
            
                UIButton * button = [self.whiteVOne viewWithTag:i+1000];
                if (button.selected) {
                    [arr addObject:@(i+1)];
                    [arrTwo addObject:self.dataArray[i]];
                }
            }
        }else if (self.type == 1) {
            for (int i = 0 ; i < self.dataArray.count; i++) {
                
                QQYYTongYongModel *model = self.dataArray[i];
                UIButton * button = [self.whiteVTwo viewWithTag:i+1000];
                if (button.selected) {
                    [arr addObject:model.ID];
                    [arrTwo addObject:model.name];
                }
            }
            
            
        }else if (self.type == 2) {
            
            
            for (int i = 0 ; i < self.cityArr.count; i++) {
                
                QQYYTongYongModel *model = self.cityArr[i];
                UIButton * button = [self.whiteVThree viewWithTag:i+1000];
                if (button.selected) {
                    [arr addObject:model.ID];
                    [arrTwo addObject:model.name];
                }
            }

            
        }else if (self.type == 3) {
            for (int i = 0 ; i <3; i++) {
                
                UIButton * button = [self.whiteVFour viewWithTag:i+1000];
                if (button.selected) {
                    [arr addObject:@(i+1)];
                    [arrTwo addObject:self.dataArray[i]];
                    
                }
            }
        }
        
        [self.delegate didIsClickConfrimBt:button.tag - 100 withType:self.type andSelectArr:arr andSelectNameArr:arrTwo proviceId:self.proviceID proviceName:self.proviceName];
    }
    
    
}



@end
