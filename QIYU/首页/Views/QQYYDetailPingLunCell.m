//
//  QQYYDetailPingLunCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYDetailPingLunCell.h"

@interface QQYYDetailPingLunCell()

@property(nonatomic,strong)UILabel *nameLB,*contentLB,*timeLB;
@end

@implementation QQYYDetailPingLunCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 50, 50);
        self.headBt.layer.cornerRadius = 5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
//        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.headBt.tag = 100;
        //昵称
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10 , 20 , 150, 20)];
        self.nameLB.text = @"来啊";
        self.nameLB.font =[UIFont systemFontOfSize:14];
        self.nameLB.textColor = CharacterBlackColor;
        [self addSubview:self.nameLB];
        
        //时间
        self.timeLB = [[UILabel alloc] init];
        self.timeLB.text = @"2019-05-06";
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterBackColor;
        [self addSubview:self.timeLB];
        self.timeLB.textAlignment = NSTextAlignmentRight;
        
        [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.headBt.mas_centerY);
            make.width.equalTo(@150);
        }];
        
        //内容
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, CGRectGetMaxY(self.nameLB.frame) + 10 , ScreenW - 20 - CGRectGetMaxX(self.headBt.frame) , 20)];
        self.contentLB.numberOfLines = 0;
        self.contentLB.text = @"一起嗨啊";
        self.contentLB.textColor = CharacterBackColor;
        self.contentLB.font = kFont(14);
        [self addSubview:self.contentLB];
        
        
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
