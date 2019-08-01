//
//  QQYYGongGaoOneCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYGongGaoOneCell.h"

@implementation QQYYGongGaoOneCell

- (void)awakeFromNib {
    
    
    [super awakeFromNib];
    self.guanZhuBt.layer.cornerRadius = 17.5;
    self.guanZhuBt.clipsToBounds = YES;
    self.guanZhuBt.layer.borderColor = CharacterRedColor.CGColor;
    self.guanZhuBt.layer.borderWidth = 1.0;
    [self.guanZhuBt setTitleColor:CharacterRedColor forState:UIControlStateNormal];
    
    self.titleLB.textColor  = [UIColor darkGrayColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
