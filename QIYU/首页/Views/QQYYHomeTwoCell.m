//
//  QQYYHomeTwoCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHomeTwoCell.h"

@implementation QQYYHomeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 40;
    self.imgV.clipsToBounds = YES;
    self.imgV.contentMode =  UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
