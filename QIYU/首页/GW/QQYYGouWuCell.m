//
//  QQYYGouWuCell.m
//  QIYU
//
//  Created by zk on 2019/9/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYGouWuCell.h"

@implementation QQYYGouWuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickAction:(UIButton*)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didIndex:withCell:)]) {
        [self.delegate didIndex:sender.tag withCell:self];
    }
    
    
}

@end
