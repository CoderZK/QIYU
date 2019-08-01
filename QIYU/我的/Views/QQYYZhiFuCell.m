//
//  QQYYZhiFuCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYZhiFuCell.h"

@implementation QQYYZhiFuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        self.leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        [self addSubview:self.leftImgV];
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 150, 40)];
        self.titleLB.font = kFont(15);
        self.titleLB.textColor = CharacterBlack40;
        [self addSubview:self.titleLB];
        self.rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 20 -15 , 25, 20, 20)];
        [self addSubview:self.rightImgV];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
