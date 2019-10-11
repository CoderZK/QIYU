//
//  QQYYNewsTwoCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYNewsTwoCell.h"

@interface QQYYNewsTwoCell()

@end

@implementation QQYYNewsTwoCell

- (void)setModel:(QQYYTongYongModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:model.createByAvatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
     [self.bageBt setBadge:[NSString stringWithFormat:@"%ld",(long)model.unreadMessagesCount] andFont:10];
    self.nameLB.text = model.createByNickName;
    self.contentLB.text = model.remark;
    self.timeLB.text = [NSString stringWithTime:model.createTime];
  
    if (self.type == 0) {
        if (model.status == 1) {
            self.cancelBt.hidden = self.typeBt.hidden = NO;
            [self.cancelBt setTitle:@"拒绝" forState:UIControlStateNormal];
            [self.typeBt setTitle:@"同意" forState:UIControlStateNormal];
        }else if (model.status == 2) {
            self.cancelBt.hidden = YES;
            self.typeBt.hidden = NO;
            [self.typeBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.typeBt setTitle:@"已通过" forState:UIControlStateNormal];
        }else {
            self.cancelBt.hidden = YES;
            self.typeBt.hidden = NO;
            [self.typeBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.typeBt setTitle:@"已拒绝" forState:UIControlStateNormal];
        }
    }else {
      
        self.nameLB.text = model.friendNickName;
        self.contentLB.text = model.chatContent;

    }

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        
        //头像
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 55, 55);
        self.headBt.layer.cornerRadius = 5;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        self.headBt.tag = 100;
        
        self.bageBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 55, 55)];
        [self addSubview:self.bageBt];
        self.bageBt.userInteractionEnabled = NO;
        
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
            make.centerY.equalTo(self.headBt.mas_centerY).offset(-12);
            make.width.equalTo(@150);
            make.height.equalTo(@20);
        }];
        
        
        self.cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70  -  60 , 42, 50, 25)];
        [self.cancelBt setTitle:@"拒绝" forState:UIControlStateNormal];
        self.cancelBt.titleLabel.font = kFont(14);
        [self.cancelBt setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        [self.cancelBt setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
        [self addSubview:self.cancelBt];
        self.cancelBt.hidden = YES;
        self.cancelBt.layer.cornerRadius = 3;
        self.cancelBt.clipsToBounds = YES;

        
        self.typeBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 65 , 42, 50, 25)];
        [self.typeBt setTitle:@"同意" forState:UIControlStateNormal];
        self.typeBt.titleLabel.font = kFont(14);
        [self.typeBt setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
        [self addSubview:self.typeBt];
        [self.typeBt setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        self.typeBt.hidden = YES;
        self.typeBt.layer.cornerRadius = 3;
        self.typeBt.clipsToBounds = YES;
//        self.typeBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, CGRectGetMaxY(self.nameLB.frame) + 5, ScreenW - 95, 20)];
        self.contentLB.font = kFont(14);
        self.contentLB.textColor = CharacterBlackColor;
        self.contentLB.text = @"安静万分感激";
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
