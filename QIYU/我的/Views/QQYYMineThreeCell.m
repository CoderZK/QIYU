//
//  QQYYMineThreeCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMineThreeCell.h"

@implementation QQYYMineThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5, 25, 25)];
        [self addSubview:self.leftImgV];
        self.rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 18-15, 16, 18, 18)];
        self.rightImgV.image = [UIImage imageNamed:@"more"];
        [self addSubview:self.rightImgV];
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImgV.frame) + 10 , 15, 200, 20)];
        self.leftLB.textColor = CharacterBlack40;
        self.leftLB.font = kFont(14);
        [self addSubview:self.leftLB];
        
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
