//
//  QQYYShowView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYShowView.h"

@interface QQYYShowView()
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation QQYYShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        [self addSubview:button];
        [button addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];

        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(ScreenW - 20 - 130, 30, 130, 0)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.clipsToBounds = YES;
        
        
    }
    return self;
    
}

- (void)setType:(NSInteger)type {
    _type = type;
    self.whiteV.frame = CGRectMake(ScreenW - 20 - 140, sstatusHeight + 44 + 10, 140, 0);
}

- (void)showWithTitleArr:(NSArray *)titleArr andImgeStrArr:(NSArray *)imgeStrArr selectIndex:(NSInteger)index {
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.dataArray = titleArr;
    for (int i = 0 ; i<titleArr.count; i++) {
        
        showBtView * vvv = [[showBtView alloc] initWithFrame:CGRectMake(0, 10 + 40 * i , 130, 40)];
        [self.whiteV addSubview:vvv];
        vvv.button.tag = i;
        if (i == index){
            [vvv showRed];
        }
        if (self.type == 1) {
            vvv.mj_w = 140;
            vvv.imgVOne.hidden = YES;
            vvv.imgVTwo.mj_x = 15;
            vvv.titleLB.mj_x = 55;
            vvv.titleLB.mj_w = 65;
        }
        vvv.imgVTwo.image = [UIImage imageNamed:imgeStrArr[i]];
        vvv.titleLB.text = titleArr[i];
        [vvv.button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self show];
    
    
    
}


- (void)clickAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickIndex:)]) {
        [self diss];
        [self.delegate didClickIndex:button.tag];
    }
}


- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteV.mj_h = self.dataArray.count * 40 + 20 ;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.4];
        
    }completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)diss {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteV.mj_h = 0;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end




@implementation showBtView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgVOne = [[UIImageView alloc] init];
        self.imgVOne.backgroundColor = TabberGreen;
        self.imgVOne.size = CGSizeMake(10, 10);
        self.imgVOne.mj_y = 15;
        self.imgVOne.mj_x = 15;
        self.imgVOne.layer.cornerRadius = 5;
        self.imgVOne.clipsToBounds = YES;
        [self addSubview:self.imgVOne];
        
        self.imgVTwo = [[UIImageView alloc] init];
//        self.imgVTwo.backgroundColor = TabberGreen;
        self.imgVTwo.size = CGSizeMake(25, 25);
        self.imgVTwo.mj_y = 7.5;
        self.imgVTwo.mj_x = CGRectGetMaxX(self.imgVOne.frame) + 15;
        self.imgVTwo.clipsToBounds = YES;
        [self addSubview:self.imgVTwo];
        
        self.titleLB  = [[UILabel alloc] init];
        self.titleLB.mj_x = CGRectGetMaxX(self.imgVTwo.frame);
        self.titleLB.width = 50;
        self.titleLB.mj_y = 10 ;
        self.titleLB.height = 20;
        self.titleLB.font = kFont(15);
        self.titleLB.tintColor = CharacterBlackColor;
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLB];
        self.imgVOne.hidden = YES;
        
        self.button = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:self.button];
        
        
    }
    return self;
}

- (void)showRed {
    self.imgVOne.hidden = NO;
}


@end
