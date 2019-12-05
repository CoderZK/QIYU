//
//  YJHomeCell.m
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/8.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "YJHomeCell.h"

@implementation YJHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.button.layer.cornerRadius = 4;
    self.button.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
