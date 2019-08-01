//
//  QQYYTiXianListCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYTiXianListCell.h"

@implementation QQYYTiXianListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLB.textColor = CharacterBlackColor;
    self.timeLB.textColor = CharacterBackColor;
    self.statusLB.textColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
