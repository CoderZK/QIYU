//
//  QQYYPingLunTwoCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYPingLunTwoCell.h"

@implementation QQYYPingLunTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 5;
    self.headBt.clipsToBounds = YES;
    [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    self.nameLB.textColor = CharacterBlackColor;
    self.nameLB.font = [UIFont systemFontOfSize:14 weight:0.2];
    self.contentLB.textColor = CharacterBlackColor;
    self.contentLB.font = kFont(13);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
