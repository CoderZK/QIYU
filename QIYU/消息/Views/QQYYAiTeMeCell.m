//
//  QQYYAiTeMeCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYAiTeMeCell.h"
@interface QQYYAiTeMeCell()
@property(nonatomic,strong)UILabel *contentLB,*timeLB,*nameLB,*contentTwoLB;
@end

@implementation QQYYAiTeMeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        //头像
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 55, 55);
        self.headBt.layer.cornerRadius = 5;
        self.headBt.clipsToBounds = YES;
        //        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
        //        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.headBt.tag = 100;
        //昵称
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 20 , 120, 20)];
        self.nameLB.text = @"GAtsby";
        self.nameLB.font =[UIFont systemFontOfSize:14];
        self.nameLB.textColor = CharacterBlack40;
        [self addSubview:self.nameLB];
        
        //时间
        self.timeLB = [[UILabel alloc] init];
        self.timeLB.text = @"上海 05-06";
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterBackColor;
        [self addSubview:self.timeLB];
        self.timeLB.textAlignment = NSTextAlignmentRight;
        
        [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.headBt.mas_centerY);
            make.width.equalTo(@150);
            make.height.equalTo(@20);
        }];
    
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, CGRectGetMaxY(self.nameLB.frame) + 5, ScreenW - 95, 20)];
        self.contentLB.font = kFont(14);
        self.contentLB.textColor = CharacterBlackColor;
        self.contentLB.text = @"安静万分感激";
        [self addSubview:self.contentLB];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 84.4, ScreenW - 15 -(CGRectGetMaxX(self.headBt.frame) + 10) , 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        
        self.contentTwoLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, CGRectGetMaxY(backV.frame) + 10, ScreenW - 15 -(CGRectGetMaxX(self.headBt.frame) + 10), 20)];
        self.contentTwoLB.font = kFont(14);
        self.contentTwoLB.textColor = CharacterBlackColor;
        self.contentTwoLB.text = @"进而脾气哦我加热我忒UR我狂热和管委会人说点击不藏富于民";
        [self addSubview:self.contentTwoLB];
        
        
        
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
