//
//  QQYYHuiYuanThreeCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHuiYuanThreeCell.h"

@implementation QQYYHuiYuanThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rightBt.layer.cornerRadius = 18;
    self.rightBt.clipsToBounds = YES;
    self.titleLB.textColor = CharacterBlackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
