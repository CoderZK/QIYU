//
//  QQYYMineFourCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMineFourCell.h"

@interface QQYYMineFourCell()


@end

@implementation QQYYMineFourCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickAction:(UIButton *)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickView:withIndex:)]){
        [self.delegate didClickView:self withIndex:sender.tag - 100];
    }
    
}

- (void)setModel:(QQYYUserModel *)model {
    _model = model;
    
    
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

@end
