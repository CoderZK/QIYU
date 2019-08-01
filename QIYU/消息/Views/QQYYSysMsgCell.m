//
//  QQYYSysMsgCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/7/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYSysMsgCell.h"

@implementation QQYYSysMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.contentLB.textColor = CharacterBlackColor;
    self.timeLB.textColor = CharacterBackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
