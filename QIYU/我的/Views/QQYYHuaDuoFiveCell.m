//
//  QQYYHuaDuoFiveCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHuaDuoFiveCell.h"

@interface QQYYHuaDuoFiveCell()
@property(nonatomic,strong)huoDuoBt *leftBt,*centerBt,*rightBt;
@end

@implementation QQYYHuaDuoFiveCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat ww = (ScreenW - 40)/3;
        self.leftBt = [[huoDuoBt alloc] initWithFrame:CGRectMake(10, 7.5, ww, 75)];
        
        [self addSubview:self.leftBt];
        
        self.centerBt = [[huoDuoBt alloc] initWithFrame:CGRectMake(15+ ww, 7.5, ww, 75)];
        [self addSubview:self.centerBt];
        
        self.rightBt = [[huoDuoBt alloc] initWithFrame:CGRectMake(20 + 2* ww, 7.5,ww, 75)];
        [self addSubview:self.rightBt];
        
        self.leftBt.tag = 0;
        self.centerBt.tag =1;
        self.rightBt.tag = 2;
        
        [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.centerBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray<QQYYTongYongModel *> *)dataArray {
    _dataArray = dataArray;
    self.leftBt.hidden = self.centerBt.hidden = self.rightBt.hidden = YES;
    if (dataArray.count > 0) {
        self.leftBt.hidden = NO;
        self.leftBt.LB2.text = [NSString stringWithFormat:@"%@个爱豆",dataArray[0].heat];
        if ([dataArray[0].heatGift floatValue] > 0) {
            self.leftBt.LB1.hidden = NO;
            self.leftBt.LB3.hidden = NO;
            self.leftBt.LB3.text = [NSString stringWithFormat:@"赠送%@个爱豆",dataArray[0].heatGift];
        }else {
            self.leftBt.LB1.hidden = YES;
            self.leftBt.LB3.hidden = YES;
        }
        if (dataArray[0].isSelect) {
            [self.leftBt.gouBt setBackgroundImage:[UIImage imageNamed:@"80"] forState:UIControlStateNormal];
        }else {
           [self.leftBt.gouBt setBackgroundImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
        }
        self.leftBt.LB4.text = [NSString stringWithFormat:@"%@元",dataArray[0].price];
    }
    if (dataArray.count > 1) {
        self.centerBt.hidden = NO;
        self.centerBt.LB2.text = [NSString stringWithFormat:@"%@个爱豆",dataArray[1].heat];
        if ([dataArray[1].heatGift floatValue] > 0) {
            self.centerBt.LB1.hidden = NO;
            self.centerBt.LB3.hidden = NO;
            self.centerBt.LB3.text = [NSString stringWithFormat:@"赠送%@个爱豆",dataArray[1].heatGift];
        }else {
            self.centerBt.LB1.hidden = YES;
            self.centerBt.LB3.hidden = YES;
        }
        if (dataArray[1].isSelect) {
            [self.centerBt.gouBt setBackgroundImage:[UIImage imageNamed:@"80"] forState:UIControlStateNormal];
        }else {
            [self.centerBt.gouBt setBackgroundImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
        }
        self.centerBt.LB4.text = [NSString stringWithFormat:@"%@元",dataArray[1].price];
    }
    if (dataArray.count > 2) {
        self.rightBt.hidden = NO;
        self.rightBt.LB2.text = [NSString stringWithFormat:@"%@个爱豆",dataArray[2].heat];
        if ([dataArray[2].heatGift floatValue] > 0) {
            self.rightBt.LB1.hidden = NO;
            self.rightBt.LB3.hidden = NO;
            self.rightBt.LB3.text = [NSString stringWithFormat:@"赠送%@个爱豆",dataArray[2].heatGift];
        }else {
            self.rightBt.LB1.hidden = YES;
            self.rightBt.LB3.hidden = YES;
        }
        if (dataArray[2].isSelect) {
            [self.rightBt.gouBt setBackgroundImage:[UIImage imageNamed:@"80"] forState:UIControlStateNormal];
        }else {
            [self.rightBt.gouBt setBackgroundImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
        }
        self.rightBt.LB4.text = [NSString stringWithFormat:@"%@元",dataArray[2].price];
    }
    
    
    
}

- (void)clickAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickCell:index:)]){
        [self.delegate didClickCell:self index:button.tag];
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation huoDuoBt

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        self.gouBt = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10, 0, 10, 10)];
        [self.gouBt setBackgroundImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
        [self addSubview:self.gouBt];
        
        self.LB1 = [[UILabel alloc] initWithFrame:CGRectMake(-25, 7, 80, 16)];
        self.LB1.backgroundColor = RGB(125, 175, 249);
        self.LB1.textAlignment = NSTextAlignmentCenter;
        self.LB1.text = @"优惠";
        self.LB1.font = kFont(13);
        self.LB1.textColor = WhiteColor;
        [self.LB1 setTransform:CGAffineTransformMakeRotation(-M_PI_4)];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 3;
        [self addSubview:self.LB1];
        
        self.LB2 = [[UILabel alloc] initWithFrame:CGRectMake(2, 12, frame.size.width - 4, 18)];
        self.LB2.font = kFont(14);
        self.LB2.textColor = CharacterBlack40;
        self.LB2.textAlignment = NSTextAlignmentCenter;
        self.LB2.text = @"6000个爱豆";
        [self addSubview:self.LB2];
        
        self.LB3 = [[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetMaxY(self.LB2.frame) , frame.size.width - 4, 18)];
        self.LB3.font = kFont(13);
        self.LB3.textColor = CharacterBackColor;
        self.LB3.textAlignment = NSTextAlignmentCenter;
        self.LB3.text = @"赠送50个";
        [self addSubview:self.LB3];
        
        self.LB4 = [[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetMaxY(self.LB3.frame), frame.size.width - 4, 18)];
        self.LB4.font = kFont(13);
        self.LB4.textColor = CharacterBlack40;
        self.LB4.textAlignment = NSTextAlignmentCenter;
        self.LB4.text = @"60.00元";
        [self addSubview:self.LB4];
        
        self.backgroundColor = RGB(245, 245, 245);
        
    }
    return self;
}

@end
