//
//  QQYYMineOneCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMineOneCell.h"

@interface QQYYMineOneCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *idLb;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgV;

@end

@implementation QQYYMineOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headBt.layer.cornerRadius = 5;
    self.headBt.clipsToBounds = YES;
    self.nameLB.textColor = WhiteColor;
    self.nameLB.font = [UIFont systemFontOfSize:14 weight:0.2];
    
    
}

- (void)setModel:(QQYYUserModel *)model {
    _model = model;
    
    self.nameLB.text = model.nickName;
    
    if (model.gender == 1) {
        self.sexImgV.image = [UIImage imageNamed:@"nanq"];
    }else {
        self.sexImgV.image = [UIImage imageNamed:@"nvred"];
    }
    
    self.idLb.text = [NSString stringWithFormat:@"ID和邀请码: %@",model.userNo];
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
    
    if (model.flowerNum > 10000) {
        self.flowerLB.text = [NSString stringWithFormat:@"%0.2f万",(long)model.flowerNum/10000.0];
    }else {
        self.flowerLB.text = [NSString stringWithFormat:@"%ld",(long)model.flowerNum];
    }
    
    if (model.subscribeNum > 10000) {
        self.subscribeLB.text = [NSString stringWithFormat:@"%0.2f万",(long)model.subscribeNum/10000.0];
    }else {
        self.subscribeLB.text = [NSString stringWithFormat:@"%ld",(long)model.subscribeNum];
    }
    
    if (model.fansNum>10000) {
        self.fansLB.text = [NSString stringWithFormat:@"%0.2f万",(long)model.fansNum/10000.0];
    }else {
        self.fansLB.text = [NSString stringWithFormat:@"%ld",(long)model.fansNum];
    }
    
    if (model.friendNum > 10000) {
        self.friendsLB.text = [NSString stringWithFormat:@"%0.2f万",(long)model.friendNum/10000.0];
    }else {
        self.friendsLB.text = [NSString stringWithFormat:@"%ld",model.friendNum];
    }
    
    
    
}

- (IBAction)clickAction:(UIButton *)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickHeadView:withIndex:)]){
        [self.delegate didClickHeadView:self withIndex:sender.tag - 100];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
