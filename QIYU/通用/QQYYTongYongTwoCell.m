//
//  QQYYTongYongTwoCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYTongYongTwoCell.h"

@implementation QQYYTongYongTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
        self.leftLB.font = kFont(15);
        self.leftLB.textColor = CharacterBlack40;
        [self addSubview:self.leftLB];
        
        self.TF = [[UITextField alloc] initWithFrame:CGRectMake(170 , 10, ScreenW - 185 - 30, 30)];
        self.TF.textAlignment = NSTextAlignmentRight;
        self.TF.placeholder = @"请填写或选择";
        self.TF.textColor = CharacterBlack40;
        self.TF.font = kFont(14);
        [self addSubview:self.TF];
        self.TF.userInteractionEnabled = NO;
        
        self.moreImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 35, 15, 20, 20)];
        [self addSubview:self.moreImgV];
        self.moreImgV.image = [UIImage imageNamed:@"more"];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 49.4, ScreenW-30, 0.6)];
        backV.backgroundColor = [UIColor clearColor];
        [self addSubview:backV];
        self.lineV = backV;

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
